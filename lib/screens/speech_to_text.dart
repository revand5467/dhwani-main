import 'package:avatar_glow/avatar_glow.dart';
import 'package:dhwani/screens/speech_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:highlight_text/highlight_text.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:string_similarity/string_similarity.dart';
import 'package:translator/translator.dart';
import 'package:dhwani/screens/search.dart';
import 'package:dhwani/screens/bottom_bar.dart';
import '../controller/bottom_bar.dart';
import 'package:flutter_tts/flutter_tts.dart';

import '../models/tile_model.dart';
import '../widgets/tile_wid.dart';
import 'libraries.dart';

final Bottom controller = Get.put(Bottom());

class Speech extends StatefulWidget {
  @override
  _SpeechState createState() => _SpeechState();
}

class _SpeechState extends State<Speech> {
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

  String _text = 'Press the Button and Start Speaking';
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
        return tile.tag.any((tag) =>
        StringSimilarity.compareTwoStrings(tag.toLowerCase(), query) > 0.5);
      }).toList();
    }
    setState(() {
      isLoading = false;
    });
    return searchResults;

  }


  bool _isOn = false;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Voice Assist',
          style: TextStyle(fontSize: 22, color: Colors.black),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: AvatarGlow(
        animate: _isListening,
        glowColor: Theme.of(context).primaryColor,
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
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
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
            child: Stack(
              children: [
                GridView.count(
                  crossAxisCount: MediaQuery.of(context).size.width > 600 ? 4 : 2,
                  children: _performSearch().map<Widget>((tile) {
                    return tileWid(tile, _isOn);
                  }).toList(),
                ),
                if (isLoading)
                  const Center(
                    child: CircularProgressIndicator(),
                  ),
                if (searchResults.isEmpty && !isLoading)
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Text(
                        'No Matches Found.',
                        style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
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

  void _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (val) => print('onStatus: $val'),
        onError: (val) => print('onError: $val'),
      );
      if (available) {
        setState(() =>{
          _isListening = true,
        _text = 'Listening.....',
          isLoading = true,
        });
        _speech.listen(
          localeId: 'ml_IN',
          onResult: (val) => setState(() {
            // _text = val.recognizedWords;
            lang = val.recognizedWords;
            print(lang);
            trans(); //calling the function to translate the text
            if (val.hasConfidenceRating && val.confidence > 0) {
              _confidence = val.confidence;
            }
          }),
        );
      }
    } else {
      setState(() => _isListening = false);
      _text = 'Press the Button and Start Speaking';
      _speech.stop();
    }
  }


}
