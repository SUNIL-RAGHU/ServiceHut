// ignore_for_file: unused_local_variable

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:svlp/Provider/views/buyerTaskassigned.dart';
import 'package:svlp/Provider/views/recentproviderdashboard.dart';
// import 'package:razorpay_flutter/razorpay_flutter.dart';
// import 'package:fluttertoast/fluttertoast.dart';

import '../../Models/taskdetail.dart';

// ignore: must_be_immutable
class Providerdashboard extends StatefulWidget {
  String id;
  Providerdashboard({super.key, required this.id});
  @override
  State<Providerdashboard> createState() => _ProviderdashboardState();
}

class _ProviderdashboardState extends State<Providerdashboard> {
  // late Razorpay _razorpay;
  // ignore: unused_field

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

  void openCheckOut() async {
    var options = {
      'key': 'rzp_test_Wqht0mnu0BOleA',
      'amount': 100,
      'name': 'Acme Corp.',
      'description': 'Fine T-Shirt',
      'prefill': {'contact': '8888888888', 'email': 'test@razorpay.com'}
    };

    // try {
    //   _razorpay.open(options);
    // } catch (e) {
    //   debugPrint('ERROR:e');
    // }
  }

  // void _handlePaymentSuccess(PaymentSuccessResponse response) {
  //   Fluttertoast.showToast(
  //       msg: "Success${response.paymentId!}", toastLength: Toast.LENGTH_SHORT);
  // }

  // void _handlePaymentError(PaymentFailureResponse response) {
  //   Fluttertoast.showToast(
  //       msg: "ERROR${response.code} -${response.message!}",
  //       toastLength: Toast.LENGTH_SHORT);
  // }

  // void _handleExternalWallet(ExternalWalletResponse response) {
  //   Fluttertoast.showToast(
  //       msg: "External Wallet${response.walletName!}",
  //       toastLength: Toast.LENGTH_SHORT);
  // }

  // ignore: unused_element
  // void _onItemTapped(int index) {
  //   setState(() {
  //     _selectedIndex = index;
  //   });
  // }

  // void parseData(AsyncSnapshot snapshot) {
  //   for (var doc in snapshot.data.docs) {
  //     ds.add(Taskdetail.fromMap(doc.data()));
  //   }
  //   if (mounted) {
  //     setState(() {
  //       isLoaded = true;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
        future: FirebaseFirestore.instance.collection('Tasks').get(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          log("build method called");
          if (snapshot.hasData) {
            final List<DocumentSnapshot> documents = snapshot.data.docs;

            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.blueGrey,
                title: const Text("Accept New Tasks"),
                actions: [
                  GestureDetector(
                      onTap: (() async {
                        try {
                          await FirebaseAuth.instance.signOut();
                        } catch (e) {
                          log(e.toString());
                        }
                      }),
                      child: const Icon(Icons.logout)),
                ],
              ),
              body: ListView(
                children: documents.map(
                  (doc) {
                    Map data = (doc.data() as Map);
                    Taskdetail currentTask = Taskdetail.fromMap(data);
                    // if (data["isAccepted"]) {
                    if (currentTask.isAccepted == true &&
                        currentTask.BuyerAccepted == false) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          color: Colors.grey[300],
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => (ProviderTaskview(
                                          DetailsofTask: currentTask,
                                        ))),
                              );
                            },
                            child: ListTile(
                              title: Text(currentTask.Title.toString()),
                              trailing: Icon(Icons.arrow_circle_right),
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
