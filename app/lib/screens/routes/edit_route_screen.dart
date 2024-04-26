import 'package:car/route/car_route.dart';
import 'package:car/route/car_route_node.dart';
import 'package:car/widget/default/custom_app_bar.dart';
import 'package:car/widget/default/screen_container.dart';
import 'package:car/widget/route/route_node_list_tile.dart';
import 'package:flutter/material.dart';

class EditRouteScreen extends StatefulWidget {

  final CarRoute route;

  const EditRouteScreen(this.route, {super.key});

  @override
  State<StatefulWidget> createState() => EditRouteScreenState();

}

class EditRouteScreenState extends State<EditRouteScreen> {

  late List<CarRouteNode> nodes = [CarRouteNode(NodeType.movement), CarRouteNode(NodeType.delay), CarRouteNode(NodeType.movement)];

  @override
  Widget build(BuildContext context) {
    return DefaultScreenContainer([
      CustomAppBar(widget.route.name, true, leading: IconButton(
        icon: const Icon(Icons.save),
        iconSize: 40,
        color: Colors.black,
        onPressed: () {},
      )),
      const SizedBox(height: 25),
      Expanded(child: Scrollbar(
        child: ListView(
          children: [
            for (var node in nodes) CarRouteNodeListTile(node)
          ],
        ),
      ))
    ]);
  }

}