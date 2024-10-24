import 'package:flutter/material.dart';

import '../../data/services/login_service.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(child: SizedBox(width: 10)),
            IconButton(
              onPressed: () async {
                await HiveStorageService().clearCredentials();
                Navigator.pushReplacementNamed(context, "/login");
              },
              icon: const Icon(Icons.logout_outlined),
            ),
          ],
        ),
        // actions: [],
      ),
      body: const SizedBox(
        child: Center(
          child: Text("Welcome to Meragi",
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 32)),
        ),
      ),
    );
  }
}
