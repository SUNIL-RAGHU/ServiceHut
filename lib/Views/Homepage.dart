// ignore_for_file: prefer_interpolation_to_compose_strings, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

// ignore: must_be_immutable
class HomePage extends StatefulWidget {
  String id;
  HomePage({super.key, required this.id});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser!;

  List<String> docIDs = [];

  Future getDocId() async {
    await FirebaseFirestore.instance
        .collection("users")
        .orderBy('Age', descending: true)
        .get()
        // ignore: avoid_function_literals_in_foreach_calls
        .then((snapshot) => snapshot.docs.forEach((document) {
              docIDs.add(document.reference.id);
            }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Signed In as:' + user.email!,
          style: TextStyle(fontSize: 16),
        ),
        actions: [
          GestureDetector(
              onTap: (() {
                FirebaseAuth.instance.signOut();
              }),
              child: Icon(Icons.logout)),
        ],
      ),
    );
  }
}
