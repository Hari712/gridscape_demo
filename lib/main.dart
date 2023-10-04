import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gridscape_demo/configure.dart';
import 'package:gridscape_demo/router.dart';
import 'package:gridscape_demo/utils/constants.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routeInformationParser: router.routeInformationParser,
      routerDelegate: router.routerDelegate,
      routeInformationProvider: router.routeInformationProvider,
      title: "BAPS FMS",
      theme: ThemeData.light().copyWith(
        primaryColor: AppColors.primary,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(backgroundColor: AppColors.primary, systemOverlayStyle: SystemUiOverlayStyle.light),
        floatingActionButtonTheme: FloatingActionButtonThemeData(backgroundColor: AppColors.primary),
      ),
    );
  }
}
