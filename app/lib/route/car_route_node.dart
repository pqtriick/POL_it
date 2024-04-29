import "package:car/storage/state.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/scheduler.dart";

class CarRouteNode {

  List<Direction> directions;
  int speed;
  int time;

  CarRouteNode(this.directions, this.speed, this.time);

  Future runNode() async {
    await CarState.sendUpdates(directions.toSet(), speed);
    await Future.delayed(Duration(milliseconds: time));
  }

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

}