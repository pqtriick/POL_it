#include "motor.hpp"

Motor::Motor(const char* name, int enablePin, int input1, int input2) {
  this->name = String(name);
  this->enablePin = enablePin;
  this->input1 = input1;
  this->input2 = input2;
}

void Motor::init() {
  pinMode(this->enablePin, OUTPUT);
  pinMode(this->input1, OUTPUT);
  pinMode(this->input2, OUTPUT);
  Serial.println("Motor[" + String(name) + "] was setup");
  setSpeed(0);
}

void Motor::setSpeed(unsigned char speed) {
  this->speed = speed;
  analogWrite(this->enablePin, speed);
  Serial.println("The speed of the Motor[" + String(name) + "] was set to " + String(this->speed));
}

unsigned char Motor::getSpeed() {
  return this->speed;
}

void Motor::setDirection(Direction direction) {
  this->direction = direction;
  digitalWrite(this->input1, direction == Direction::FORWARD);
  digitalWrite(this->input2, direction != Direction::FORWARD);
  Serial.println("The spin direction of the Motor[" + String(name) + "] was set to " + String(this->direction));
}

Direction Motor::getDirection() {
  return this->direction;
}