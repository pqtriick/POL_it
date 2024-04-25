import 'package:http/http.dart' as http;

enum Direction {
  forward,
  backward
}

enum Side {
  right,
  left
}

class Endpoint {

  Future<http.Response> sendMotorDirection(Side side, Direction direction) {
    var url = "http://192.168.0.144:8000/motor/direction/${side.name}/${direction.name}";
    print(url);
    return http.get(Uri.parse(url));
  }

  Future<http.Response> sendMotorSpeed(Side side, int speed) {
    return http.get(Uri.parse("http://192.168.0.144:8000/motor/speed/${side.name}/$speed"));
  }

}