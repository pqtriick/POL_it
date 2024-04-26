import 'package:car/route/car_route.dart';
import 'package:car/route/car_route_node.dart';
import 'package:flutter/material.dart';

class CarRouteNodeListTile extends StatelessWidget {

  final CarRouteNode node;

  const CarRouteNodeListTile(this.node, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(node.type.name),
      subtitle: const Text("2 nodes"),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ElevatedButton(
            onPressed: () {},
            child: const Icon(
                Icons.edit,
                color: Colors.black
            ),
          ),
          const SizedBox(width: 8), // Add some space between buttons
          ElevatedButton(
            onPressed: () {},
            child: const Icon(
                Icons.delete,
                color: Colors.black
            ),
          ),
        ],
      ),
    );
  }

}