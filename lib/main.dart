import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travalizer/login/login_service.dart';
import 'package:travalizer/pages/home.dart';
import 'package:travalizer/login/login.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'login/bloc/login_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login Example',
      routes: {
        '/login': (context) => LoginPage(),
        '/home': (context) => HomePage(), // Define your HomePage
      },
      home: BlocProvider(
        create: (context) => LoginBloc(),
        child: SafeArea(child: CheckAuth()),
      ),
    );
  }
}

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
