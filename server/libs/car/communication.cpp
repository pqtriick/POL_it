#include "communication.hpp"

Connection::Connection(HardwareSerial* connectionSerial) {
    this->connectionSerial = connectionSerial;
}

void Connection::setup(int speed) {
    this->connectionSerial->begin(speed);
}

bool Connection::available() {
    return this->connectionSerial->available() > 0;
}

Packet* Connection::readPacket() {
    // Create buffer of size BUFFER_SIZE
    // Create space for the packet data
    unsigned char* buffer = new unsigned char[BUFFER_SIZE];

    unsigned char size = this->connectionSerial->read();
    if(size > BUFFER_SIZE) {
        // Packet is to big
        Serial.println("[ERROR] Frame is to big " + String((int)size) + " > 255");
        return nullptr;
    }

    this->connectionSerial->readBytes(buffer, size);
    return new Packet(buffer, size);
}

Packet::Packet(unsigned char* buffer, unsigned char size) {
    this->buffer = buffer;
    this->size = size;
}

Packet::~Packet() {
    delete[] this->buffer;
}

PacketType Packet::readType() {
    return static_cast<PacketType>(this->buffer[this->offset++]);
}

Direction Packet::readDirection() {
    return static_cast<Direction>(this->buffer[this->offset++]);
}

Side Packet::readSide() {
    return static_cast<Side>(this->buffer[this->offset++]);
}

unsigned char Packet::readByte() {
    return this->buffer[this->offset++];
}
