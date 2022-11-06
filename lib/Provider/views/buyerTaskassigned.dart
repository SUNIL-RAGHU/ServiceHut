import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:svlp/Models/taskdetail.dart';

class ProviderTaskview extends StatefulWidget {
  Taskdetail DetailsofTask = Taskdetail();
  ProviderTaskview({super.key, required this.DetailsofTask});

  @override
  State<ProviderTaskview> createState() => _ProviderTaskviewState();
}

class _ProviderTaskviewState extends State<ProviderTaskview> {
  // var user = FirebaseAuth.instance.currentUser;

  // ignore: non_constant_identifier_names
  Taskdetail Ls = Taskdetail();
  @override
  void initState() {
    super.initState();
    Ls = widget.DetailsofTask;
  }

  Future onsubmit() async {
    var collection = FirebaseFirestore.instance.collection('Tasks');

    collection
        .doc(Ls.Uid)
        .update({'BuyerAccepted': true}) // <-- Updated data
        .then((_) => print('Success'))
        .catchError((error) => print('Failed: $error'));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    print(Ls.Title.toString());
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              // ignore: prefer_const_constructors
              SizedBox(
                height: 30,
              ),
              Text(
                // "Task Info",
                "Task Assigned",
                style: GoogleFonts.bebasNeue(
                  fontSize: 52,
                ),
              ),
              // ignore: avoid_print

              // ignore: prefer_const_constructors
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
                          hintText: "Title:" + Ls.Title.toString()),
                    ),
                  ),
                ),
              ),
              // ignore: prefer_const_constructors
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
                              "Category:" + Ls.TaskSelectedCategory.toString()),
                    ),
                  ),
                ),
              ),
              // ignore: prefer_const_constructors
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
                          // ignore: prefer_interpolation_to_compose_strings
                          hintText: "SubCategory:" +
                              Ls.TaskselectedSubCategory.toString()),
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
                          hintText: "PriceRange:" + Ls.pricerange.toString()),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
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
                          hintText: "Duration:" + Ls.timeline.toString()),
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
                          hintText: "Details:" + Ls.Details.toString()),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),

              SizedBox(
                height: 10,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                      padding: EdgeInsets.all(40),
                      child: ElevatedButton(
                        onPressed: (() {
                          onsubmit();
                        }),
                        child: const Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Text("Interested"),
                        ),
                      )),
                  Padding(
                      padding: EdgeInsets.all(40),
                      child: ElevatedButton(
                        onPressed: (() {}),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
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
}
