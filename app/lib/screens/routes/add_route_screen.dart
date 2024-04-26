import 'package:car/widget/default/custom_app_bar.dart';
import 'package:car/widget/default/screen_container.dart';
import 'package:flutter/material.dart';

class AddRouteScreen extends StatefulWidget {
  const AddRouteScreen({super.key});

  @override
  State<StatefulWidget> createState() => AddRouteScreenState();

}

class AddRouteScreenState extends State<AddRouteScreen> {

  @override
  Widget build(BuildContext context) {
    return DefaultScreenContainer([
      CustomAppBar("Add route", true, leading: IconButton(
        icon: const Icon(Icons.save),
        iconSize: 40,
        color: Colors.black,
        onPressed: () {},
      )),
      const SizedBox(height: 25),
    ]);
  }

}