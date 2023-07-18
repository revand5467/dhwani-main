import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';

import '../controller/bottom_bar.dart';
import '../models/selected_tiles_provider.dart';
import 'bottom_bar.dart';
import 'library_detail_page.dart';
import 'search.dart';
import 'speech_to_text.dart';
import '../models/tile_model.dart';

final Bottom controller1 = Get.put(Bottom());

class Classification {
  final String name;
  final List<String> tags;
  final String imagePath;

  Classification(
      {required this.name, required this.tags, required this.imagePath});
}

class Libraries extends StatefulWidget {
  @override
  _LibrariesState createState() => _LibrariesState();
}

class _LibrariesState extends State<Libraries> {
  List<Classification> classifications = [
    Classification(
        name: 'Food', tags: ['food'], imagePath: 'assets/into/food.jpg'),
    Classification(
        name: 'Drink', tags: ['drink'], imagePath: 'assets/into/drink.jpg'),
    Classification(
        name: 'Washroom',
        tags: ['toilet'],
        imagePath: 'assets/into/washroom.jpg'),
    Classification(
        name: 'School', tags: ['school'], imagePath: 'assets/into/school.png'),
    Classification(
        name: 'Objects', tags: ['object'], imagePath: 'assets/into/object.jpg'),
    Classification(
        name: 'Animals',
        tags: ['animal'],
        imagePath: 'assets/into/animals.jpg'),
    Classification(
        name: 'Alphabets',
        tags: ['alphabet'],
        imagePath: 'assets/into/alphabets.jpg'),
    Classification(
        name: 'Numbers',
        tags: ['numbers'],
        imagePath: 'assets/into/numbers.jpg'),
    Classification(
        name: 'Hobbies',
        tags: ['hobbies'],
        imagePath: 'assets/into/hobbies.png'),
    Classification(
        name: 'Body Parts', tags: ['body'], imagePath: 'assets/into/body.jpg'),
    Classification(
        name: 'Pronouns/Verbs',
        tags: ['prbs'],
        imagePath: 'assets/into/pro.jpg'),
    Classification(
        name: 'Greetings', tags: ['greet'], imagePath: 'assets/into/greet.png'),
  ];

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<SelectedTilesProvider>(
          create: (_) => SelectedTilesProvider(),
        ),
      ],
      child: Scaffold(
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
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.library_books_outlined, size: 30), // Microphone icon
              SizedBox(width: 8), // Space between the icon and text
              Text(
                'LIBRARIES',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          centerTitle: true,
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
                          colors: [
                            Colors.black.withOpacity(0.5),
                            Colors.black.withOpacity(0.8)
                          ],
                        ),
                      ),
                      child: Center(
                        child: Text(
                          classification.name,
                          style: const TextStyle(
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
            color: const Color(0xFF673D80),
            boxShadow: [
              BoxShadow(
                blurRadius: 20,
                color: Colors.black.withOpacity(.1),
              ),
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                duration: const Duration(milliseconds: 400),
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
                      Get.offAll(() => Libraries());
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
                  print(controller1.selectedIndex);
                  controller1.updateIndex(index);
                  print(controller1.selectedIndex);
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
