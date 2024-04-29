import 'package:car/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CarControlApp extends StatelessWidget {
  const CarControlApp({super.key});

  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    const String title = 'Car Controller';
    initState();
    return const MaterialApp(
      title: title,
      home: MainScreen(),
    );
  }
}