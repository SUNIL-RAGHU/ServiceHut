// ignore_for_file: unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:svlp/Views/recentproviderdashboard.dart';
// import 'package:razorpay_flutter/razorpay_flutter.dart';
// import 'package:fluttertoast/fluttertoast.dart';

import '../Models/itemmodel.dart';
import '../Models/taskdetail.dart';

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
  int _selectedIndex = 0;
  List<Taskdetail> ds = [];

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
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Tasks').snapshots(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            FirebaseFirestore.instance
                .collection('Tasks')
                .get()
                .then((QuerySnapshot querySnapshot) {
              for (var doc in querySnapshot.docs) {
                if (doc.get("isAccepted:true")) print(true);
                ds.add(Taskdetail.fromMap(doc.data()));
              }
            });

            return SafeArea(
              child: Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.blueGrey,
                  title: Text("Accept New Tasks"),
                  leading: Icon(Icons.arrow_back),
                ),
                body: Container(
                  padding: EdgeInsets.all(10),
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: ds.length,
                      itemBuilder: (BuildContext context, int index) {
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
                                          RecentProviderdashboard()),
                                );
                              },
                              child: ListTile(
                                title: Text('${ds[index].Title.toString()}'),
                                trailing: Icon(Icons.arrow_circle_right),
                              ),
                            ),
                          ),
                        );
                      }),
                ),
              ),
            );
          }
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        });
  }
}
