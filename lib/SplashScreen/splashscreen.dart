import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dhwani/screens/bottom_bar.dart';

class PreSplash extends StatefulWidget {
  @override
  _PreSplashState createState() => _PreSplashState();
}

class _PreSplashState extends State<PreSplash> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this, duration: const Duration(seconds: 2));
    animation = CurvedAnimation(parent: controller, curve: Curves.decelerate);
    controller.repeat();

    startTimer();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void startTimer() {
    Timer(const Duration(seconds: 5), navigateToExample);
  }

  void navigateToExample() {
    Get.offAll(() => Example());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xff040117), Color(0xdd08092B)],
          ),
        ),
        child: Stack(
          children: [
            const Center(
              child: Image(
                image: AssetImage('assets/into/logo.png'),
              ),
            ),
            Center(
              child: RotationTransition(
                turns: animation,
                alignment: Alignment.center,
                child: const Image(
                  image: AssetImage('assets/into/ring2.png'),
                ),
              ),
            ),
            Center(
              child: RotationTransition(
                turns: animation,
                alignment: Alignment.center,
                child: const Image(
                  image: AssetImage('assets/into/ring1.png'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
