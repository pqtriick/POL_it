#ifndef MOTOR_LIB
#define MOTOR_LIB

#include <Arduino.h>
#include <communication.hpp>

class Motor {
  public:
    String name;
  private:
    int enablePin;
    int input1;
    int input2;
    unsigned char speed;
    Direction direction;
  public:
    Motor(const char* name, int enablePin, int input1, int input2);
    void init();
    void setSpeed(unsigned char speed);
    unsigned char getSpeed();
    void setDirection(Direction direction);
    Direction getDirection();
};

#endif