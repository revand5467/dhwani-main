import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

import '../models/tile_model.dart';

Widget tileWidg({
  required bool selected,
  required bool isOn,
  required tile tile,
  required Function(bool) onSelect,
}) {
  FlutterTts ftts = FlutterTts();

  return GestureDetector(
    onTap: () async {
      await ftts.setSpeechRate(0.5); // Set the speed of speech
      await ftts.setVolume(1.0); // Set the volume of speech
      await ftts.setPitch(1);

      if (isOn) {
        await ftts.setLanguage("ml-IN");
        await ftts.speak(tile.maludescription);
      } else {
        await ftts.setLanguage("en-US");
        await ftts.speak(tile.description);
      }

      onSelect(!selected); // Toggle the selection state
    },
    child: Card(
      color: selected ? Colors.white : const Color(0xFFF3D6F5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Transform.scale(
        scale: 1.5,
        child: Image.asset(
          tile.image,
          // color: Colors.black,
          // semanticsLabel: tile.description
        ),
      ),
    ),
  );
}
