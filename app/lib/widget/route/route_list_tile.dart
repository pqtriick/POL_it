import 'package:car/route/car_route.dart';
import 'package:flutter/material.dart';

class CarRouteListTile extends StatelessWidget {

  final CarRoute route;
  final Function(CarRoute) runCallback;
  final Function(CarRoute) stopCallback;
  final Function(CarRoute) editCallback;

  const CarRouteListTile(this.route, this.runCallback, this.stopCallback, this.editCallback,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(route.name),
      subtitle: Text("${route.nodes.length} nodes"),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          route.isRunning() ? ElevatedButton(
            onPressed: () => stopCallback(route),
            child: const Icon(
                Icons.stop,
                color: Colors.blue
            ),
          ) : ElevatedButton(
            onPressed: () => runCallback(route),
            child: const Icon(
                Icons.play_arrow,
                color: Colors.green
            ),
          ),
          const SizedBox(width: 8), // Add some space between buttons
          ElevatedButton(
            onPressed: () => editCallback(route),
            child: const Icon(
                Icons.edit,
                color: Colors.black
            ),
          ),
        ],
      ),
    );
  }
}