import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter/material.dart';
import '../models/tile_model.dart';


Widget tileWidget(int index, bool isOn) {

  FlutterTts ftts = FlutterTts();
  return GestureDetector(
    onTap: () async {
      //your custom configuration
      await ftts.setSpeechRate(0.5); //speed of speech
      await ftts.setVolume(1.0); //volume of speech
      await ftts.setPitch(1);
      if(isOn) {
        //print('On');
        await ftts.setLanguage("ml-IN");
        await ftts.speak(demo[index].maludescription);
      }
      else
        {
          //print('Off');
          await ftts.setLanguage("en-US");
          await ftts.speak(demo[index].description);
        }

      //play text to sp
      // var result = await ftts.speak(demo[index].description);
      // if (result == 1) {
      //   //speaking
      // } else {
      //   //not speaking
      // }
    },
    child: Card(
      color: const Color(0xFFF3D6F5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Transform.scale(
        scale: 1.0,
        child: Image.asset(demo[index].image,
          fit: BoxFit.contain,
          // color: Colors.black,
          //semanticsLabel: demo[index].description
          ),
      ),
    ),
  );
}
