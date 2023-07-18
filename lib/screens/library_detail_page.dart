import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:provider/provider.dart';
import 'package:switcher_button/switcher_button.dart';

import '../models/selected_tiles_provider.dart';
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
      return tile.tag.any((tag) => widget.classification.tags.contains(tag.toLowerCase()));
    }).toList();
  }

  @override
  void initState() {
    super.initState();
    filteredTiles = filterTiles(demo); // Replace `demo` with your tile list
  }

  void selectTile(tile selectedTile) {
    final selectedTilesProvider = context.read<SelectedTilesProvider>();

    setState(() {
      if (selectedTilesProvider.selectedTiles.contains(selectedTile)) {
        selectedTilesProvider.removeSelectedTile(selectedTile);
        combinedAudioUrls.remove(selectedTile.description);
      } else {
        selectedTilesProvider.addSelectedTile(selectedTile);
        combinedAudioUrls.add(selectedTile.description);
      }
    });
  }

  void deleteLastTile() {
    final selectedTilesProvider = context.read<SelectedTilesProvider>();

    setState(() {
      if (selectedTilesProvider.selectedTiles.isNotEmpty) {
        final lastTile = selectedTilesProvider.selectedTiles.last;
        selectedTilesProvider.removeSelectedTile(lastTile);
        combinedAudioUrls.remove(lastTile.description);
      }
    });
  }

  void clearSelection() {
    final selectedTilesProvider = context.read<SelectedTilesProvider>();

    setState(() {
      selectedTilesProvider.clearSelectedTiles();
      combinedAudioUrls.clear();
    });
  }

  FlutterTts ftts = FlutterTts();

  Future<void> playCombinedAudio() async {
    final selectedTilesProvider = context.read<SelectedTilesProvider>();
    combinedAudioUrls = selectedTilesProvider.selectedTiles.map((tile) => tile.description).toList();

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
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF8141033), Color(0xFF8644A9)],
              stops: [0, 1],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(25),
              bottomRight: Radius.circular(25),
            ),
          ),
        ),
        toolbarHeight: 70,
        title:
            Text(
              widget.classification.name,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
        centerTitle: true,
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
            const SizedBox(height: 10),
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
                            ...context.watch<SelectedTilesProvider>().selectedTiles.map<Widget>((tile){
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.asset(
                                  tile.image,
                                  width: 70,
                                  height: 70,
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
                childAspectRatio: 1.2,
                mainAxisSpacing: 16.0,
                crossAxisSpacing: 16.0,
                children: filteredTiles.map<Widget>((tile) {
                  return tileWidg(
                    selected: context.watch<SelectedTilesProvider>().selectedTiles.contains(tile),
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
