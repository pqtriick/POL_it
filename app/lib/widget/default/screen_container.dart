import 'package:flutter/material.dart';

class DefaultScreenContainer extends StatelessWidget {

  final List<Widget> children;

  const DefaultScreenContainer(this.children, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/background.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: SafeArea( // SafeArea makes the icon not in the mobile app bar
              child: Column(
                  children: children
              )
          )
      ),
    );
  }

}