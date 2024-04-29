
import 'dart:ui';

import 'package:car/storage/state.dart';
import 'package:sensors_plus/sensors_plus.dart';

class TiltHandler {

  static DateTime nextUpdate = DateTime.now();
  static const magicValue = 2.25;

  static void handleTilt(double x) {
    if(DateTime.now().isAfter(nextUpdate)) {
      nextUpdate = DateTime.now().add(const Duration(milliseconds: 200));
      if(x > magicValue) {
        CarState.addDirection(Direction.left);
      } else if(x < -magicValue) {
        CarState.addDirection(Direction.right);
      } else {
        CarState.removeDirection2(Direction.right, Direction.left);
      }
    }
  }

}



