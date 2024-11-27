import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:media_player/utils/global.dart';
import 'package:media_player/view/screen/search_screen/search.dart';

import '../../controller/controller.dart';

class HomeScreen extends StatelessWidget {
  final NavController navController = Get.put(NavController());

  // Pages for each tab
  final List<Widget> pages = [
    SearchScreen(),
    ShortsPage(),
    AddPage(),
    SubscriptionsPage(),
    LibraryPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => pages[navController.selectedIndex.value]),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          currentIndex: navController.selectedIndex.value,
          onTap: navController.changeIndex,
          type: BottomNavigationBarType.fixed,
          backgroundColor: bgColor,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.play_arrow),
              label: 'Shorts',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add_circle_outline),
              label: 'Add',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.subscriptions),
              label: 'Subscriptions',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'You',
            ),
          ],
        ),
      ),
    );
  }
}

class ShortsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: bgColor,
        body: Center(
            child: Text(
          'Shorts Page',
          style: textStyle(),
        )));
  }
}

class AddPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: bgColor,
        body: Center(
            child: Text(
          'Add Page',
          style: textStyle(),
        )));
  }
}

class SubscriptionsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: bgColor,
        body: Center(
            child: Text(
          'Subscriptions Page',
          style: textStyle(),
        )));
  }
}

class LibraryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: bgColor,
        body: Center(
            child: Text(
          'Library Page',
          style: textStyle(),
        )));
  }
}

TextStyle textStyle() {
  return TextStyle(fontSize: 18, color: white);
}
