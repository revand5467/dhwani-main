
import 'package:dhwani/screens/bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';


class presplash extends StatefulWidget {
  @override
  _preSplashState createState() => _preSplashState();
}

class _preSplashState extends State<presplash> with TickerProviderStateMixin {
  late AnimationController controller, cntrlr2;
  late Animation<double> animation, animatn2;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    animation = CurvedAnimation(parent: controller, curve: Curves.decelerate);
    controller.repeat();
    startTime();
  }

  final Tween<double> turnsTween = Tween<double>(begin: 1, end: 0);

  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(

        // ignore: prefer_const_constructors
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: <Color>[
                Color(0xff040117),
                Color(0xdd08092B),
              ],
            ),
          ),
          child: Stack(children: <Widget>[
            const Center(
              child: Image(
                image: AssetImage('assets/into/logo.png'),
              ),
            ),
            Center(
              child: RotationTransition(
                turns: turnsTween.animate(controller),
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
          ])),
    );
  }

  startTime() async {
    var duration = new Duration(seconds: 5);
    return new Timer(duration, route);
  }

  route() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Example()));
  }
}