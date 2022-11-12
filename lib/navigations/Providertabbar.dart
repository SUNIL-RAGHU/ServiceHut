// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_this, non_constant_identifier_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:svlp/Models/UserModel.dart';
import 'package:svlp/Provider/views/providerProfilePage.dart';

import 'package:svlp/Provider/views/providerdashboard.dart';
import 'package:svlp/Provider/views/recentproviderdashboard.dart';

class ProviderTabbar extends StatefulWidget {
  UserModel user;
  ProviderTabbar({Key? key, required this.user}) : super(key: key);

  @override
  State<ProviderTabbar> createState() => _ProviderTabbarState();
}

class _ProviderTabbarState extends State<ProviderTabbar> {
  int selected = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: selected,
          onTap: (value) => setState(() {
                this.selected = value;
              }),
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.home_filled), label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(Icons.search_outlined), label: "Recent"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
          ]),
      body: Stack(children: [
        renderview(
          0,
          Providerdashboard(
            user: widget.user,
          ),
        ),
        renderview(
          1,
          RecentProviderdashboard(),
        ),
        renderview(
          2,
          Providerprofilepage(
            Uid: widget.user.Uid.toString(),
          ),
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
