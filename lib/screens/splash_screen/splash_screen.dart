import 'dart:async';
import 'package:flutter/material.dart';
import 'package:khushi_creation/screens/auth/sign_up_screen.dart';
import 'package:khushi_creation/screens/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:khushi_creation/screens/welcome_screen/welcome_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNextScreen();
  }

  Future<void> _navigateToNextScreen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFirstTime = prefs.getBool('isFirstTime') ?? true;
    bool isSignedIn = prefs.getBool('isSignedIn') ?? false;

    // Wait for the splash screen duration
    await Future.delayed(const Duration(seconds: 3));

    if (isFirstTime) {
      prefs.setBool('isFirstTime', false);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => WelcomeScreen()),
      );
    } else if (isSignedIn) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => BottomNavBar()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SignUpScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: Center(
        child: Image.asset(
          'assets/images/splash_screen/logo.png',
          width: double.infinity,
          height: double.infinity,
        ),
      ),
    );
  }
}
