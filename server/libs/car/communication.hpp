#ifndef COMMUNICATION_LIB
#define COMMUNICATION_LIB

#include <Arduino.h>

#define BUFFER_SIZE 255

enum Side {
    RIGHT,
    LEFT
};

enum Direction {
    FORWARD,
    BACKWARD
};

enum PacketType {
    MOTOR_DIRECTION,
    MOTOR_SPEED
};

class Packet {
    private:
        unsigned char* buffer;
        unsigned char size;
        unsigned char offset = 0;
    public:
        Packet(unsigned char* buffer, unsigned char size);
        PacketType readType();
        Direction readDirection();
        Side readSide();
        unsigned char readByte();
};

class Connection {
    private:
        HardwareSerial* connectionSerial;
    public:
        Connection(HardwareSerial* connectionSerial);
        void setup(int speed);
        bool available();
        Packet* readPacket();
};

#endif