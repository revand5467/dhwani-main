import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import '../models/tile_model.dart';
import 'package:string_similarity/string_similarity.dart';

import '../widgets/tile_wid.dart';
import '../widgets/tile_widget.dart';


class SpeechTile extends StatefulWidget {
  final String searchValue;

  const SpeechTile({Key? key, required this.searchValue}) : super(key: key);

  @override
  _SpeechTileState createState() => _SpeechTileState();
}

class _SpeechTileState extends State<SpeechTile> {
  late List<tile> searchResults;

  @override
  void initState() {
    super.initState();
    searchResults = _performSearch();
  }

  // List<tile> _performSearch() {
  //   return demo.where((til) {
  //     return til.tag.any((tag) => tag.toLowerCase().contains(widget.searchValue.toLowerCase())) ||
  //         til.name.toLowerCase().contains(widget.searchValue.toLowerCase());
  //   }).toList();
  // }

  List<tile> _performSearch() {
    List<String> keywords = widget.searchValue.toLowerCase().split(' ');

    List<tile> searchResults = [];
    for (var tile in demo) {
      bool hasMatch = false;
      for (var keyword in keywords) {
        if (tile.tag.any((tag) => StringSimilarity.compareTwoStrings(tag.toLowerCase(), keyword) > 0.5)) {
          hasMatch = true;
          break;
        }
      }
      if (hasMatch) {
        searchResults.add(tile);
      }
    }

    return searchResults;
  }



  Future<void> _speak(String text) async {
    FlutterTts tts = FlutterTts();
    await tts.setLanguage("en-US");
    await tts.setSpeechRate(0.25);
    await tts.setVolume(1.0);
    await tts.setPitch(1);
    await tts.speak(text);
  }

  bool _isOn = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.orange),
      home: Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back,
              color: Colors.black,
              size: 24.0,
              semanticLabel: 'Text to announce in accessibility modes',
            ),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Search : ${widget.searchValue}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            if (searchResults.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text(
                      'MALAYALAM',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 10.0),
                    Ink(
                      height: 26.0,
                      width: 40.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25.0),
                        color: _isOn ? Colors.green : Colors.red,
                      ),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            _isOn = !_isOn;
                          });
                        },
                        borderRadius: BorderRadius.circular(25.0),
                        child: Center(
                          child: Text(
                            _isOn ? 'ON' : 'OFF',
                            style: const TextStyle(
                              fontSize: 13.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: GridView.count(
                  crossAxisCount: MediaQuery.of(context).size.width > 600 ? 4 : 2,
                  children: List.generate(searchResults.length, (index) {
                    return tileWid(searchResults[index], _isOn);
                  }),
                ),
              ),
            if (searchResults.isEmpty)
              const Text(
                'No results found',
                style: TextStyle(
                    fontSize: 18
                ),
              ),
          ],
        ),
      ),
    );
  }
}
