import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:string_similarity/string_similarity.dart';
import 'package:switcher_button/switcher_button.dart';
import '../models/tile_model.dart';
import '../controller/bottom_bar.dart';
import '../widgets/tile_wid.dart';
import 'bottom_bar.dart';
import 'libraries.dart';
import 'speech_to_text.dart';

final Bottom controller1 = Get.put(Bottom());

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
        title:  Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.image_search, size: 30), // Microphone icon
            SizedBox(width: 8), // Space between the icon and text
            Text(
              'SEARCH',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        centerTitle: true,
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
                    decoration: InputDecoration(
                      hintText: 'Search...',
                      hintStyle: const TextStyle(
                        color: Colors.black,
                      ),
                      prefixIcon: const Icon(Icons.search),
                      filled: true,
                      fillColor: const Color(0xFFF3D6F5), // Set the background color
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide.none, // Remove the border
                      ),
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
                    color: Colors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 10.0),
                SwitcherButton(
                  onChange: (value){
                    setState(() {
                      _isOn = !_isOn;
                    });
                  },
                )
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
              padding: const EdgeInsets.all(12.0),
              childAspectRatio: 1.2,
              mainAxisSpacing: 16.0,
              crossAxisSpacing: 16.0,
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
          color: const Color(0xFF673D80),
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
              iconSize: 30,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: Duration(milliseconds: 400),
              tabBackgroundColor: const Color(0xFFF3D6F5),
              color: Colors.white,
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
                  text: 'Voice',
                  onPressed: () {
                    Get.offAll(() => Speech());
                  },
                ),
              ],
              selectedIndex: controller1.selectedIndex,
              onTabChange: (index) {
                setState(() {
                  //_selectedIndex = index;
                  controller1.updateIndex(index);
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
