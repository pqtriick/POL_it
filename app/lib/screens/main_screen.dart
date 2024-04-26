import 'package:car/screens/manual_control_screen.dart';
import 'package:car/screens/route_builder/add_node_screen.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  static final GlobalKey<ScaffoldState> globalKey = GlobalKey<ScaffoldState>();

  @override
  State<MainScreen> createState() => _MainScreenState();
}


class _MainScreenState extends State<MainScreen> {

  List<Widget> screens = [const ManualControlScreen(), const AddNodeScreen()];
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: MainScreen.globalKey,
      drawer: Drawer(
        child: ListView(
          children: [
            const Divider(thickness: 2),
            ListTile(
              title: const Text('Startseite'),
              onTap: () => _setPage(0)),
            const Divider(thickness: 2),
            ListTile(title: const Text('Route Builder'),
              onTap: () => _setPage(1)),
            const Divider(thickness: 2),
          ],
        ),
      ),
      body: _getBody(),
    );
  }

  void _setPage(int index) {
    MainScreen.globalKey.currentState?.closeDrawer();
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _getBody() {
    if(_selectedIndex == 1) {
      return const AddNodeScreen();
    } else {
      return const ManualControlScreen();
    }
  }
}

