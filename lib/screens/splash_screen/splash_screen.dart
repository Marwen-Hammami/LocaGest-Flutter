import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
// import 'package:myapp/screens/signin_screen/sign_in_screen.dart';

class SplashScreen extends StatefulWidget {
  //Route
  static const String routeName = "/";

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  //init
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 5), () {
      // Navigator.pushNamed(context, SignInScreen.routeName);
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  //build
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Icon(
          Icons.brightness_auto,
          size: 100,
        ),
      ),
    );
  }
}
