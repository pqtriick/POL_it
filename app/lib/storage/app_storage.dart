import 'dart:convert';

import 'package:car/network/endpoint.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppStorage {

  static const _keyEndpoint = "endpoint";
  
  static late SharedPreferences _preferences;
  static Endpoint? _endpointCache;

  static Future init() async => _preferences = await SharedPreferences.getInstance();

  static Future writeEndpoint(Endpoint endpoint) async => await _preferences.setString(_keyEndpoint, jsonEncode(endpoint));

  static Endpoint? pullEndpoint() {
    if(_endpointCache != null) {
      return _endpointCache;
    }

    final data = _preferences.getString(_keyEndpoint);
    if(data != null) {
      _endpointCache = jsonDecode(data);
      return _endpointCache;
    }
    return Endpoint("192.168.0.144:8000");
    // TODO: Add UI for adding the address of the car return null;
  }

}