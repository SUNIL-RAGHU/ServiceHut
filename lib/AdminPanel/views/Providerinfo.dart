import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:svlp/Models/ProviderDetails.dart';

import 'ProviderInfovalid.dart';

class ProviderInfo extends StatefulWidget {
  const ProviderInfo({super.key});

  @override
  State<ProviderInfo> createState() => _ProviderInfoState();
}

class _ProviderInfoState extends State<ProviderInfo> {
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
                title: Text("Accept New Providers"),
                leading: Icon(Icons.arrow_back),
              ),
              body: ListView(
                children: documents.map(
                  (doc) {
                    Map data = (doc.data() as Map);
                    Providerdetails currentTask = Providerdetails.fromMap(data);
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
                                    builder: (context) =>
                                        (ProviderInfovalidation(
                                          detailsProvider: currentTask,
                                        ))),
                              );
                            },
                            child: ListTile(
                              title: Text(currentTask.Name.toString()),
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
                                    onPressed: () {},
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
