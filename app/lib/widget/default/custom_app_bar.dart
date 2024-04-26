import 'package:car/screens/main_screen.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {

  final String title;
  final bool subMenu;
  final Widget? leading;

  const CustomAppBar(this.title, this.subMenu, {super.key, this.leading});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 40.0,
            vertical: 25,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: Icon(subMenu ? Icons.arrow_left : Icons.menu),
                iconSize: 40,
                color: Colors.black,
                onPressed: () {
                  if(subMenu) {
                    Navigator.pop(context);
                  } else {
                    MainScreen.globalKey.currentState?.openDrawer();
                  }
                },
              ),
              if(leading != null) leading!
            ],
          ),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 40.0,
            vertical: 0,
          ),
          child: Column(
            children: [
              Text(title,
                style: (const TextStyle(
                    fontSize: 25, fontWeight: FontWeight.w500)),
              ),
            ],
          ),
        ),
      ],
    );
  }

}