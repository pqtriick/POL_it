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

  Future sendDirection(MotorSide side, MotorDirection direction) async {
    try {
      await _sendUpdate(
          Target.motor, [MotorValue.direction.name, side.name, direction.name]);
    } catch (_) {}
  }

  Future sendSpeed(MotorSide side, int speed) async {
    try {
      await _sendUpdate(
          Target.motor, [MotorValue.speed.name, side.name, speed.toString()]);
    } catch (_) {}
  }

  Future sendDirectionToAll(MotorDirection direction) async {
    for (var side in MotorSide.values) {
      await sendDirection(side, direction);
    }
  }

  Future inDirectionWithSpeed(MotorDirection direction, int speed) async {
    for (var side in MotorSide.values) {
      await sendDirection(side, direction);
      await sendSpeed(side, speed);
    }
  }

  Future withSpeed(int speed) async {
    for (var side in MotorSide.values) {
      await sendSpeed(side, speed);
    }
  }

  Future stopAll() async {
    for (var side in MotorSide.values) {
      await sendSpeed(side, 0);
    }
  }

  factory Endpoint.fromJson(Map<String, dynamic> json) =>
      Endpoint(json["address"]);

  Map<String, dynamic> toJson() => {"address": address};

}