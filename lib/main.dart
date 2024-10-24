import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travalizer/src/presentation/app_routes.dart';
import 'package:travalizer/src/presentation/pages/check_auth.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'src/presentation/bloc/login/login_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: AppRoutes.getRoutes(),
      home: BlocProvider(
        create: (context) => LoginBloc(),
        child: SafeArea(child: CheckAuth()),
      ),
    );
  }
}
