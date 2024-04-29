import 'package:car/route/car_route.dart';
import 'package:car/widget/default/custom_app_bar.dart';
import 'package:car/widget/default/screen_container.dart';
import 'package:flutter/material.dart';

class AddRouteScreen extends StatefulWidget {

  final List<CarRoute> routes;
  final Function(CarRoute) callback;

  const AddRouteScreen(this.routes, this.callback, {super.key});

  @override
  State<StatefulWidget> createState() => AddRouteScreenState();

}

class AddRouteScreenState extends State<AddRouteScreen> {

  static final nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return DefaultScreenContainer([
      CustomAppBar("Add route", leading: IconButton(
        icon: const Icon(Icons.save),
        iconSize: 40,
        color: Colors.black,
        onPressed: _addRoute,
      )),
      const SizedBox(height: 25),
      Padding(padding: const EdgeInsets.only(left: 20, right: 20),
          child: TextField(decoration: const InputDecoration(hintText: "Name"),
              controller: nameController))
    ]);
  }

  void _addRoute() {
    if (nameController.text.isEmpty) {
      const snackBar = SnackBar(content: Text(
          "Please enter a valid name"));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return;
    }
    if (!widget.routes.any((element) => element.name == nameController.text)) {
      var route = CarRoute(nameController.text, []);
      widget.callback(route);

      // Go back to overview
      Navigator.pop(context);

      // Empty input fields
      nameController.clear();
      return;
    }

    const snackBar = SnackBar(content: Text(
        "There is already a route with the same name"));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

}