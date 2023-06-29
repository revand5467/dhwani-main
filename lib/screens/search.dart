import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:string_similarity/string_similarity.dart';
import '../models/tile_model.dart';
import '../controller/bottom_bar.dart';
import '../widgets/tile_wid.dart';
import 'bottom_bar.dart';
import 'libraries.dart';
import 'speech_to_text.dart';

final Bottom controller = Get.put(Bottom());

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  String searchValue = '';
  final List<tile> tiles = demo;

  FlutterTts ftts = FlutterTts();

  List<tile> getFilteredTiles() {
    return tiles
        .where((tile) => tile.name.toLowerCase().contains(searchValue.toLowerCase()) ||
        tile.tag.any((tag) => StringSimilarity.compareTwoStrings(tag.toLowerCase(), searchValue) > 0.5))
        .toList();
  }
  bool _isOn = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
            'Search',
            style: TextStyle(
              color: Colors.black,
            ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        searchValue = value;
                      });
                    },
                    decoration: const InputDecoration(
                      hintText: 'Search...',
                      prefixIcon: Icon(Icons.search),
                    ),
                  ),
                ),
              ],
            ),
          ),
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
            // child: ListView.builder(
            //   itemCount: getFilteredTiles().length,
            //   itemBuilder: (context, index) {
            //     final item = getFilteredTiles()[index];
            //     return ListTile(
            //       title: Text(item.name),
            //       leading: Image.asset(
            //         item.image,
            //         height: 50,
            //         width: 50,
            //         fit: BoxFit.cover,
            //       ),
            //       onTap: () async {
            //         await ftts.setLanguage("en-US");
            //         await ftts.setSpeechRate(0.25);
            //         await ftts.setVolume(1.0);
            //         await ftts.setPitch(1);
            //
            //         await ftts.speak(item.description);
            //       },
            //     );
            //   },
            // ),
            child: GridView.count(
              crossAxisCount: MediaQuery.of(context).size.width > 600 ? 4 : 2,
              children: List.generate(getFilteredTiles().length, (index) {
                return tileWid(getFilteredTiles()[index], _isOn);
              }),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding:
            const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              rippleColor: Colors.grey[300]!,
              hoverColor: Colors.grey[100]!,
              gap: 8,
              activeColor: Colors.black,
              iconSize: 24,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: Duration(milliseconds: 400),
              tabBackgroundColor: Colors.grey[100]!,
              color: Colors.black,
              tabs: [
                GButton(
                  icon: LineIcons.home,
                  text: 'Home',
                  onPressed: () {
                    Get.offAll(() => Example());
                  },
                ),
                GButton(
                  onPressed: () {
                    Get.offAll(() =>  Libraries());
                  },
                  icon: LineIcons.book,
                  text: 'Libraries',
                ),
                GButton(
                  onPressed: () {
                    Get.offAll(() => const Search());
                  },
                  icon: LineIcons.search,
                  text: 'Search',
                ),
                GButton(
                  icon: LineIcons.microphone,
                  text: 'Speak',
                  onPressed: () {
                    Get.offAll(() => Speech());
                  },
                ),
              ],
              selectedIndex: controller.selectedIndex,
              onTabChange: (index) {
                setState(() {
                  //_selectedIndex = index;
                  controller.updateIndex(index);
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
