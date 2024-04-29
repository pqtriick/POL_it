import 'package:car/storage/state.dart';

class CarRouteNode {

  List<Direction> directions;
  int speed;
  int time;

  CarRouteNode(this.directions, this.speed, this.time);

  factory CarRouteNode.fromJson(Map<String, dynamic> json) =>
      CarRouteNode(List<Direction>.from(
          json["directions"].map((e) => Direction.fromJson(e))), json["speed"],
          json["time"]);

  Map<String, dynamic> toJson() =>
      {
        "directions": directions,
        "speed": speed,
        "time": time
      };

  String generateInfoText() {
    final buffer = StringBuffer();

    for (var value in directions) {
      if (buffer.isEmpty) {
        buffer.write(value.name);
      } else {
        buffer.write(", ${value.name}");
      }
    }

    return buffer.toString();
  }

}