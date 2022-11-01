/* GridView.builder(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                childAspectRatio: 3 / 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20),
            itemCount: myProducts.length,
            itemBuilder: (BuildContext ctx, index) {
              return Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(15)),
                child: Text(myProducts[index]),
              );
            }),
            */
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:svlp/Views/buyerfilter.dart';

class Search extends StatefulWidget {
  String? id;
  Search({super.key, required this.id});

  @override
  _SearchState createState() => new _SearchState();
}

class _SearchState extends State<Search> {
  Position? _currentPosition;
  String? Latitude;
  String? Longitude;
  String? _currentAddress;

  TextEditingController editingController = TextEditingController();

  final duplicateItems = [
    'General Carpentry Work',
    'Repair Work',
    'Assembly & Installation',
    'Door & Window Install',
    'sofa and other units repair'
  ];

  Map<String, String> BuyerDashboardImage = {
    "Carpenter": "https://unsplash.com/photos/IvzvlKQwjk8",
    "Ac Repair Services":
        "https://www.freepik.com/free-photo/hvac-technician-working-capacitor-part-condensing-unit-male-worker-repairman-uniform-repairing-adjusting-conditioning-system-diagnosing-looking-technical-issues_10444780.htm#query=air%20conditioner%20repair&position=9&from_view=keyword",
    "Painting":
        "https://www.freepik.com/free-photo/portrait-repairer-woman-with-painting-roller-isolated_4410817.htm#query=PAINTER&position=0&from_view=search&track=sph",
    "Pest Control Services": "https://unsplash.com/photos/wz3ijPHvL54",
    "Housekeeping services": "",
    "Welding/fabricator": "",
    "Plumber services": "",
    "CCTV installation": "",
    "Electrician": "",
    "Beauty & Makeup": "",
    "Civil Works/Interior decorator": "",
    "Scrap Collection": "",
    "Yoga & Fitness": "",
    "Home Chefs": "",
    "Home tutors": "",
    "Dance & Music trainers": "",
    "Language trainers": "",
    "Computer (IT trainers)": "",
    "Hamal(General Labor) ": "",
    "Packer & Movers": "",
    "Healthcare": "",
    "Real Estate": "",
    "Appliances repair ": "",
    "Cook/Chef/Aayah": ""
  };
  var items = [];

  @override
  void initState() {
    items.addAll(duplicateItems);
    // final id = id;
    super.initState();
  }

  void filterSearchResults(String query) {
    List<String> dummySearchList = [];
    dummySearchList.addAll(duplicateItems);
    if (query.isNotEmpty) {
      List<String> dummyListData = [];
      dummySearchList.forEach((item) {
        if (item.contains(query)) {
          dummyListData.add(item);
        }
      });
      setState(() {
        items.clear();
        items.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        items.clear();
        items.addAll(duplicateItems);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      // appBar: AppBar(
      //   title: Text(
      //     'Sign out',
      //     style: TextStyle(fontSize: 16),
      //   ),
      //   actions: [
      //     GestureDetector(
      //         onTap: (() async {
      //           try {
      //             await FirebaseAuth.instance.signOut();
      //           } catch (e) {
      //             log(e.toString());
      //           }
      //         }),
      //         child: Icon(Icons.logout)),
      //   ],
      // ),
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 15,
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      bottom: 4.0, top: 100.0, left: 22.0, right: 22.0),
                  child: TextField(
                    onChanged: (value) {
                      filterSearchResults(value);
                    },
                    controller: editingController,
                    decoration: InputDecoration(
                        hintText: "Search",
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(25.0)))),
                  ),
                ),
                Expanded(
                  child: GridView.builder(
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 200,
                              childAspectRatio: 3 / 2,
                              crossAxisSpacing: 20,
                              mainAxisSpacing: 20),
                      itemCount: BuyerDashboardImage.length,
                      itemBuilder: (BuildContext ctx, index) {
                        String? key = BuyerDashboardImage.keys.elementAt(index);

                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Buyerfilter(
                                        category: key,
                                        Id: widget.id,
                                      )),
                            );
                          },
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: Colors.amber,
                                borderRadius: BorderRadius.circular(15)),
                            //      adj.keys
                            // .map((value) => DropdownMenuItem<String>(
                            //       value: value,
                            //       child: Text(value),
                            //     ))
                            // .toList(),
                            child: Stack(children: [Text(key)]),
                          ),
                        );
                      }),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
