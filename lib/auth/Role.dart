import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:svlp/Buyer/views/BuyerSearch.dart';
import 'package:svlp/navigations/Providertabbar.dart';

import '../Models/UserModel.dart';
import '../Provider/views/providerdashboard.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return ControlScreen();
  }
}

class ControlScreen extends StatefulWidget {
  @override
  _ControlScreenState createState() => _ControlScreenState();
}

class _ControlScreenState extends State<ControlScreen> {
  var user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('User')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          loggedInUser = UserModel.fromMap(snapshot.data);

          // print(loggedInUser.SelectedCategory);

          if (loggedInUser.Roles == 'Buyer') {
            return Search(
              id: loggedInUser.Uid,
            );
          } else {
            return ProviderTabbar(
              user: loggedInUser,
            );
          }
        }
        return const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
