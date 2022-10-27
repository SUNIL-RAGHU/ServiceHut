// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_this, non_constant_identifier_names

import 'package:flutter/material.dart';

import 'package:svlp/Views/profilpage.dart';
import 'package:svlp/Views/providerdashboard.dart';
import 'package:svlp/Views/recentproviderdashboard.dart';

class Tabbar extends StatefulWidget {
  const Tabbar({Key? key}) : super(key: key);

  @override
  State<Tabbar> createState() => _TabbarState();
}

class _TabbarState extends State<Tabbar> {
  int selected = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ignore: prefer_const_literals_to_create_immutables
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: selected,
          onTap: (value) => setState(() {
                this.selected = value;
              }),
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.home_filled), label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(Icons.search_outlined), label: "Search"),
            BottomNavigationBarItem(
                icon: Icon(Icons.library_music_outlined),
                label: "Your Library"),
          ]),
      body: Stack(children: [
        renderview(
          0,
          Providerdashboard(),
        ),
        renderview(
          1,
          RecentProviderdashboard(),
        ),
        renderview(
          2,
          ProfilePage(),
        ),
      ]),
    );
  }

  Widget renderview(int TabIndex, Widget view) {
    return IgnorePointer(
      ignoring: selected != TabIndex,
      child: Opacity(
        opacity: selected == TabIndex ? 1 : 0,
        child: view,
      ),
    );
  }
}
