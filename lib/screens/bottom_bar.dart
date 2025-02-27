import 'package:dhwani/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:switcher_button/switcher_button.dart';

import '../controller/login_controller.dart';
import '../widgets/tile_widget.dart';
import '../controller/bottom_bar.dart';
import 'libraries.dart';
import 'search.dart';
import 'speech_to_text.dart';

final Bottom controller1 = Get.put(Bottom());

class Example extends StatefulWidget {
  @override
  _ExampleState createState() => _ExampleState();
}

class _ExampleState extends State<Example> {
  // bool _isOn = false;
  var val = false;
  Future<void> delShared() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLoggedIn', false);
    val = false;
    // return prefs.getBool('isLoggedIn') ?? false;
  }

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return Scaffold(
      key: _scaffoldKey,
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
        title: const Text(
          'QUICK ACCESS',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
          icon: const Icon(Icons.menu_rounded, size: 35),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFF130C2E),
              ),
              child: Text(
                'Hello, There',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.dashboard),
              title: const Text('Dashboard'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () {
                controller.logout();
                delShared();
                Get.offAll(() => login());
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 15),
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
                    color: Colors.white,
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
            child: GridView.count(
              padding: const EdgeInsets.all(12.0),
              childAspectRatio: 1.2,
              mainAxisSpacing: 16.0,
              crossAxisSpacing: 16.0,
              crossAxisCount: MediaQuery.of(context).size.width > 600 ? 4 : 2,
              children: List.generate(8, (index) {
                return tileWidget(index, controller1.isOn.value);
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
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              rippleColor: Colors.grey[300]!,
              hoverColor: Colors.grey[100]!,
              gap: 8,
              activeColor: Colors.black,
              iconSize: 22,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
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
                controller1.updateIndex(index);
                print(controller1.selectedIndex);
              },
            ),
          ),
        ),
      ),
    );
  }
}
