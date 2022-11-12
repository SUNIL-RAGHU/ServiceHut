import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:svlp/Models/taskdetail.dart';
// import 'package:razorpay_flutter/razorpay_flutter.dart';
// import 'package:fluttertoast/fluttertoast.dart';

class RecentProviderdashboard extends StatefulWidget {
  const RecentProviderdashboard({super.key});

  @override
  State<RecentProviderdashboard> createState() =>
      _RecentProviderdashboardState();
}

class _RecentProviderdashboardState extends State<RecentProviderdashboard> {
  bool isLoaded = false;

  @override
  void initState() {
    super.initState();
    // _razorpay = Razorpay();
    // _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    // _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    // _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    super.dispose();
    // _razorpay.clear();
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
                title: const Text("Accept New Tasks"),
                leading: const Icon(Icons.arrow_back),
              ),
              body: ListView(
                children: documents.map(
                  (doc) {
                    Map data = (doc.data() as Map);
                    Taskdetail currentTask = Taskdetail.fromMap(data);
                    // if (data["isAccepted"]) {
                    if (currentTask.BuyerAccepted == true &&
                        currentTask.isAccepted == true) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          color: Colors.grey[300],
                          child: GestureDetector(
                            onTap: () {},
                            child: ListTile(
                              title: Text(currentTask.Title.toString()),
                              trailing: const Icon(Icons.arrow_circle_right),
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
