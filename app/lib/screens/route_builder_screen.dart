
import 'package:car/screens/main_screen.dart';
import 'package:flutter/material.dart';

import '../network/endpoint.dart';

class RouteBuilderScreen extends StatefulWidget {
  const RouteBuilderScreen({super.key});

  @override
  State<RouteBuilderScreen> createState() => _RouteBuildScreen();
}

class _RouteBuildScreen extends State<RouteBuilderScreen> {
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  double _sliderSpeedValue = Endpoint.maxSpeed.toDouble();
  double _sliderTimeValue = 5.toDouble();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      drawer: Drawer(
        child: ListView(
          children: [
            const Divider(thickness: 2,),
            ListTile(
              title: const Text('Startseite'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MainScreen()),);
              },),
            const Divider(thickness: 2,),
            ListTile(
              title: const Text('Route Builder'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const RouteBuilderScreen()),);
              },),
          ],
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 40.0,
                  vertical: 25,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.menu),
                      iconSize: 40,
                      color: Colors.black,
                      onPressed: () {
                        _globalKey.currentState?.openDrawer();
                      },
                    )
                  ],
                ),
              ),
              const SizedBox(height: 10),
              const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 40.0,
                  vertical: 0,
                ),
                child: Column(
                  children: [
                    Text('STM32 Car Controller',
                      style: (TextStyle(
                          fontSize: 25, fontWeight: FontWeight.w500)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 120),
              Container(
                child: GridView.count(
                  crossAxisCount: 4,
                  shrinkWrap: true,
                  children: [
                    GestureDetector(
                      child: IconButton(
                        icon: const Icon(Icons.arrow_upward),
                        iconSize: 50, onPressed: () {
                        //Add to List
                      },
                      ),
                    ),
                    GestureDetector(
                      child: IconButton(
                        icon: const Icon(Icons.arrow_downward),
                        iconSize: 50, onPressed: () {
                        //Add to List
                      },
                      ),
                    ),
                    GestureDetector(
                      child: IconButton(
                        icon: const Icon(Icons.arrow_left),
                        iconSize: 50, onPressed: () {
                        //Add to List
                      },
                      ),
                    ),
                    GestureDetector(
                      child: IconButton(
                        icon: const Icon(Icons.arrow_right),
                        iconSize: 50, onPressed: () {
                        //Add to List
                      },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Text('PWM : ${_sliderSpeedValue.round()}',
                style: (const TextStyle(color: Colors.black, fontSize: 30)),
              ),
              Slider(
                  value: _sliderSpeedValue,
                  divisions: 10,
                  // If we use more we spam the server with requests
                  min: Endpoint.driveMinSpeed.toDouble(),
                  max: Endpoint.maxSpeed.toDouble(),
                  activeColor: Colors.indigoAccent,
                  inactiveColor: Colors.indigo,
                  onChanged: (double value) {
                    _sliderSpeedValue = value;
                    //First set speed then click the button. Speed will saved in button click
                  }
              ),
              const SizedBox(height: 20,),
              Text('Time : ${_sliderTimeValue.round()} seconds',
                style: (const TextStyle(color: Colors.black, fontSize: 30)),
              ),
              Slider(
                  value: _sliderTimeValue,
                  divisions: 5,
                  // If we use more we spam the server with requests
                  min: 1,
                  max: 5,
                  activeColor: Colors.indigoAccent,
                  inactiveColor: Colors.indigo,
                  onChanged: (double value) {
                    _sliderTimeValue = value;
                  }
              ),
              const SizedBox(height: 100,),
              Container(
                child: IconButton(
                  color: Colors.green,
                  icon: const Icon(Icons.play_circle),
                  iconSize: 100, onPressed: () {
                          //run action list
                      },
                    ),
                  ),
                ],
              ),
            ),
        ),
      );
  }
}