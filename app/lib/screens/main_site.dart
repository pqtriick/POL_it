import 'package:car/network/Endpoint.dart';
import 'package:flutter/material.dart';

class main_site extends StatefulWidget {
  main_site({super.key});

  @override
  State<main_site> createState() => _MainPageState();
}

class _MainPageState extends State<main_site> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/bg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea( //SafeArea makes the icon not in the mobile app bar
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 40.0,
                  vertical: 25,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      Icons.menu,
                      size: 40,
                      color: Colors.black,
                    ),
                    Icon(
                      Icons.screen_rotation,
                      size: 40,
                      color: Colors.black,
                    )
                  ],
                ),
              ),
              SizedBox(height: 10), //Space between icon and title
              const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 40.0,
                  vertical: 0,
                ),
                child: Column(
                  children: [
                    Text('STM32 Car Controller',
                        style: (TextStyle(fontSize: 25, fontWeight: FontWeight.w500)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 120), //Space Between Title and Button Container
              Container(
                padding: EdgeInsets.all(8),
                child: GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  children: [
                    GestureDetector(
                      child: IconButton(
                        icon: Icon(Icons.arrow_upward),
                        iconSize: 50, onPressed: () {  },
                      ),
                      onLongPressStart: (_) {
                        Endpoint().sendMotorDirection(Side.left, Direction.forward);
                        Endpoint().sendMotorDirection(Side.right, Direction.forward);
                        Endpoint().sendMotorSpeed(Side.left, 130);
                        Endpoint().sendMotorSpeed(Side.right, 130);
                      },
                      onLongPressEnd: (_) {
                        Endpoint().sendMotorSpeed(Side.left, 0);
                        Endpoint().sendMotorSpeed(Side.right, 0);
                      },
                    ),
                    GestureDetector(
                      child: IconButton(
                        icon: Icon(Icons.arrow_downward),
                        iconSize: 50, onPressed: () {  },
                      ),
                      onLongPressStart: (_) {
                        Endpoint().sendMotorDirection(Side.left, Direction.backward);
                        Endpoint().sendMotorDirection(Side.right, Direction.backward);
                        Endpoint().sendMotorSpeed(Side.left, 255);
                        Endpoint().sendMotorSpeed(Side.right, 255);
                      },
                      onLongPressEnd: (_) {
                        Endpoint().sendMotorSpeed(Side.left, 0);
                        Endpoint().sendMotorSpeed(Side.right, 0);
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.arrow_left),
                      iconSize: 80,
                      onPressed: () {
                        // Action for the third button
                        print('Third button pressed!');
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.arrow_right),
                      iconSize: 80,
                      onPressed: () {
                        // Action for the fourth button
                        print('Fourth button pressed!');
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
