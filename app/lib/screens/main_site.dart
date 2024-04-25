import 'package:car/network/Endpoint.dart';
import 'package:flutter/material.dart';

class main_site extends StatefulWidget {
  main_site({super.key});

  @override
  State<main_site> createState() => _MainPageState();
}


class _MainPageState extends State<main_site> {

  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  double slidervalue = 128.0;

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
              onTap: (){
                print('Menu click');
              },),
            const Divider(thickness: 2,),
            ListTile(title: const Text('Route Builder'),
              onTap: (){
                print('Menu click');
              },),
            const Divider(thickness: 2,),

          ],
        ),
      ),
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
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 40.0,
                  vertical: 25,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(Icons.menu),
                      iconSize: 40,
                      color: Colors.black,
                      onPressed: (){
                        _globalKey.currentState?.openDrawer();
                      }
                    ),
                    IconButton(
                      icon: Icon(Icons.screen_rotation),
                      iconSize: 40,
                      color: Colors.black,
                      onPressed: () {  },
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
                        Endpoint().sendMotorSpeed(Side.left, slidervalue as int);
                        Endpoint().sendMotorSpeed(Side.right, slidervalue as int);
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
                        Endpoint().sendMotorSpeed(Side.left, slidervalue as int);
                        Endpoint().sendMotorSpeed(Side.right, slidervalue as int);
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
              const SizedBox(height: 50),
              Text('PWM : ${slidervalue.round()}',
              style: (const TextStyle(color: Colors.black, fontSize: 30)),
              ),
              Slider(
                value: slidervalue,
                divisions: 127,
                min: 128,
                max: 255,
                activeColor: Colors.indigoAccent,
                inactiveColor: Colors.indigo,
                onChanged: (double value) {
                  setState(() {
                    slidervalue = value;
                  });
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

