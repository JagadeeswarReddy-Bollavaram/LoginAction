import 'package:flutter/material.dart';
import 'package:travalizer/src/data/services/login_service.dart';
import 'package:travalizer/src/presentation/pages/home.dart';
import 'package:travalizer/src/presentation/pages/login.dart';

class CheckAuth extends StatelessWidget {
  Future<bool> isLoggedIn() async {
    Map<String, String> map = await HiveStorageService().retrieveCredentials();
    String email = map['email'] ?? "";
    String password = map['password'] ?? "";
    return email.isNotEmpty && password.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: isLoggedIn(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator(
            color: Colors.blue,
          ); // Show a loading spinner
        } else {
          if (snapshot.data == true) {
            return HomePage();
          } else {
            return LoginPage();
          }
        }
      },
    );
  }
}
