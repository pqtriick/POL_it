import 'dart:convert';

import 'package:car/network/endpoint.dart';
import 'package:car/route/car_route.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppStorage {

  static const _keyEndpoint = "endpoint";
  static const _keyRoutes = "routes";

  static late SharedPreferences _preferences;
  static Endpoint? _endpointCache;
  static List<CarRoute>? _routesCache;

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static Future writeEndpoint(Endpoint endpoint) async {
    _endpointCache = endpoint;
    await _preferences.setString(_keyEndpoint, jsonEncode(endpoint));
  }

  static Future writeRoutes(List<CarRoute> routes) async {
    _routesCache = routes;
    await _preferences.setString(_keyRoutes, jsonEncode(routes));
  }

  static Endpoint pullEndpoint() {
    if (_endpointCache != null) {
      return _endpointCache!;
    }

    final data = _preferences.getString(_keyEndpoint);
    if (data != null) {
      _endpointCache = jsonDecode(data);
      return _endpointCache!;
    }
    return Endpoint("192.168.137.211:8000"); // Default value for testing and example
  }

  static List<CarRoute> pullRoutes() {
    if (_routesCache != null) {
      return _routesCache!;
    }

    final data = _preferences.getString(_keyRoutes);
    if (data != null) {
      List<dynamic> routes = jsonDecode(data);
      _routesCache =
      List<CarRoute>.from(routes.map((e) => CarRoute.fromJson(e)));
      return _routesCache!;
    }
    return [];
  }

}