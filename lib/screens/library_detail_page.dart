import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:switcher_button/switcher_button.dart';

import '../models/tile_model.dart';
import '../widgets/tile_wid.dart';
import '../widgets/tile_widg.dart';
import 'libraries.dart';

class LibraryDetailPage extends StatefulWidget {
  final Classification classification;

  LibraryDetailPage({required this.classification});

  @override
  _LibraryDetailPageState createState() => _LibraryDetailPageState();
}

class _LibraryDetailPageState extends State<LibraryDetailPage> {
  bool _isOn = false;
  List<tile> filteredTiles = [];

  List<tile> selectedTiles = [];
  List<String> combinedAudioUrls = [];

  List<tile> filterTiles(List<tile> tiles) {
    return tiles.where((tile) {
      return tile.tag.any((tag) =>
          widget.classification.tags.contains(tag.toLowerCase()));
    }).toList();
  }

  @override
  void initState() {
    super.initState();
    filteredTiles = filterTiles(demo); // Replace `demo` with your tile list
  }

  void selectTile(tile selectedTile) {
    setState(() {
      if (selectedTiles.contains(selectedTile)) {
        selectedTiles.remove(selectedTile);
        combinedAudioUrls.remove(selectedTile.description);
      } else {
        selectedTiles.add(selectedTile);
        combinedAudioUrls.add(selectedTile.description);
      }
    });
  }

  void deleteLastTile() {
    setState(() {
      if (selectedTiles.isNotEmpty) {
        final lastTile = selectedTiles.last;
        selectedTiles.remove(lastTile);
        combinedAudioUrls.remove(lastTile.description);
      }
    });
  }

  void clearSelection() {
    setState(() {
      selectedTiles.clear();
      combinedAudioUrls.clear();
    });
  }

  FlutterTts ftts = FlutterTts();

  Future<void> playCombinedAudio() async {
    combinedAudioUrls = selectedTiles.map((tile) => tile.description).toList();
    await ftts.setSpeechRate(0.5); // Set the speed of speech
    await ftts.setVolume(1.0); // Set the volume of speech
    await ftts.setPitch(1);
    await ftts.setLanguage("en-US");
    String combinedAudioText = combinedAudioUrls.join(' ');
    await ftts.speak(combinedAudioText);
    print('Playing combined audio: $combinedAudioUrls');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF130C2E),
      appBar: AppBar(
        title: Text(
          widget.classification.name,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10.0),
            const Text(
              'Selected Tiles:',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            GestureDetector(
              onTap: playCombinedAudio,
              child: Container(
                height: 100,
                color: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            SizedBox(width: 8.0), // Add spacing between backspace and tiles
                            ...selectedTiles.map<Widget>((tile) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.asset(
                                  tile.image,
                                  width: 48,
                                  height: 48,
                                ),
                              );
                            }).toList(),
                          ],
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.backspace),
                      onPressed: deleteLastTile,
                    ),
                    IconButton(
                      icon: Icon(Icons.clear),
                      onPressed: clearSelection,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Text(
                  'MALAYALAM',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 10.0),
                SwitcherButton(
                  value: _isOn,
                  onChange: (value) {
                    setState(() {
                      _isOn = value;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 10.0),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                children: filteredTiles.map<Widget>((tile) {
                  return tileWidg(
                    selected: selectedTiles.contains(tile),
                    isOn: _isOn,
                    tile: tile,
                    onSelect: (selected) {
                      selectTile(tile);
                    },
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
