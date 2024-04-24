#include "communication.hpp"

static HardwareSerial* piSerial = new HardwareSerial(USART1);
static Connection* connection = new Connection(piSerial);

void setup() {
  connection->setup(115200L);

  Serial.begin(115200L);
  Serial.println("STM32 READY");
}

void loop() {
  if(connection->available()) {
    Packet* packet = connection->readPacket();
    PacketType type = packet->readType();

    switch(type) {
      case PacketType::MOTOR_DIRECTION: {
        Side side = packet->readSide();
        Direction direction = packet->readDirection();
        if(side == Side::RIGHT && direction == Direction::FORWARD) {
          Serial.println("YES!!");
        }
        Serial.println("Direction");
        break;
      }
      case PacketType::MOTOR_SPEED: {
        Serial.println("Speed");
        break;
      }
    }

    // We have to free the packet!
    delete packet;
  }
}