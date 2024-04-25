import 'package:car/app.dart';
import 'package:car/storage/app_storage.dart';
import 'package:flutter/material.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppStorage.init();

  runApp(const CarControlApp());
}


