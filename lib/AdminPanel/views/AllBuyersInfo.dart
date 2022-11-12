import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:svlp/AdminPanel/views/BuyerProfileviews.dart';

import '../../Models/BuyerDetails.dart';
import '../../Models/ProviderDetails.dart';

class AllBuyerInfo extends StatefulWidget {
  const AllBuyerInfo({super.key});

  @override
  State<AllBuyerInfo> createState() => _AllBuyerInfoInfoState();
}

class _AllBuyerInfoInfoState extends State<AllBuyerInfo> {
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
        stream: FirebaseFirestore.instance.collection('User').snapshots(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          log("build method called");
          if (snapshot.hasData) {
            final List<DocumentSnapshot> documents = snapshot.data.docs;
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.blueGrey,
                title: const Text("All Buyers"),
                leading: const Icon(Icons.arrow_back),
              ),
              body: ListView(
                children: documents.map(
                  (doc) {
                    Map data = (doc.data() as Map);
                    BuyerDetails currentTask = BuyerDetails.fromMap(data);
                    // if (data["isAccepted"]) {
                    // ignore: unnecessary_null_comparison
                    if (currentTask.First_Name != null) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          color: Colors.grey[300],
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BuyerProfileview(
                                          detailsbuyer: currentTask,
                                        )),
                              );
                            },
                            child: ListTile(
                              title: Text(currentTask.First_Name.toString()),
                              trailing: SizedBox(
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
                                    onPressed: () {},
                                  )),
                                ]),
                              ),
                            ),
                          ),
                        ),
                      );
                    } else {
                      return const SizedBox();
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
