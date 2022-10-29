import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:svlp/Views/searchbar.dart';

import '../Models/UserModel.dart';
import '../Views/profilpage.dart';
import '../Views/providerdashboard.dart';

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
  var Roles;
  var Email;
  var id;
  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("User") //.where('uid', isEqualTo: user!.uid)
        .doc(user!.uid)
        .get()
        .then((value) {
      this.loggedInUser = UserModel.fromMap(value.data());
    }).whenComplete(() {
      CircularProgressIndicator();
      setState(() {
        Email = loggedInUser.Email.toString();
        Roles = loggedInUser.Roles.toString();
        id = FirebaseAuth.instance.currentUser?.uid;
      });
    });
  }

  routing() {
    if (Roles == 'Provider') {
      return Search(
        id: id,
      );
    } else {
      return Providerdashboard(
        id: id,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    CircularProgressIndicator();
    return routing();
  }
}
