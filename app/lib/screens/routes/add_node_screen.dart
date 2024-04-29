import 'package:car/network/endpoint.dart';
import 'package:car/route/car_route_node.dart';
import 'package:car/storage/state.dart';
import 'package:car/widget/default/custom_app_bar.dart';
import 'package:car/widget/default/screen_container.dart';
import 'package:flutter/material.dart';

class AddNodeScreen extends StatefulWidget {

  final List<CarRouteNode> nodes;
  final CarRouteNode? copyNode;
  final Function(CarRouteNode) callback;

  const AddNodeScreen(this.nodes, this.callback, {super.key, this.copyNode});

  @override
  State<AddNodeScreen> createState() => _AddNodeScreenState();
}

class _AddNodeScreenState extends State<AddNodeScreen> {

  double _sliderSpeedValue = Endpoint.maxSpeed.toDouble();
  double _sliderTimeValue = 10.toDouble();
  Set<Direction> _directions = {};

  @override
  void initState() {
    super.initState();
    if(widget.copyNode != null) {
      _sliderSpeedValue = widget.copyNode!.speed.toDouble();
      _sliderTimeValue = widget.copyNode!.time.toDouble();
      _directions = widget.copyNode!.directions.toSet();
    }
  }

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
              isSelected: _directions.contains(Direction.forward),
              iconSize: 50, onPressed: () =>
                setState(() {
                  if (_directions.contains(Direction.forward)) {
                    _directions.remove(Direction.forward);
                    return;
                  }
                  _directions.add(Direction.forward);
                }),
            ),
          ),
          GestureDetector(
            child: IconButton(
              icon: const Icon(Icons.arrow_downward),
              isSelected: _directions.contains(Direction.backward),
              iconSize: 50, onPressed: () =>
                setState(() {
                  if (_directions.contains(Direction.backward)) {
                    _directions.remove(Direction.backward);
                    return;
                  }
                  _directions.add(Direction.backward);
                }),
            ),
          ),
          GestureDetector(
            child: IconButton(
              icon: const Icon(Icons.arrow_left),
              isSelected: _directions.contains(Direction.left),
              iconSize: 50, onPressed: () =>
                setState(() {
                  if (_directions.contains(Direction.left)) {
                    _directions.remove(Direction.left);
                    return;
                  }
                  _directions.add(Direction.left);
                }),
            ),
          ),
          GestureDetector(
            child: IconButton(
              icon: const Icon(Icons.arrow_right),
              isSelected: _directions.contains(Direction.right),
              iconSize: 50, onPressed: () =>
                setState(() {
                  if (_directions.contains(Direction.right)) {
                    _directions.remove(Direction.right);
                    return;
                  }
                  _directions.add(Direction.right);
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
    if(widget.copyNode != null) {
      widget.copyNode!.directions = _directions.toList();
      widget.copyNode!.speed = _sliderSpeedValue.toInt();
      widget.copyNode!.time = _sliderTimeValue.toInt();
      widget.callback(widget.copyNode!);
    } else {
      var node = CarRouteNode(_directions.toList(), _sliderSpeedValue.toInt(),
          _sliderTimeValue.toInt());
      widget.callback(node);
    }

    Navigator.pop(context);
  }

}