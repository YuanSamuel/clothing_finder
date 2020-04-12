import 'package:clothingfinder/gallery_page.dart';
import 'package:clothingfinder/leaderboard.dart';
import 'package:clothingfinder/profilePage.dart';
import 'package:clothingfinder/upload_page.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  List<Widget> _children = [
    Gallery(),
    LeaderBoard(),
    profilePage(),
  ];

  void onTabTapped(int index){
    setState(() {
      _currentIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        showSelectedLabels: true,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.red,
        elevation: 0,
        iconSize: 28,

        items: [
          BottomNavigationBarItem(
            icon: Icon(LineAwesomeIcons.pagelines),
            title: Text("Gallery"),
          ),
          BottomNavigationBarItem(
            icon: Icon(LineAwesomeIcons.signal),
            title: Text("Leaderboard"),
          ),
          BottomNavigationBarItem(
            icon: Icon(LineAwesomeIcons.user),
            title: Text("Profile"),
          ),
        ],
      ),
      body: _children[_currentIndex],
    );
  }
}