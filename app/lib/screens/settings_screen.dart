
import 'package:car/network/endpoint.dart';
import 'package:car/storage/app_storage.dart';
import 'package:car/widget/default/custom_app_bar.dart';
import 'package:car/widget/default/screen_container.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {

  const SettingsScreen({super.key});

  @override
  State<StatefulWidget> createState() => SettingsScreenState();
}

class SettingsScreenState extends State<SettingsScreen> {

  static final addressController = TextEditingController();
  final Endpoint endpoint = AppStorage.pullEndpoint();

  @override
  void initState() {
    super.initState();
    addressController.text = endpoint.address;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultScreenContainer([
      CustomAppBar("Einstellungen", leading: IconButton(
        icon: const Icon(Icons.save),
        iconSize: 40,
        color: Colors.black,
        onPressed: _saveSettings,

      )),
      const SizedBox(height: 25),
      Padding(padding: const EdgeInsets.only(left: 20, right: 20),
          child: TextField(
              decoration: const InputDecoration(hintText: "IP Adresse"),
              controller: addressController))
    ]);
  }

  void _saveSettings() {
    if (addressController.text.isNotEmpty) {
      endpoint.address = addressController.text;
      AppStorage.writeEndpoint(endpoint);
      const snackBar = SnackBar(content: Text(
          "Einstellung wurde gespeichert."));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      const snackBar = SnackBar(content: Text(
          "Gebe eine richtige IP Adresse an."
      ));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

}
