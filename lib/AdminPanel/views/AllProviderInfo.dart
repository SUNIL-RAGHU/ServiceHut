import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:svlp/AdminPanel/views/ProviderProfileview.dart';

import '../../Models/ProviderDetails.dart';

class AllProviderInfo extends StatefulWidget {
  const AllProviderInfo({super.key});

  @override
  State<AllProviderInfo> createState() => _AllProviderInfoState();
}

class _AllProviderInfoState extends State<AllProviderInfo> {
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
    return FutureBuilder<QuerySnapshot>(
        future: FirebaseFirestore.instance.collection('User').get(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          log("build method called");
          if (snapshot.hasData) {
            final List<DocumentSnapshot> documents = snapshot.data.docs;
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.blueGrey,
                title: const Text("All Providers"),
                leading: const Icon(Icons.arrow_back),
              ),
              body: ListView(
                children: documents.map(
                  (doc) {
                    Map data = (doc.data() as Map);
                    Providerdetails currentTask = Providerdetails.fromMap(data);
                    // if (data["isAccepted"]) {
                    if (currentTask.isAccepted == true) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          color: Colors.grey[300],
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProviderProfileview(
                                          detailsProvider: currentTask,
                                        )),
                              );
                            },
                            child: ListTile(
                              title: Text(currentTask.Name.toString()),
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
