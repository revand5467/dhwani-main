import 'dart:async';
import 'package:dhwani/screens/bottom_bar.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _isLoading = true;
  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    Timer(const Duration(seconds: 3), navigateToHome);
  }

  void navigateToHome() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Example()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF130C2E),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/into/logo.png', // Replace this with your logo image path
              width: 200,
              height: 200,
            ),
            const SizedBox(height: 20),
            if (_isLoading)
              CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFF3D6F5))),
          ],
        ),
      ),
    );
  }
}
