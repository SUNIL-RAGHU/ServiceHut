// ignore_for_file: unused_local_variable

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:svlp/AdminPanel/views/ProviderInfovalid.dart';
import 'package:svlp/AdminPanel/views/TaskInfovalid.dart';

import '../../Models/taskdetail.dart';

// ignore: must_be_immutable
class AdminDashboard extends StatefulWidget {
  AdminDashboard({
    super.key,
  });
  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  // late Razorpay _razorpay;
  // ignore: unused_field
  int _selectedIndex = 0;
  List<Taskdetail> ds = [];
  bool isLoaded = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('Tasks').snapshots(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          log("build method called");
          if (snapshot.hasData) {
            final List<DocumentSnapshot> documents = snapshot.data.docs;
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.blueGrey,
                title: Text("Accept New Tasks"),
                leading: Icon(Icons.arrow_back),
              ),
              body: ListView(
                children: documents.map(
                  (doc) {
                    Map data = (doc.data() as Map);
                    Taskdetail currentTask = Taskdetail.fromMap(data);
                    // if (data["isAccepted"]) {
                    if (currentTask.isAccepted == false) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          color: Colors.grey[300],
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => (TaskInfovalid(
                                          Taskvalidation: currentTask,
                                        ))),
                              );
                            },
                            child: ListTile(
                              title: Text(currentTask.Title.toString()),
                              trailing: Container(
                                width: 70,
                                child: Row(children: [
                                  Expanded(
                                      child: IconButton(
                                    icon: const Icon(Icons.edit),
                                    onPressed: () {},
                                  )),
                                  Expanded(
                                      child: IconButton(
                                    icon: const Icon(Icons.delete),
                                    onPressed: () async {
                                      await FirebaseFirestore.instance
                                          .collection('Tasks')
                                          .doc(currentTask.Uid)
                                          .delete();
                                    },
                                  )),
                                ]),
                              ),
                            ),
                          ),
                        ),
                      );
                    } else {
                      return SizedBox();
                    }
                  },
                ).toList(),
              ),
            );
          }
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        });
  }
}
