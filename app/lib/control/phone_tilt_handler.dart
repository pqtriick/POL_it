
import 'dart:ui';

import 'package:car/storage/state.dart';
import 'package:sensors_plus/sensors_plus.dart';

bool active = false;
double angle = 0.0;

class Tilt_Handler {

  static double getRot() {
    if (active) {
      accelerometerEvents.listen((AccelerometerEvent event) async {
        angle = event.x;
        sendDirection();
        Future.delayed(const Duration(milliseconds: 500));

      });
    }
    return angle;
  }

  static void setState() {
    active ? active = false : active = true;
    getRot();
  }

  static void sendDirection() {
    if (angle <= -9.81 && angle >= -6.94) {
      CarState.addDirection(Direction.right);
    } else if (angle <= 9.81 && angle >= 6.94) {
      CarState.addDirection(Direction.left);

    } else {
      CarState.removeDirection(Direction.left);
      CarState.removeDirection(Direction.right);
      CarState.addDirection(Direction.forward);
    }
  }
}



