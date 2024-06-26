import "dart:async";

import "package:car/control/phone_tilt_handler.dart";
import "package:car/network/endpoint.dart";
import "package:car/storage/state.dart";
import "package:car/widget/default/custom_app_bar.dart";
import "package:car/widget/default/screen_container.dart";
import "package:flutter/material.dart";
import "package:sensors_plus/sensors_plus.dart";

class ManualControlScreen extends StatefulWidget {
  const ManualControlScreen({super.key});

  @override
  State<ManualControlScreen> createState() => _ManualControlScreenState();
}

class _ManualControlScreenState extends State<ManualControlScreen> {

  StreamSubscription<AccelerometerEvent>? _streamSubscription;

  double _sliderValue = Endpoint.maxSpeed.toDouble();

  @override
  Widget build(BuildContext context) {
    return DefaultScreenContainer([
      CustomAppBar("STM32 Auto Steuerung", leading: IconButton(
        icon: const Icon(Icons.screen_rotation),
        iconSize: 40,
        color: Colors.black,
        onPressed: _toggleTiltControls,
      )),
      const SizedBox(height: 25),
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
      Text("PWM : ${_sliderValue.round()}",
        style: (const TextStyle(color: Colors.black, fontSize: 30)),
      ),
      Slider(
        value: _sliderValue,
        divisions: 10,
        // If we use more we spam the server with requests
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
    ]);
  }

  void _toggleTiltControls() {
    if(_streamSubscription != null) {
      _streamSubscription!.cancel();
      _streamSubscription = null;
      CarState.reset();
      const snackBar = SnackBar(content: Text(
          "Handy dreh Modus deaktiviert."));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      _streamSubscription = accelerometerEventStream().listen((event) => TiltHandler.handleTilt(event.x));
      const snackBar = SnackBar(content: Text(
          "Handy dreh Modus aktiviert."));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    if(_streamSubscription != null) _streamSubscription!.cancel();
  }

}

