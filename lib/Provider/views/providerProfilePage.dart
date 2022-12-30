import 'dart:core';
import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:svlp/Models/ProviderDetails.dart';

class Providerprofilepage extends StatefulWidget {
  String Uid;

  Providerprofilepage({
    super.key,
    required this.Uid,
  });

  @override
  State<Providerprofilepage> createState() => _ProviderprofilepageState();
}

class _ProviderprofilepageState extends State<Providerprofilepage> {
  var ds = Providerdetails();
  // ignore: non_constant_identifier_names
  String? Uid;

  @override
  void initState() {
    super.initState();
    Uid = widget.Uid;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        // future: FirebaseFirestore.instance.collection('Tasks').get(),
        stream: FirebaseFirestore.instance
            .collection('User')
            // .doc(FirebaseAuth.instance.currentUser!.uid)
            .doc(Uid)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            ds = Providerdetails.fromMap(snapshot.data);

            print(ds.toMap());
            return SafeArea(
                child: Scaffold(
              body: ListView(children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Center(
                    child: ClipOval(
                      child: Image.network(
                        ds.Profile_Pics.toString(),
                        width: 160,
                        height: 160,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 48),
                  child: Column(
                    children: [
                      Text(
                        ds.Name!,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 24),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            ds.PhoneNumber.toString(),
                            style: const TextStyle(color: Colors.grey),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(Icons.location_history),
                          ),
                          const Text(
                            "ds.location",
                            style: TextStyle(color: Colors.grey),
                          ),
                          const SizedBox(height: 4),
                        ],
                      ),
                      Text(
                        ds.SelectedCategory!,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 24),
                      ),
                      SizedBox(height: 10),
                      Wrap(
                        spacing: 10,
                        children: List.generate(
                            ds.SubCategory!.length,
                            (index) =>
                                chip(ds.SubCategory![index], Colors.green)),
                      ),
                    ],
                  ),
                ),
                // ignore: prefer_const_constructors
                SizedBox(
                  height: 10,
                ),
                buildAbout(ds.About!),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 48.0),
                    child: GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 200,
                                childAspectRatio: 3 / 2,
                                crossAxisSpacing: 20,
                                mainAxisSpacing: 20),
                        itemCount: ds.Name!.length,
                        itemBuilder: (BuildContext ctx, index) {
                          return Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: Colors.amber,
                                borderRadius: BorderRadius.circular(15)),
                            child: Stack(children: [Text(ds.Name.toString())]),
                          );
                        }),
                  ),
                ),
              ]),
            ));
          }
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        });
  }

  Widget chip(String label, Color color) {
    return Chip(
      labelPadding: EdgeInsets.all(5.0),
      label: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
      backgroundColor: color,
      elevation: 1.0,
      shadowColor: Colors.grey[60],
    );
  }

  Widget buildImage(String image) {
    return ClipOval(
      child: Material(
        color: Colors.black,
        child: Ink.image(
          image: NetworkImage(image),
          fit: BoxFit.fill,
          width: 128,
          height: 128,
        ),
      ),
    );
  }
}

Widget buildAbout(String a) => Container(
      padding: const EdgeInsets.symmetric(horizontal: 48),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'About',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Text(
            a,
            style: const TextStyle(fontSize: 16, height: 1.4),
          ),
        ],
      ),
    );
