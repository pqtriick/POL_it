import "package:car/network/endpoint.dart";
import "package:car/storage/app_storage.dart";

enum Direction {
  forward,
  backward,
  right,
  left;

  factory Direction.fromJson(String json) => Direction.values.byName(json);
  String toJson() => name;
}

class CarState {

  static final Set<Direction> _directions = {};
  static int _preferredSpeed = Endpoint.maxSpeed;

  static Future sendUpdates(Set<Direction> directions, int preferredSpeed) async {
    int yDirection = 0;
    int xDirection = 0;

    if (directions.contains(Direction.forward)) yDirection++;
    if (directions.contains(Direction.backward)) yDirection--;
    if (directions.contains(Direction.right)) xDirection++;
    if (directions.contains(Direction.left)) xDirection--;

    var endpoint = AppStorage.pullEndpoint();
    if (xDirection == 0) { // Just FORWARD or BACKWARD
      if (yDirection == 0) {
        await endpoint.stopAll();
        return;
      }
      await endpoint.inDirectionWithSpeed(
          yDirection > 0 ? MotorDirection.forward : MotorDirection.backward,
          preferredSpeed);
    } else if (xDirection > 0) {
      if (yDirection == 0) { // Only RIGHT
        await endpoint.sendDirection(MotorSide.right, MotorDirection.backward);
        await endpoint.sendDirection(MotorSide.left, MotorDirection.forward);
        await endpoint.withSpeed(
            preferredSpeed.clamp(Endpoint.turnMinSpeed, Endpoint.maxSpeed));
        return;
      }

      // RIGHT and (FORWARD or BACKWARD)
      await endpoint.sendDirectionToAll(
          yDirection > 0 ? MotorDirection.forward : MotorDirection.backward);
      await endpoint.sendSpeed(MotorSide.right, Endpoint.standBySpeed);
      await endpoint.sendSpeed(MotorSide.left,
          preferredSpeed.clamp(Endpoint.turnMinSpeed, Endpoint.maxSpeed));
    } else if (xDirection < 0) {
      if (yDirection == 0) { // Only LEFT
        await endpoint.sendDirection(MotorSide.left, MotorDirection.backward);
        await endpoint.sendDirection(MotorSide.right, MotorDirection.forward);
        await endpoint.withSpeed(
            preferredSpeed.clamp(Endpoint.turnMinSpeed, Endpoint.maxSpeed));
        return;
      }

      // LEFT and (FORWARD or BACKWARD)
      await endpoint.sendDirectionToAll(
          yDirection > 0 ? MotorDirection.forward : MotorDirection.backward);
      await endpoint.sendSpeed(MotorSide.left, Endpoint.standBySpeed);
      await endpoint.sendSpeed(MotorSide.right,
          preferredSpeed.clamp(Endpoint.turnMinSpeed, Endpoint.maxSpeed));
      // TODO: Be smarted about the speed when turning: _preferredSpeed.clamp((Endpoint.maxSpeed - (Endpoint.maxSpeed / 5)).toInt(), Endpoint.maxSpeed)
    }
  }

  static void _sendUpdates() {
    sendUpdates(_directions, _preferredSpeed);
  }

  static void addDirection(Direction movement) {
    if (_directions.add(movement)) {
      _sendUpdates();
    }
  }

  static void removeDirection(Direction movement) {
    if (_directions.remove(movement)) {
      _sendUpdates();
    }
  }

  static void setPreferredSpeed(int speed) {
    if (_preferredSpeed == speed) return;

    _preferredSpeed = speed.clamp(Endpoint.driveMinSpeed, Endpoint.maxSpeed);
    _sendUpdates();
  }

}