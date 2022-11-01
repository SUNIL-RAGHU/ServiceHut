import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Models/UserAssign.dart';
import '../Models/taskdetail.dart';

class Check extends StatefulWidget {
  const Check({super.key});

  @override
  State<Check> createState() => _CheckState();
}

class _CheckState extends State<Check> {
  var user = FirebaseAuth.instance.currentUser;

  UserAssign ewq = UserAssign();

  List<Taskdetail> ds = [];

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('Tasks').snapshots(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          FirebaseFirestore.instance
              .collection('User')
              .get()
              .then((QuerySnapshot querySnapshot) {
            querySnapshot.docs.forEach((doc) {
              print(doc.data());
              ewq = UserAssign.fromMap(doc.data());

              print(ewq.Roles);

              ds.add(Taskdetail.fromMap(doc.data()));
            });
          });
          print(ds[1].Title.toString());

          return Scaffold(
              body: ListView.builder(
                  itemCount: ds.length,
                  itemBuilder: (ctx, index) {
                    return Text(ds[index].Title!);
                  }));
        }
        return const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
