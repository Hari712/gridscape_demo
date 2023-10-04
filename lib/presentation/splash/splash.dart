import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gridscape_demo/presentation/map/map.dart';

class SplashScreen extends StatefulWidget {
  static String path = "/";
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    if (mounted) {
      GoRouter.of(context).go(MapScreen.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text("Splash Screen")));
  }
}
