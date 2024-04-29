import 'package:car/route/car_route_node.dart';
import 'package:car/storage/app_storage.dart';

class CarRoute {

  static CarRoute? runningRoute;

  String name;
  List<CarRouteNode> nodes;

  CarRoute(this.name, this.nodes);

  Future run(Function(void Function()) setState) async {
    runningRoute = this;
    await _runInternal(setState);
  }

  Future _runInternal(Function(void Function()) setState) async {
    var endpoint = AppStorage.pullEndpoint();
    for (var node in nodes) {
      if(runningRoute != this) break;
      await node.runNode();
    }
    await endpoint.stopAll();
    stopCurrent();
    setState(() {});
  }

  bool isRunning() {
    return runningRoute == this;
  }

  static void stopCurrent() {
    runningRoute = null;
  }

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