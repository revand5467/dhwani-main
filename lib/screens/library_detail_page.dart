import 'package:flutter/material.dart';
import 'package:dhwani/models/tile_model.dart';
import 'package:dhwani/widgets/tile_wid.dart';

import 'libraries.dart';

class LibraryDetailPage extends StatefulWidget {
  final Classification classification;

  LibraryDetailPage({required this.classification});

  @override
  _LibraryDetailPageState createState() => _LibraryDetailPageState();
}

class _LibraryDetailPageState extends State<LibraryDetailPage> {
  bool _isOn = false;

  List<tile> filterTiles(List<tile> tiles) {
    return tiles.where((tile) {
      return tile.tag.any((tag) =>
          widget.classification.tags.contains(tag.toLowerCase()));
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    List<tile> filteredTiles = filterTiles(demo); // Replace `demo` with your tile list

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.classification.name,
          style: const TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
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
            const SizedBox(height: 10.0),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                children: filteredTiles.map<Widget>((tile) {
                  return tileWid(tile, _isOn);
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
