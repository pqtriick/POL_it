import "package:car/route/car_route.dart";
import "package:car/route/car_route_node.dart";
import "package:car/screens/routes/add_node_screen.dart";
import "package:car/widget/default/custom_app_bar.dart";
import "package:car/widget/default/screen_container.dart";
import "package:car/widget/route/route_node_list_tile.dart";
import "package:flutter/material.dart";

class EditRouteScreen extends StatefulWidget {

  final CarRoute route;
  final Function(CarRoute) deleteCallback;
  final Function(CarRoute) saveCallback;

  const EditRouteScreen(this.deleteCallback, this.saveCallback, this.route, {super.key});

  @override
  State<StatefulWidget> createState() => EditRouteScreenState();

}

class EditRouteScreenState extends State<EditRouteScreen> {

  @override
  Widget build(BuildContext context) {
    return DefaultScreenContainer([
      CustomAppBar(widget.route.name, leading: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.delete),
            iconSize: 40,
            color: Colors.black,
            onPressed: _deleteRoute,
          ),
          IconButton(
            icon: const Icon(Icons.save),
            iconSize: 40,
            color: Colors.black,
            onPressed: _saveRoute,
          ),
          IconButton(
            icon: const Icon(Icons.add),
            iconSize: 40,
            color: Colors.black,
            onPressed: _addNode,
          )
        ],
      )),
      const SizedBox(height: 25),
      Expanded(child: Scrollbar(
        child: ListView(
          children: [
            for (var node in widget.route.nodes) CarRouteNodeListTile(
                node, _editNode, _deleteNode)
          ],
        ),
      ))
    ]);
  }

  void _editNode(CarRouteNode node) {
    Navigator.push(context, MaterialPageRoute(builder: (context) =>
        AddNodeScreen(
            widget.route.nodes, (node) => setState(() {}), copyNode: node)));
  }

  void _deleteNode(CarRouteNode node) {
    setState(() {
      widget.route.nodes.remove(node);
    });
  }

  void _addNode() {
    Navigator.push(context, MaterialPageRoute(builder: (context) =>
        AddNodeScreen(widget.route.nodes, (node) =>
            setState(() {
              widget.route.nodes.add(node);
            }))));
  }

  void _deleteRoute() {
    Navigator.pop(context);
    widget.deleteCallback(widget.route);
  }

  void _saveRoute() {
    Navigator.pop(context);
    widget.saveCallback(widget.route);
  }

}