import 'package:car/route/car_route.dart';
import 'package:car/screens/routes/add_route_screen.dart';
import 'package:car/screens/routes/edit_route_screen.dart';
import 'package:car/storage/app_storage.dart';
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

  late List<CarRoute> routes;

  @override
  void initState() {
    super.initState();
    routes = AppStorage.pullRoutes();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultScreenContainer([
      CustomAppBar("Route Builder", leading: IconButton(
        icon: const Icon(Icons.add),
        iconSize: 40,
        color: Colors.black,
        onPressed: _addRoute,
      )),
      const SizedBox(height: 25),
      Expanded(child: Scrollbar(
        child: ListView(
          children: [
            for (var route in routes) CarRouteListTile(route, _runRoute, _stopRoute, _editRoute)
          ],
        ),
      ))
    ]);
  }

  void _runRoute(CarRoute route) {
    setState(() {
      route.run();
    });
  }

  void _stopRoute(CarRoute route) {
    setState(() {
      CarRoute.stopCurrent();
    });
  }

  void _editRoute(CarRoute route) {
    Navigator.push(context, MaterialPageRoute(builder: (context) =>
        EditRouteScreen((route) =>
            setState(() {
              // If the user wants to delete the route
              routes.remove(route);
              AppStorage.writeRoutes(routes);
            }), (route) =>
            setState(() {
              AppStorage.writeRoutes(routes);
            }), route)));
  }

  void _addRoute() {
    Navigator.push(context, MaterialPageRoute(builder: (context) =>
        AddRouteScreen(routes, (route) =>
            setState(() {
              routes.add(route);
              AppStorage.writeRoutes(routes);
            }))));
  }

}
