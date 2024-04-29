import 'package:car/route/car_route_node.dart';

class CarRoute {

  String name;
  List<CarRouteNode> nodes;

  CarRoute(this.name, this.nodes);

  factory CarRoute.fromJson(Map<String, dynamic> json) {
    return CarRoute(json["name"], List<CarRouteNode>.from(
        json["nodes"].map((e) => CarRouteNode.fromJson(e))));
  }

  Map<String, dynamic> toJson() =>
      {
        "name": name,
        "nodes": nodes,
      };

}