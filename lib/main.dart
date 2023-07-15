import 'package:dhwani/SplashScreen/splashscreen.dart';
import 'package:dhwani/screens/bottom_bar.dart';
import 'package:dhwani/screens/home.dart';
import 'package:dhwani/screens/login_screen.dart';
import 'package:dhwani/screens/search.dart';
import 'package:dhwani/screens/speech_to_text.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../screens/bottom_bar.dart';

Future main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'ArchivoBlack',
        primarySwatch: Colors.blue,
      ),
      home: presplash(),
      //  home: Search(),
    );
  }
}

