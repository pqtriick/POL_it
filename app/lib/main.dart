import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    const String title = 'Car Controller';
    initState();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.blueGrey,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: const Color(0xFF4B606B),
          elevation: 0,
          title: const Text(title),
          titleTextStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.screen_rotation),
              color: Colors.white,
              iconSize: 40,
              tooltip: 'Activate phone negation',
              onPressed: (
                  //phone negotiation handler class here
                  ){
              }
            ),
            IconButton(
              icon: const Icon(Icons.format_list_bulleted_add),
              color: Colors.white,
              iconSize: 40,
              tooltip: 'Switch to move builder',
              onPressed: (

              ){},
            )
          ],
        ),
      ),
    );
  }
}

