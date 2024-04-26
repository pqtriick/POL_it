import 'package:car/network/endpoint.dart';
import 'package:car/screens/main_screen.dart';
import 'package:car/storage/state.dart';
import 'package:flutter/material.dart';

class ManualControlScreen extends StatefulWidget {
  const ManualControlScreen({super.key});

  @override
  State<ManualControlScreen> createState() => _ManualControlScreenState();
}


class _ManualControlScreenState extends State<ManualControlScreen> {

  double _sliderValue = Endpoint.maxSpeed.toDouble();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/background.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: SafeArea( //SafeArea makes the icon not in the mobile app bar
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
                        MainScreen.globalKey.currentState?.openDrawer();
                      }
                  ),
                  IconButton(
                    icon: const Icon(Icons.screen_rotation),
                    iconSize: 40,
                    color: Colors.black,
                    onPressed: () {},
                  )
                ],
              ),
            ),
            const SizedBox(height: 10),
            //Space between icon and title
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
            //Space Between Title and Button Container
            Container(
              padding: const EdgeInsets.all(8),
              child: GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                children: [
                  GestureDetector(
                    child: IconButton(
                      icon: const Icon(Icons.arrow_upward),
                      iconSize: 50, onPressed: () {},
                    ),
                    onTapDown: (_) => CarState.addDirection(Direction.forward),
                    onTapCancel: () => CarState.removeDirection(Direction.forward),
                  ),
                  GestureDetector(
                    child: IconButton(
                      icon: const Icon(Icons.arrow_downward),
                      iconSize: 50, onPressed: () {},
                    ),
                    onTapDown: (_) => CarState.addDirection(Direction.backward),
                    onTapCancel: () => CarState.removeDirection(Direction.backward),
                  ),
                  GestureDetector(
                    child: IconButton(
                      icon: const Icon(Icons.arrow_left),
                      iconSize: 80, onPressed: () {},
                    ),
                    onTapDown: (_) => CarState.addDirection(Direction.left),
                    onTapCancel: () => CarState.removeDirection(Direction.left),
                  ),
                  GestureDetector(
                    child: IconButton(
                      icon: const Icon(Icons.arrow_right),
                      iconSize: 80, onPressed: () {},
                    ),
                    onTapDown: (_) => CarState.addDirection(Direction.right),
                    onTapCancel: () => CarState.removeDirection(Direction.right),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 50),
            Text('PWM : ${_sliderValue.round()}',
              style: (const TextStyle(color: Colors.black, fontSize: 30)),
            ),
            Slider(
              value: _sliderValue,
              divisions: 10, // If we use more we spam the server with requests
              min: Endpoint.driveMinSpeed.toDouble(),
              max: Endpoint.maxSpeed.toDouble(),
              activeColor: Colors.indigoAccent,
              inactiveColor: Colors.indigo,
              onChanged: (double value) {
                setState(() {
                  _sliderValue = value;
                  CarState.setPreferredSpeed(value.toInt());
                });
              },
            )
          ],
        ),
      ),
    );
  }
}

