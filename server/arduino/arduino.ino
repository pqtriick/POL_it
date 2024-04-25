#include "communication.hpp"
#include "motor.hpp"

static HardwareSerial* piSerial = new HardwareSerial(USART1);
static Connection* connection = new Connection(piSerial);

static Motor* rightSide = new Motor("Right", A1, A0, A2);
static Motor* leftSide = new Motor("Left", A3, A4, A5);

void setup() {
  // Setup debug connection to computer
  Serial.begin(115200L);
  Serial.println("[INIT]");

  // Setup motors
  rightSide->init();
  leftSide->init();

  // Setup connection to Raspberry PI over USART
  connection->setup(115200L);

  Serial.println("[INIT] OK");
}

void loop() {
  // Check if packet is available
  if(connection->available()) {
    // Read packet from USART
    Packet* packet = connection->readPacket();
    // Handle the packet
    handlePacket(packet);

    // FREE: We have to free the packet!
    delete packet;
  }
}

void changeMotorSpeed(Side side, unsigned char speed) {
  Motor* motor = sideToMotor(side);
  motor->setSpeed(speed);
}

void changeMotorDirection(Side side, Direction direction) {
  Motor* motor = sideToMotor(side);
  motor->setDirection(direction);
}

Motor* sideToMotor(Side side) {
  switch(side) {
    case Side::RIGHT: {
      return rightSide;
    }
    case Side::LEFT: {
      return leftSide;
    }
  }
}

void handlePacket(Packet* packet) {
  PacketType type = packet->readType();

  switch(type) {
    case PacketType::MOTOR_DIRECTION: {
      Side side = packet->readSide();
      Direction direction = packet->readDirection();
      changeMotorDirection(side, direction);
      break;
    }
    case PacketType::MOTOR_SPEED: {
      Side side = packet->readSide();
      unsigned char speed = packet->readByte();
      changeMotorSpeed(side, speed);
      break;
    }
  }
}