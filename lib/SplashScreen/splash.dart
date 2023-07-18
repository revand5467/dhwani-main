import 'dart:async';
import 'package:dhwani/controller/login_controller.dart';
import 'package:dhwani/screens/bottom_bar.dart';
import 'package:dhwani/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

final controller = Get.put(LoginController());

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var val = false;
  Future<void> getShared() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    val = prefs.get('isLoggedIn') as bool;
    // return prefs.getBool('isLoggedIn') ?? false;
  }

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
    //print(controller.googleAccount.value);
    //const val =  getShared();
    print("val");
    print(val);
    getShared;
    if (controller.logged.value == true && val == true) {
      Get.to(() => Example());
    } else {
      Get.to(() => login());
    }
    Get.to(() => login());
    // Navigator.pushReplacement(
    //   context,
    //   MaterialPageRoute(builder: (context) => login()),
    // );
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
              CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFF3D6F5))),
          ],
        ),
      ),
    );
  }
}
