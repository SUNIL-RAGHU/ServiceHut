// ignore_for_file: prefer_const_constructors
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Taskpost extends StatefulWidget {
  String? Id;
  Taskpost({
    Key? key,
    required Id,
  }) : super(key: key);

  @override
  State<Taskpost> createState() => _TaskpostState();
}

class _TaskpostState extends State<Taskpost> {
  final _TitleController = TextEditingController();
  final _DetailsController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
  }

  var items = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];

  String? pricerange;
  String? timeline;
  List<String> subCategoryChosen = [];
  Future addTaskDetails(
    String Title,
    String? TaskSelectedCategory,
    String? TaskselectedSubCategory,
    String? pricerange,
    String? timeline,
    String? Details,
    String? uid,
    // String? longitude,
    // String? Latitude,
  ) async {
    await FirebaseFirestore.instance.collection('Tasks').doc(uid).set({
      'Title': Title,
      'TaskSelectedCategory': TaskSelectedCategory,
      'TaskselectedSubCategory': TaskselectedSubCategory,
      'pricerange': pricerange,
      'timeline': timeline,
      'Details': Details,
      'Uid': uid,
      'isAccepted': false,
      // 'Latitude': Latitude,
      // 'Longitude': longitude,
    });
  }

  String? TaskselectedCategory;
  String? TaskselectedSubCategory;

  Map<String, List<String>> adj = {
    "Carpenter": [
      'General Carpentry Work',
      'Repair Work',
      'Assembly & Installation',
      'Door & Window Install',
      'sofa and other units repair'
    ],
    "Painter": [
      "Wall painting",
      "Wall paper installation",
    ]
  };

  Future Submit() async {
    log("on submit called");
    addTaskDetails(
      _TitleController.text.trim(),
      TaskselectedCategory,
      TaskselectedSubCategory,
      pricerange,
      timeline,
      _DetailsController.text.trim(),
      FirebaseAuth.instance.currentUser!.uid,
    );

    // ignore: use_build_context_synchronously
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              SizedBox(
                height: 30,
              ),
              Text(
                "Post Your Task",
                style: GoogleFonts.bebasNeue(
                  fontSize: 52,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 237, 234, 234),
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: TextField(
                      controller: _TitleController,
                      decoration: InputDecoration(
                          border: InputBorder.none, hintText: "Title"),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: DropdownButton<String>(
                      hint: Text('Choose Category'),
                      value: TaskselectedCategory,
                      isExpanded: true,
                      items: adj.keys
                          .map((value) => DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              ))
                          .toList(),
                      onChanged: (category) {
                        setState(() {
                          if (category != TaskselectedCategory) {
                            TaskselectedSubCategory = null;
                          }
                          TaskselectedCategory = category;
                          subCategoryChosen = adj[TaskselectedCategory]!;
                        });
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: DropdownButton<String>(
                      hint: Text(' Sub-Category'),
                      value: TaskselectedSubCategory,
                      isExpanded: true,
                      items: subCategoryChosen
                          .map((value) => DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              ))
                          .toList(),
                      onChanged: (category) {
                        setState(() {
                          TaskselectedSubCategory = category;
                        });
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: DropdownButton<String>(
                      hint: Text('Budget'),
                      value: pricerange,
                      isExpanded: true,
                      items: items
                          .map((value) => DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              ))
                          .toList(),
                      onChanged: (category) {
                        setState(() {
                          pricerange = category;
                        });
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: DropdownButton<String>(
                      hint: Text('TimeLine'),
                      value: timeline,
                      isExpanded: true,
                      items: items
                          .map((value) => DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              ))
                          .toList(),
                      onChanged: (category) {
                        setState(() {
                          timeline = category;
                        });
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0, bottom: 30.0),
                    child: TextField(
                      maxLines: 5,
                      controller: _DetailsController,
                      decoration: InputDecoration(
                          border: InputBorder.none, hintText: "Details"),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: GestureDetector(
                  onTap: () async {
                    await Submit();
                  },
                  child: Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.blueGrey,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        "Submit",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
