import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
// import 'package:razorpay_flutter/razorpay_flutter.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:svlp/navigations/tabbar.dart';

import '../Models/itemmodel.dart';

class RecentProviderdashboard extends StatefulWidget {
  const RecentProviderdashboard({super.key});

  @override
  State<RecentProviderdashboard> createState() =>
      _RecentProviderdashboardState();
}

class _RecentProviderdashboardState extends State<RecentProviderdashboard> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
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

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text("Your Dashboard"),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Recent Works",
                style: TextStyle(fontSize: 20),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: itemData.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ExpansionPanelList(
                    animationDuration: Duration(milliseconds: 500),
                    elevation: 1,
                    children: [
                      ExpansionPanel(
                        body: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Title:" + itemData[index].Title.toString(),
                              style: TextStyle(
                                  color: Colors.grey[700],
                                  fontSize: 15,
                                  letterSpacing: 0.3,
                                  height: 1.3),
                            ),
                            // ignore: prefer_const_constructors
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Category:" + itemData[index].Title.toString(),
                              style: TextStyle(
                                  color: Colors.grey[700],
                                  fontSize: 15,
                                  letterSpacing: 0.3,
                                  height: 1.3),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "subcategory:" + itemData[index].Title.toString(),
                              style: TextStyle(
                                  color: Colors.grey[700],
                                  fontSize: 15,
                                  letterSpacing: 0.3,
                                  height: 1.3),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Price:" + itemData[index].Title.toString(),
                              style: TextStyle(
                                  color: Colors.grey[700],
                                  fontSize: 15,
                                  letterSpacing: 0.3,
                                  height: 1.3),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Timing:" + itemData[index].Title.toString(),
                              style: TextStyle(
                                  color: Colors.grey[700],
                                  fontSize: 15,
                                  letterSpacing: 0.3,
                                  height: 1.3),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "About:" + itemData[index].Title.toString(),
                              style: TextStyle(
                                  color: Colors.grey[700],
                                  fontSize: 15,
                                  letterSpacing: 0.3,
                                  height: 1.3),
                            ),
                          ],
                        ),
                        headerBuilder: (BuildContext context, bool isExpanded) {
                          return Container(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              itemData[index].Title!,
                              style: TextStyle(
                                color: itemData[index].colorsItem,
                                fontSize: 18,
                              ),
                            ),
                          );
                        },
                        isExpanded: itemData[index].expanded,
                      )
                    ],
                    expansionCallback: (int item, bool status) {
                      setState(() {
                        itemData[index].expanded = !itemData[index].expanded;
                      });
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
