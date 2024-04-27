import 'package:car/network/endpoint.dart';
import 'package:car/storage/app_storage.dart';

enum Direction {
  forward,
  backward,
  right,
  left;

  factory Direction.fromJson(String json) => Direction.values.byName(json);
  String toJson() => name;
}

class CarState {

  static final Set<Direction> directions = {};
  static int _preferredSpeed = Endpoint.maxSpeed;

  static void _sendUpdates() {
    int yDirection = 0;
    int xDirection = 0;

    if (directions.contains(Direction.forward)) yDirection++;
    if (directions.contains(Direction.backward)) yDirection--;
    if (directions.contains(Direction.right)) xDirection++;
    if (directions.contains(Direction.left)) xDirection--;

    var endpoint = AppStorage.pullEndpoint();
    if (endpoint == null) return;

    print("x: $xDirection y: $yDirection directions: $directions");

    if (xDirection == 0) { // Just FORWARD or BACKWARD
      if (yDirection == 0) {
        endpoint.stopAll();
        return;
      }
      endpoint.inDirectionWithSpeed(
          yDirection > 0 ? MotorDirection.forward : MotorDirection.backward,
          _preferredSpeed);
    } else if (xDirection > 0) {
      if (yDirection == 0) { // Only RIGHT
        endpoint.sendDirection(MotorSide.right, MotorDirection.backward);
        endpoint.sendDirection(MotorSide.left, MotorDirection.forward);
        endpoint.withSpeed(
            _preferredSpeed.clamp(Endpoint.turnMinSpeed, Endpoint.maxSpeed));
        return;
      }

      // RIGHT and (FORWARD or BACKWARD)
      endpoint.sendDirectionToAll(
          yDirection > 0 ? MotorDirection.forward : MotorDirection.backward);
      endpoint.sendSpeed(MotorSide.right, Endpoint.standBySpeed);
      endpoint.sendSpeed(MotorSide.left,
          _preferredSpeed.clamp(Endpoint.turnMinSpeed, Endpoint.maxSpeed));
    } else if (xDirection < 0) {
      if (yDirection == 0) { // Only LEFT
        endpoint.sendDirection(MotorSide.left, MotorDirection.backward);
        endpoint.sendDirection(MotorSide.right, MotorDirection.forward);
        endpoint.withSpeed(
            _preferredSpeed.clamp(Endpoint.turnMinSpeed, Endpoint.maxSpeed));
        return;
      }

      // LEFT and (FORWARD or BACKWARD)
      endpoint.sendDirectionToAll(
          yDirection > 0 ? MotorDirection.forward : MotorDirection.backward);
      endpoint.sendSpeed(MotorSide.left, Endpoint.standBySpeed);
      endpoint.sendSpeed(MotorSide.right,
          _preferredSpeed.clamp(Endpoint.turnMinSpeed, Endpoint.maxSpeed));
      // TODO: Be smarted about the speed when turning: _preferredSpeed.clamp((Endpoint.maxSpeed - (Endpoint.maxSpeed / 5)).toInt(), Endpoint.maxSpeed)
    }
  }

  static void addDirection(Direction movement) {
    if (directions.add(movement)) {
      _sendUpdates();
    }
  }

  static void removeDirection(Direction movement) {
    if (directions.remove(movement)) {
      _sendUpdates();
    }
  }

  static void setPreferredSpeed(int speed) {
    if (_preferredSpeed == speed) return;

    _preferredSpeed = speed.clamp(Endpoint.driveMinSpeed, Endpoint.maxSpeed);
    _sendUpdates();
  }

}