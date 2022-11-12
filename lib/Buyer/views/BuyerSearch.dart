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
import 'package:svlp/Buyer/views/buyerfilter.dart';

class Search extends StatefulWidget {
  String? id;
  Search({super.key, required this.id});

  @override
  _SearchState createState() => new _SearchState();
}

class _SearchState extends State<Search> {
  Position? _currentPosition;
  String? Latitude;
  // ignore: non_constant_identifier_names
  String? Longitude;
  String? _currentAddress;

  TextEditingController editingController = TextEditingController();

  // ignore: non_constant_identifier_names
  Map<String, String> BuyerDashboardImage = {
    "Carpenter":
        "https://images.pexels.com/photos/5974296/pexels-photo-5974296.jpeg?cs=srgb&dl=pexels-ono-kosuki-5974296.jpg&fm=jpg&_gl=1*1odpn72*_ga*MjA5NTM5NjI1MC4xNjY3ODgzNjkx*_ga_8JE65Q40S6*MTY2Nzg4MzcyOC4xLjEuMTY2Nzg4Mzg0NS4wLjAuMA",
    "Ac Repair Services": "",
    "Painting": "",
    "Pest Control Services": "https://unsplash.com/photos/wz3ijPHvL54",
    "Housekeeping services": "https://unsplash.com/photos/jjrXvzbqC5E",
    "Welding/fabricator": "https://unsplash.com/photos/d0AcxMk33is",
    "Plumber services":
        "https://www.freepik.com/free-photo/young-engineer-adjusting-autonomous-heating_13377203.htm#query=plumbing%20service&position=0&from_view=keyword",
    "CCTV installation":
        "https://www.freepik.com/free-photo/cctv-security-technology-with-lock-icon-digital-remix_15667451.htm#query=cctv&position=0&from_view=search&track=sph",
    "Electrician":
        "https://www.freepik.com/free-photo/male-electrician-works-switchboard-with-electrical-connecting-cable_19589484.htm#query=Electrician&position=5&from_view=search&track=sph",
    "Beauty & Makeup":
        "https://img.freepik.com/free-photo/beautician-with-brush-applies-white-moisturizing-mask-face-young-girl-client-spa-beauty-salon_343596-4247.jpg?w=1800&t=st=1667727701~exp=1667728301~hmac=f416131202a53e1727e3cba7895b239de89b5aa8c09cca3861b7543c9c558178",
    "Civil Works/Interior decorator":
        "https://www.freepik.com/free-photo/civil-engineer-construction-architecture-worker-are-working-construction-site-with-tablet-blueprints-planing-about-new-construction-sitecooperation-teamwork-concept_26205218.htm#query=civil%20workers&position=1&from_view=search&track=sph",
    "Scrap Collection":
        "https://www.freepik.com/free-photo/young-man-cleaning-forest-portrait-with-tin-cans_30907400.htm#query=scrap%20collecting&position=4&from_view=search&track=sph",
    "Yoga & Fitness":
        "https://www.freepik.com/free-photo/woman-sitting-yoga-pose-beach_859033.htm#query=yoga&position=1&from_view=search&track=sph",
    "Home Chefs":
        "https://www.freepik.com/free-photo/woman-chef-cooking-vegetables-pan_8380330.htm#query=home%20chefs&position=0&from_view=search&track=sph",
    "Home tutors":
        "https://www.freepik.com/free-photo/tutor-with-litthe-girl-studying-home_8355565.htm#query=home%20tutor&position=0&from_view=search&track=sph",
    "Dance & Music trainers":
        "https://www.freepik.com/free-photo/people-taking-part-dance-therapy-class_24483007.htm#query=dance%20teacher&position=33&from_view=search&track=sph",
    "Language trainers":
        "https://www.freepik.com/free-photo/learning-foreign-languages_10672323.htm#query=Language&position=32&from_view=search&track=sph",
    "Computer (IT trainers)":
        "https://www.freepik.com/free-photo/extremely-focused-male-student-taking-online-test_5890232.htm#query=computer%20training&position=1&from_view=search&track=sph",
    "Hamal(General Labor) ":
        "https://www.freepik.com/free-photo/long-shot-woman-arranging-food-kitchen_5682077.htm?query=Hamal",
    "Packer & Movers":
        "https://www.freepik.com/free-photo/black-man-moving-furniture_2893996.htm#query=Packer&position=0&from_view=search&track=sph",
    "Healthcare":
        "https://www.freepik.com/free-photo/young-handsome-physician-medical-robe-with-stethoscope_6190059.htm#query=Healthcare&position=0&from_view=search&track=sph",
    "Real Estate":
        "https://www.freepik.com/free-photo/construction-concept-with-engineering-tools_5519366.htm#query=Real%20Estate&position=23&from_view=search&track=sph",
    "Appliances repair ":
        "https://www.freepik.com/free-photo/service-man-adjusting-house-heating-system_13377134.htm#query=Appliances%20repair&position=4&from_view=search&track=sph",
    "Cook/Chef/Aayah":
        "https://www.freepik.com/free-photo/woman-chef-cooking-vegetables-pan_8380324.htm#query=Cook&position=0&from_view=search&track=sph",
    "Not found":
        "https://res.cloudinary.com/practicaldev/image/fetch/s--vKtmuHUH--/c_imagga_scale,f_auto,fl_progressive,h_720,q_auto,w_1280/https://dev-to-uploads.s3.amazonaws.com/i/7aqcppklh6bexoa70320.jpg"
  };
  List<String> items = [];

  @override
  void initState() {
    items.addAll(BuyerDashboardImage.keys);
    // final id = id;
    super.initState();
  }

  void filterSearchResults(String query) {
    query = query.toLowerCase();
    List<String> dummySearchList = [];
    dummySearchList.addAll(BuyerDashboardImage.keys);
    if (query.isNotEmpty) {
      List<String> dummyListData = [];
      for (String item in dummySearchList) {
        String check = item.toLowerCase();
        if (check.contains(query)) {
          dummyListData.add(item);
        }
      }
      setState(() {
        items.clear();
        items.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        items.clear();
        items.addAll(dummySearchList);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Home',
            style: TextStyle(fontSize: 16),
          ),
          actions: [
            TextButton.icon(
              label: const Text(
                "Sign out",
                style: TextStyle(color: Colors.white),
              ),
              icon: const Icon(Icons.logout, color: Colors.white),
              onPressed: () async {
                try {
                  await FirebaseAuth.instance.signOut();
                } catch (e) {
                  log(e.toString());
                }
              },
            )
          ]),
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 15,
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: TextField(
                    onChanged: (value) {
                      filterSearchResults(value);
                    },
                    controller: editingController,
                    decoration: const InputDecoration(
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
                      physics: const ScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 200,
                              childAspectRatio: 3 / 2,
                              crossAxisSpacing: 20,
                              mainAxisSpacing: 20),
                      itemCount: items.length,
                      itemBuilder: (BuildContext ctx, index) {
                        String key = items[index];
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
                              borderRadius: BorderRadius.circular(15),
                              image: DecorationImage(
                                image: NetworkImage(BuyerDashboardImage[key] ??
                                    BuyerDashboardImage["Not found"]!),
                              ),
                            ),
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
