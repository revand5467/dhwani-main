import 'package:dhwani/screens/search.dart';
import 'package:dhwani/screens/speech_to_text.dart';
import 'package:flutter/material.dart';
import 'package:dhwani/models/tile_model.dart';
import 'package:dhwani/screens/library_detail_page.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';

import '../controller/bottom_bar.dart';
import 'bottom_bar.dart';

final Bottom controller = Get.put(Bottom());

class Classification {
  final String name;
  final List<String> tags;
  final String imagePath;

  Classification({required this.name, required this.tags, required this.imagePath});
}

class Libraries extends StatefulWidget {
  @override
  _LibrariesState createState() => _LibrariesState();
}

class _LibrariesState extends State<Libraries> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.w600);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Home',
      style: optionStyle,
    ),
    Text(
      'Likes',
      style: optionStyle,
    ),
    Text(
      'Search',
      style: optionStyle,
    ),
    Text(
      'Profile',
      style: optionStyle,
    ),
  ];

  List<Classification> classifications = [
    Classification(name: 'Food', tags: ['food'], imagePath: 'assets/PNG/food.jpg'),
    Classification(name: 'Sleep', tags: ['sleep'], imagePath: 'assets/PNG/sleep.jpg'),
    // Add more classifications here
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
            'Libraries',
          style: TextStyle(
            color: Colors.black
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: GridView.count(
        crossAxisCount: 2,
        padding: EdgeInsets.all(16.0),
        childAspectRatio: 1.2,
        mainAxisSpacing: 16.0,
        crossAxisSpacing: 16.0,
        children: classifications.map((classification) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LibraryDetailPage(
                    classification: classification,
                  ),
                ),
              );
            },
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.asset(
                      classification.imagePath,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.black.withOpacity(0.5), Colors.black.withOpacity(0.8)],
                      ),
                    ),
                    child: Center(
                      child: Text(
                        classification.name,
                        style: const  TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
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
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              rippleColor: Colors.grey[300]!,
              hoverColor: Colors.grey[100]!,
              gap: 8,
              activeColor: Colors.black,
              iconSize: 24,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: const Duration(milliseconds: 400),
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
