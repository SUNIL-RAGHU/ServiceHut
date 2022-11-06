import 'package:flutter/material.dart';
import 'package:svlp/AdminPanel/views/AdminDashboard.dart';
import 'package:svlp/AdminPanel/views/AllBuyersInfo.dart';
import 'package:svlp/AdminPanel/views/AllProviderInfo.dart';
import 'package:svlp/AdminPanel/views/Providerinfo.dart';

class AdminTabbar extends StatefulWidget {
  const AdminTabbar({Key? key}) : super(key: key);

  @override
  State<AdminTabbar> createState() => _AdminTabbarState();
}

class _AdminTabbarState extends State<AdminTabbar> {
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
            BottomNavigationBarItem(
                icon: Icon(Icons.psychology), label: "Profile"),
          ]),
      body: Stack(children: [
        renderview(0, AdminDashboard()),
        renderview(
          1,
          ProviderInfo(),
        ),
        renderview(
          2,
          AllBuyerInfo(),
        ),
        renderview(
          3,
          AllProviderInfo(),
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
