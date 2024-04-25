
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'screens/main_site.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: title,
      home: main_site(),
    );
  }
}

