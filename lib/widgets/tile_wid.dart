import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import '../models/tile_model.dart';
import 'package:text_to_speech/text_to_speech.dart';

Widget tileWid(tile tile, bool isOn) {
  FlutterTts tts = FlutterTts();
  return GestureDetector(
    onTap: () async {
      await tts.setSpeechRate(0.5); // Speed of speech
      await tts.setVolume(1.0); // Volume of speech
      await tts.setPitch(1);

      if (isOn) {
        await tts.setLanguage("ml-IN");
        await tts.speak(tile.maludescription);
      } else {
        await tts.setLanguage("en-US");
        await tts.speak(tile.description);
      }
    },
    child: Card(
      child: Transform.scale(
        scale: 1.5,
        child: Image.asset(
          tile.image,
          // color: Colors.black,
          // semanticsLabel: tile.description,
        ),
      ),
    ),
  );
}
