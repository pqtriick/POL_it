import 'package:car/route/car_route.dart';
import 'package:car/screens/routes/add_route_screen.dart';
import 'package:car/screens/routes/edit_route_screen.dart';
import 'package:car/widget/default/custom_app_bar.dart';
import 'package:car/widget/default/screen_container.dart';
import 'package:car/widget/route/route_list_tile.dart';
import 'package:flutter/material.dart';

class RouteBuilderScreen extends StatefulWidget {
  
  const RouteBuilderScreen({super.key});

  @override
  State<StatefulWidget> createState() => RouteBuilderScreenState();

}

class RouteBuilderScreenState extends State<RouteBuilderScreen> {

  late List<CarRoute> routes = [CarRoute("Test 1"), CarRoute("Test 2"), CarRoute("Test 2")];

  @override
  Widget build(BuildContext context) {
    return DefaultScreenContainer([
      CustomAppBar("Route Builder", false, leading: IconButton(
        icon: const Icon(Icons.add),
        iconSize: 40,
        color: Colors.black,
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const AddRouteScreen())),
      )),
      const SizedBox(height: 25),
      Expanded(child: Scrollbar(
        child: ListView(
          children: [
            for (var route in routes) CarRouteListTile(route, (route) {
              // When the play button is pressed
            }, (route) {
              // When the edit button is pressed
              Navigator.push(context, MaterialPageRoute(builder: (context) => EditRouteScreen(route)));
            })
          ],
        ),
      ))
    ]);
  }

}