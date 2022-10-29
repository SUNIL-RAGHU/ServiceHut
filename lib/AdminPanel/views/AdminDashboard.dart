import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../Models/taskdetail.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  var user = FirebaseAuth.instance.currentUser;

  List<Taskdetail> ds = [];
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Tasks').snapshots(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            FirebaseFirestore.instance
                .collection('Tasks')
                .get()
                .then((QuerySnapshot querySnapshot) {
              querySnapshot.docs.forEach((doc) {
                ds.add(Taskdetail.fromMap(doc.data()));
              });
            });
            print(ds[1].Title.toString());
            return SafeArea(
              child: Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.blueGrey,
                  title: Text("Accept New Providers"),
                  leading: Icon(Icons.arrow_back),
                ),
                body: Container(
                  padding: EdgeInsets.all(10),
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: ds.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            color: Colors.grey[300],
                            child: ListTile(
                              title: Text('Item ${ds[index].Title.toString()}'),
                              trailing: Icon(Icons.arrow_circle_right),
                            ),
                          ),
                        );
                      }),
                ),
              ),
            );
          }
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        });
  }
}
