import 'package:http/http.dart' as http;

enum MotorDirection {
  forward,
  backward
}

enum MotorSide {
  right,
  left
}

enum MotorValue {
  direction,
  speed
}

enum Target {
  motor
}

class Endpoint {

  static const int standBySpeed = 50;
  static const int driveMinSpeed = 125;
  static const int turnMinSpeed = 160;
  static const int maxSpeed = 255;

  String address;

  // TODO: Auth: String token;

  Endpoint(this.address);

  Future<http.Response> _sendUpdate(Target target, List<String> data) {
    final buffer = StringBuffer("http://$address/${target.name}");
    for (var value in data) {
      buffer.write("/$value");
    }
    return http.get(Uri.parse(buffer.toString()));
  }

  void sendDirection(MotorSide side, MotorDirection direction) async {
    try {
      await _sendUpdate(
          Target.motor, [MotorValue.direction.name, side.name, direction.name]);
    } catch (_) {}
  }

  void sendSpeed(MotorSide side, int speed) async {
    try {
      await _sendUpdate(
          Target.motor, [MotorValue.speed.name, side.name, speed.toString()]);
    } catch (_) {}
  }

  void sendDirectionToAll(MotorDirection direction) {
    for (var side in MotorSide.values) {
      sendDirection(side, direction);
    }
  }

  void inDirectionWithSpeed(MotorDirection direction, int speed) {
    for (var side in MotorSide.values) {
      sendDirection(side, direction);
      sendSpeed(side, speed);
    }
  }

  void withSpeed(int speed) {
    for (var side in MotorSide.values) {
      sendSpeed(side, speed);
    }
  }

  void stopAll() {
    for (var side in MotorSide.values) {
      sendSpeed(side, 0);
    }
  }

  factory Endpoint.fromJson(Map<String, dynamic> json) =>
      Endpoint(json["address"]);

  Map<String, dynamic> toJson() => {"address": address};

}