import "package:car/route/car_route_node.dart";
import "package:flutter/material.dart";

class CarRouteNodeListTile extends StatelessWidget {

  final CarRouteNode node;
  final Function(CarRouteNode) editCallback;
  final Function(CarRouteNode) deleteCallback;

  const CarRouteNodeListTile(this.node, this.editCallback, this.deleteCallback,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(node.directions.isNotEmpty
          ? "Bewege für ${node.time} ms"
          : "Warte für ${node.time} ms"),
      subtitle: Text(
          node.directions.isEmpty ? "Keine Bewegung" : node.generateInfoText()),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ElevatedButton(
            onPressed: () => editCallback(node),
            child: const Icon(
                Icons.edit,
                color: Colors.black
            ),
          ),
          const SizedBox(width: 8), // Add some space between buttons
          ElevatedButton(
            onPressed: () => deleteCallback(node),
            child: const Icon(
                Icons.delete,
                color: Colors.red
            ),
          ),
        ],
      ),
    );
  }
}