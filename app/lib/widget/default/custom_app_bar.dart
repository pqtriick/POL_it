import "package:car/screens/main_screen.dart";
import "package:flutter/material.dart";

class CustomAppBar extends StatelessWidget {

  final String title;
  final Widget? leading;

  const CustomAppBar(this.title, {super.key, this.leading});

  @override
  Widget build(BuildContext context) {
    bool isSubMenu = Navigator.of(context).canPop();

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
                icon: Icon(isSubMenu ? Icons.arrow_back : Icons.menu),
                iconSize: 40,
                color: Colors.black,
                onPressed: () {
                  if (isSubMenu) {
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