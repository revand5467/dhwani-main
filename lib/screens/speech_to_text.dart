import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:highlight_text/highlight_text.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:string_similarity/string_similarity.dart';
import 'package:switcher_button/switcher_button.dart';
import 'package:translator/translator.dart';
import 'package:dhwani/screens/search.dart';
import 'package:dhwani/screens/bottom_bar.dart';
import '../controller/bottom_bar.dart';
import 'package:flutter_tts/flutter_tts.dart';

import '../models/tile_model.dart';
import '../widgets/tile_wid.dart';
import 'libraries.dart';

final Bottom controller1 = Get.put(Bottom());

class Speech extends StatefulWidget {
  @override
  _SpeechState createState() => _SpeechState();
}

class _SpeechState extends State<Speech> {
  String _text = '';
  GoogleTranslator translator = GoogleTranslator();
  var lang = "";
  void trans() async {
    await translator
        .translate(lang, to: 'en') //translating to hi = hindi
        .then((output) {
      setState(() {
        _text = output.toString();
        _performSearch();
      });
      print(output);
    });
  }

  final Map<String, HighlightedWord> _highlights = {
    'flutter': HighlightedWord(
      onTap: () => print('flutter'),
      textStyle: const TextStyle(
        color: Colors.blue,
        fontWeight: FontWeight.bold,
      ),
    ),
    'voice': HighlightedWord(
      onTap: () => print('voice'),
      textStyle: const TextStyle(
        color: Colors.green,
        fontWeight: FontWeight.bold,
      ),
    ),
    'subscribe': HighlightedWord(
      onTap: () => print('subscribe'),
      textStyle: const TextStyle(
        color: Colors.red,
        fontWeight: FontWeight.bold,
      ),
    ),
    'like': HighlightedWord(
      onTap: () => print('like'),
      textStyle: const TextStyle(
        color: Colors.blueAccent,
        fontWeight: FontWeight.bold,
      ),
    ),
    'comment': HighlightedWord(
      onTap: () => print('comment'),
      textStyle: const TextStyle(
        color: Colors.green,
        fontWeight: FontWeight.bold,
      ),
    ),
  };

  late stt.SpeechToText _speech;
  bool _isListening = false;
  double _confidence = 1.0;
  List<tile> searchResults = [];

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
  }

  List<tile> _performSearch() {
    searchResults = [];
    if (_text.isNotEmpty) {
      final String query = _text.toLowerCase();
      searchResults = demo.where((tile) {
        return tile.tag
            .any((tag) => query.toLowerCase().contains(tag.toLowerCase()));
      }).toList();
    }

    if (searchResults.isEmpty) {
      setState(() {
        isLoading = false;
      });
    }
    return searchResults;
  }

  bool _isOn = false;
  bool isLoading = true;

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
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.mic, size: 30), // Microphone icon
            SizedBox(width: 8), // Space between the icon and text
            Text(
              'VOICE ASSIST',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        centerTitle: true,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: AvatarGlow(
        animate: _isListening,
        glowColor: const Color(0xFFF3D6F5),
        endRadius: 75.0,
        duration: const Duration(milliseconds: 2000),
        repeatPauseDuration: const Duration(milliseconds: 100),
        repeat: true,
        child: FloatingActionButton(
          onPressed: _listen,
          child: Icon(_isListening ? Icons.mic : Icons.mic_none),
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            child: TextHighlight(
              text: _text,
              words: _highlights,
              textStyle: const TextStyle(
                fontSize: 25.0,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 10),
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
                Obx(() => SwitcherButton(
                      // Use Obx to make the widget reactive
                      value: controller1.isOn.value,
                      onChange: (value) {
                        controller1.isOn.value = !controller1.isOn.value;
                        Get.to(() => Example());
                        print(controller1.isOn.value);
                      },
                    )),
              ],
            ),
          ),
          Expanded(
            child: Stack(
              children: [
                GridView.count(
                  crossAxisCount:
                      MediaQuery.of(context).size.width > 600 ? 4 : 2,
                  children: _performSearch().map<Widget>((tile) {
                    return tileWid(tile, _isOn);
                  }).toList(),
                ),
                if (isLoading)
                  const Center(
                    child: CircularProgressIndicator(),
                  ),
                if (!isLoading && searchResults.isEmpty)
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Text(
                        'No Matches Found. Speak!!',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ),
              ],
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
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              rippleColor: Colors.grey[300]!,
              hoverColor: Colors.grey[100]!,
              gap: 7,
              activeColor: Colors.black,
              iconSize: 22,
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
                controller1.updateIndex(index);
                ;
              },
            ),
          ),
        ),
      ),
    );
  }

  void _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (val) => print('onStatus: $val'),
        onError: (val) => print('onError: $val'),
      );
      if (available) {
        setState(() {
          _isListening = true;
          _text = 'Listening...';
          isLoading = true; // Reset the flag before starting to listen
        });
        _speech.listen(
          localeId: 'ml_IN',
          onResult: (val) => setState(() {
            lang = val.recognizedWords;
            print(lang);
            trans();
            if (val.hasConfidenceRating && val.confidence > 0) {
              _confidence = val.confidence;
            }
          }),
        );
      }
    } else {
      setState(() {
        _isListening = false;
        isLoading = false;
      });
      _text = '';
      _speech.stop();
    }
  }
}
