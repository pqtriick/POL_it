#define LED PA5

#define BUFFER_SIZE 255

static HardwareSerial* piSerial = new HardwareSerial(USART1);

void setup() {
  pinMode(LED, OUTPUT);

  Serial.begin(115200L);
  piSerial->begin(115200L);

  Serial.println("STM32 READY");
}

enum PacketType {
  MOTOR_DIRECTION,
  MOTOR_SPEED
};

void loop() {
  if(piSerial->available() > 0) {

    unsigned char buffer[BUFFER_SIZE];
    char size = readPacket(buffer);

    PacketType type = static_cast<PacketType>(buffer[0]);

    switch(type) {
      case PacketType::MOTOR_DIRECTION: {
        Serial.println("Direction");
        break;
      }
      case PacketType::MOTOR_SPEED: {
        Serial.println("Speed");
        break;
      }
    }

    for(int i = 0; i < BUFFER_SIZE; i++) {
      Serial.print(buffer[i]);
    }
    Serial.println();
  }
}

char readPacket(unsigned char* buffer) {
  char size = piSerial->read();
  if(size > BUFFER_SIZE) {
    // Packet is to big
    Serial.println("Frame is to big " + String((int)size) + " > 255");
    return -1;
  }

  piSerial->readBytes(buffer, size);
  Serial.println("Read frame of size " + String((int)size) + "...");
  return size;
}