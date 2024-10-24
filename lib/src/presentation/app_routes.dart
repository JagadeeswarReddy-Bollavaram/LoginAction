import 'package:flutter/material.dart';
import 'package:travalizer/src/presentation/pages/home.dart';
import 'package:travalizer/src/presentation/pages/login.dart';

class AppRoutes {
  static const String login = '/login';
  static const String home = '/home';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      login: (context) => LoginPage(),
      home: (context) => HomePage(),
    };
  }
}
