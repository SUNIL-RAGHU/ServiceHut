import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:svlp/Models/ProviderDetails.dart';

class ProviderInfovalidation extends StatefulWidget {
  Providerdetails detailsProvider;
  ProviderInfovalidation({super.key, required this.detailsProvider});

  @override
  State<ProviderInfovalidation> createState() => _ProviderInfovalidationState();
}

class _ProviderInfovalidationState extends State<ProviderInfovalidation> {
  Providerdetails ProviderDetails = Providerdetails();
  @override
  void initState() {
    super.initState();
    ProviderDetails = widget.detailsProvider;
  }

  Future onsubmit() async {
    var collection = FirebaseFirestore.instance.collection('User');

    collection
        .doc(ProviderDetails.Uid)
        .update({'isAccepted': true}) // <-- Updated data
        .then((_) => print('Success'))
        .catchError((error) => print('Failed: $error'));
    Navigator.pop(context);
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
                "Provider Info",
                style: GoogleFonts.bebasNeue(
                  fontSize: 52,
                ),
              ),
              ClipOval(
                child: SizedBox.fromSize(
                  child: Image.network(
                    ProviderDetails.Profilepics!,
                    width: 160,
                    height: 160,
                    fit: BoxFit.cover,
                  ),
                ),
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
                    child: TextField(
                      enabled: false,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Name:  ${ProviderDetails.Name}",
                          hintStyle: TextStyle(color: Colors.black)),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
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
                    child: TextField(
                      enabled: false,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText:
                              "Mobile Number:${ProviderDetails.PhoneNumber}"),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
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
                      enabled: false,
                      maxLines: 5,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "About:${ProviderDetails.About}"),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
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
                    child: TextField(
                      enabled: false,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Category:  ${ProviderDetails.Category}",
                          hintStyle: TextStyle(color: Colors.black)),
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
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Wrap(
                      spacing: 2.0,
                      runSpacing: 1.0,
                      children: List.generate(
                          ProviderDetails.SubCategory!.length,
                          (index) => chip(ProviderDetails.SubCategory![index],
                              Colors.lightBlue)),
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
                    child: TextField(
                      enabled: false,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText:
                              "Location: Latitude: ${ProviderDetails.Latitude},Longitude:${ProviderDetails.Longitude} ",
                          hintStyle: TextStyle(color: Colors.black)),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text("Uploaded works"),
              const SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Expanded(
                  child: GridView.builder(
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    itemCount: ProviderDetails.WorkdoneImages!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: GridTile(
                            child: Image.network(
                              (ProviderDetails.WorkdoneImages![index]),
                              height: 100,
                              width: 100,
                            ),
                          ));
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text("Documents"),
              const SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Expanded(
                  child: GridView.builder(
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    itemCount: ProviderDetails.Id_proofs!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: GridTile(
                            child: Image.network(
                              (ProviderDetails.Id_proofs![index]),
                              height: 100,
                              width: 100,
                            ),
                          ));
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                      padding: EdgeInsets.all(40),
                      child: ElevatedButton(
                        onPressed: (() {}),
                        child: const Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Text("Accept"),
                        ),
                      )),
                  Padding(
                      padding: EdgeInsets.all(40),
                      child: ElevatedButton(
                        onPressed: (() {}),
                        child: const Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Text("Reject"),
                        ),
                      )),
                ],
              )
            ]),
          ),
        ),
      ),
    );
  }

  Widget chip(String label, Color color) {
    return Chip(
      labelPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      label: Text(
        label,
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      backgroundColor: color,
      elevation: 1.0,
      shadowColor: Colors.grey[60],
    );
  }
}
