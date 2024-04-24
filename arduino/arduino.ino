
#define right_top A0
#define right_bot A1
#define left_top A2
#define left_bot A3
#define speedPinR 
#define speedPinL 


int speed;
int pins[] = {A0, A1, A2, A3};

enum Direction {
  FORWARD,
  FORWARD_R,
  FORWARD_L,
  BACK,
  BACK_R,
  BACK_L
};

void setup() {

  pinMode(A0, OUTPUT);
  pinMode(A1, OUTPUT);
  pinMode(A2, OUTPUT);
  pinMode(A3, OUTPUT);
  
  analogWriteResolution(8);
  Serial.begin(9600);
  
}

void loop() {
  //move(getSpeed(), DIRECTION) //Direction is missing

}


void setSpeed(int s, int pin) {
  speed = s;
  analogWrite(pin, speed);
}

int getSpeed() {
  return speed;

}

void move(int s, Direction direction) {
  switch(direction) {
    case FORWARD:
      for (int i = 0; i < 4; i++) {
        digitalWrite(pins[i], 0);
        digitalWrite(right_bot, 1);
        digitalWrite(left_bot, 1);
        analogWrite(pins[i], s);
      }
      break;
    case FORWARD_R:
      for (int i = 0; i < 4; i++) {
        digitalWrite(pins[i], 0);
        digitalWrite(left_bot, 1);
        analogWrite(pins[i], s);
      }
      break;
    case FORWARD_L:
      for (int i = 0; i < 4; i++) {
        digitalWrite(pins[i], 0);
        digitalWrite(right_bot, 1);
        analogWrite(pins[i], s);
      } 
      break;
    case BACK:
      for (int i = 0; i < 4; i++) {
        digitalWrite(pins[i], 0);
        digitalWrite(right_top, 1);
        digitalWrite(left_top, 1);
        analogWrite(pins[i], s);
      } 
      break;
    case BACK_R:
      for (int i = 0; i < 4; i++) {
        digitalWrite(pins[i], 0);
        digitalWrite(right_top, 1);
        analogWrite(pins[i], s);
      }
      break;
    case BACK_L:
      for (int i = 0; i < 4; i++) {
        digitalWrite(pins[i], 0);
        digitalWrite(left_top, 1);
        analogWrite(pins[i], s);
      }
      break;
  } 

}



