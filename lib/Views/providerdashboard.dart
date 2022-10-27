// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../Models/itemmodel.dart';

class Providerdashboard extends StatefulWidget {
  const Providerdashboard({super.key});

  @override
  State<Providerdashboard> createState() => _ProviderdashboardState();
}

class _ProviderdashboardState extends State<Providerdashboard> {
  late Razorpay _razorpay;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  List<ItemModel> itemData = <ItemModel>[
    ItemModel(
        Title: 'Android',
        Details:
            "Android is a mobile operating system based on a modified version of the Linux kernel and other open source software, designed primarily for touchscreen mobile devices such as smartphones and tablets. ... Some well known derivatives include Android TV for televisions and Wear OS for wearables, both developed by Google.",
        colorsItem: Colors.green,
        img: 'assets/images/android_img.png'),
    ItemModel(
        Title: 'Ios',
        Details:
            "Android is a mobile operating system based on a modified version of the Linux kernel and other open source software, designed primarily for touchscreen mobile devices such as smartphones and tablets. ... Some well known derivatives include Android TV for televisions and Wear OS for wearables, both developed by Google.",
        colorsItem: Colors.green,
        img: 'assets/images/android_img.png'),
  ];

  void openCheckOut() async {
    var options = {
      'key': 'rzp_test_Wqht0mnu0BOleA',
      'amount': 100,
      'name': 'Acme Corp.',
      'description': 'Fine T-Shirt',
      'prefill': {'contact': '8888888888', 'email': 'test@razorpay.com'}
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('ERROR:e');
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    Fluttertoast.showToast(
        msg: "Success" + response.paymentId!, toastLength: Toast.LENGTH_SHORT);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(
        msg: "ERROR" + response.code.toString() + " -" + response.message!,
        toastLength: Toast.LENGTH_SHORT);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
        msg: "External Wallet" + response.walletName!,
        toastLength: Toast.LENGTH_SHORT);
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text("Your Dashboard"),
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 20.0, top: 10.0, bottom: 5),
              child: ElevatedButton(
                onPressed: openCheckOut,
                child: Text("Your Premimum"),
              )),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: ListView.builder(
          itemCount: itemData.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: ListTile(
                  title: Text('Item ${itemData[index].Title.toString()}'),
                  subtitle: Text(itemData[index].discription.toString()),
                  trailing: Icon(Icons.arrow_circle_right),
                ),
              ),
              // child: ExpansionPanelList(
              //   animationDuration: Duration(milliseconds: 500),
              //   elevation: 1,
              //   children: [
              //     ExpansionPanel(
              //       body: Container(
              //         child: Column(
              //           crossAxisAlignment: CrossAxisAlignment.start,
              //           children: [
              //             // Text(
              //             //   "Title:" + itemData[index].Title.toString(),
              //             //   style: TextStyle(
              //             //       color: Colors.grey[700],
              //             //       fontSize: 25,
              //             //       letterSpacing: 0.3,
              //             //       height: 1.3),
              //             // ),
              //             Text(
              //               "subcategory:" + itemData[index].Title.toString(),
              //               style: TextStyle(
              //                   color: Colors.grey[700],
              //                   fontSize: 20,
              //                   letterSpacing: 0.3,
              //                   height: 1.3),
              //             ),
              //             SizedBox(
              //               height: 10,
              //             ),

              //             const SizedBox(
              //               height: 10,
              //             ),
              //             Text(
              //               "Category:" + itemData[index].Title.toString(),
              //               style: TextStyle(
              //                   color: Colors.grey[700],
              //                   fontSize: 20,
              //                   letterSpacing: 0.3,
              //                   height: 1.3),
              //             ),
              //             SizedBox(
              //               height: 10,
              //             ),
              //             Text(
              //               "subcategory:" + itemData[index].Title.toString(),
              //               style: TextStyle(
              //                   color: Colors.grey[700],
              //                   fontSize: 20,
              //                   letterSpacing: 0.3,
              //                   height: 1.3),
              //             ),
              //             SizedBox(
              //               height: 10,
              //             ),
              //             Text(
              //               "Price:" + itemData[index].Title.toString(),
              //               style: TextStyle(
              //                   color: Colors.grey[700],
              //                   fontSize: 20,
              //                   letterSpacing: 0.3,
              //                   height: 1.3),
              //             ),
              //             SizedBox(
              //               height: 10,
              //             ),
              //             Text(
              //               "Timing:" + itemData[index].Title.toString(),
              //               style: TextStyle(
              //                   color: Colors.grey[700],
              //                   fontSize: 20,
              //                   letterSpacing: 0.3,
              //                   height: 1.3),
              //             ),
              //             // ignore: prefer_const_constructors
              //             SizedBox(
              //               height: 10,
              //             ),
              //             Text(
              //               "About:" + itemData[index].Title.toString(),
              //               style: TextStyle(
              //                   color: Colors.grey[700],
              //                   fontSize: 20,
              //                   letterSpacing: 0.3,
              //                   height: 1.3),
              //             ),
              //             ElevatedButton(
              //               onPressed: () {},
              //               child: Text("Interseted"),
              //             )
              //           ],
              //         ),
              //       ),
              //       headerBuilder: (BuildContext context, bool isExpanded) {
              //         return Container(
              //           padding: EdgeInsets.all(10),
              //           child: Text(
              //             itemData[index].Title!,
              //             style: TextStyle(
              //               color: itemData[index].colorsItem,
              //               fontSize: 18,
              //             ),
              //           ),
              //         );
              //       },
              //       isExpanded: itemData[index].expanded,
              //     )
              //   ],
              //   expansionCallback: (int item, bool status) {
              //     setState(() {
              //       itemData[index].expanded = !itemData[index].expanded;
              //     });
              //   },
              // ),
            );
          },
        ),
      ),
    );
  }
}
