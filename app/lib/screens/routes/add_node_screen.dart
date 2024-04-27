import 'package:car/network/endpoint.dart';
import 'package:car/route/car_route_node.dart';
import 'package:car/storage/state.dart';
import 'package:car/widget/default/custom_app_bar.dart';
import 'package:car/widget/default/screen_container.dart';
import 'package:flutter/material.dart';

class AddNodeScreen extends StatefulWidget {

  final List<CarRouteNode> nodes;
  final Function(CarRouteNode) callback;

  const AddNodeScreen(this.nodes, this.callback, {super.key});

  @override
  State<AddNodeScreen> createState() => _AddNodeScreenState();
}

class _AddNodeScreenState extends State<AddNodeScreen> {

  double _sliderSpeedValue = Endpoint.maxSpeed.toDouble();
  double _sliderTimeValue = 10.toDouble();

  final Set<Direction> directions = {};

  @override
  Widget build(BuildContext context) {
    return DefaultScreenContainer([
      const CustomAppBar("STM32 Car Control"),
      const SizedBox(height: 120),
      GridView.count(
        crossAxisCount: 4,
        shrinkWrap: true,
        children: [
          GestureDetector(
            child: IconButton(
              icon: const Icon(Icons.arrow_upward),
              isSelected: directions.contains(Direction.forward),
              iconSize: 50, onPressed: () =>
                setState(() {
                  if (directions.contains(Direction.forward)) {
                    directions.remove(Direction.forward);
                    return;
                  }
                  directions.add(Direction.forward);
                }),
            ),
          ),
          GestureDetector(
            child: IconButton(
              icon: const Icon(Icons.arrow_downward),
              isSelected: directions.contains(Direction.backward),
              iconSize: 50, onPressed: () =>
                setState(() {
                  if (directions.contains(Direction.backward)) {
                    directions.remove(Direction.backward);
                    return;
                  }
                  directions.add(Direction.backward);
                }),
            ),
          ),
          GestureDetector(
            child: IconButton(
              icon: const Icon(Icons.arrow_left),
              isSelected: directions.contains(Direction.left),
              iconSize: 50, onPressed: () =>
                setState(() {
                  if (directions.contains(Direction.left)) {
                    directions.remove(Direction.left);
                    return;
                  }
                  directions.add(Direction.left);
                }),
            ),
          ),
          GestureDetector(
            child: IconButton(
              icon: const Icon(Icons.arrow_right),
              isSelected: directions.contains(Direction.right),
              iconSize: 50, onPressed: () =>
                setState(() {
                  if (directions.contains(Direction.right)) {
                    directions.remove(Direction.right);
                    return;
                  }
                  directions.add(Direction.right);
                }),
            ),
          )
        ],
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
          onChanged: (double value) =>
              setState(() {
                _sliderSpeedValue = value;
                //First set speed then click the button. Speed will saved in button click
              })
      ),
      const SizedBox(height: 20,),
      Text('Time : ${_sliderTimeValue.round()} seconds',
        style: (const TextStyle(color: Colors.black, fontSize: 30)),
      ),
      Slider(
          value: _sliderTimeValue,
          divisions: 9,
          // If we use more we spam the server with requests
          min: 1,
          max: 10,
          activeColor: Colors.indigoAccent,
          inactiveColor: Colors.indigo,
          onChanged: (double value) =>
              setState(() {
                _sliderTimeValue = value;
              })
      ),
      const SizedBox(height: 100,),
      IconButton(
        color: Colors.green,
        icon: const Icon(Icons.add),
        iconSize: 100, onPressed: _addNode,
      ),
    ]);
  }

  void _addNode() {
    var node = CarRouteNode(directions.toList(), _sliderSpeedValue.toInt(),
        _sliderTimeValue.toInt());
    widget.callback(node);

    Navigator.pop(context);
  }

}