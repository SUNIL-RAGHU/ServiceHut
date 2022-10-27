import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:svlp/Models/itemmodel.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
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
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          title: Text("Accept New Providers"),
          leading: Icon(Icons.arrow_back),
        ),
        body: Container(
          padding: EdgeInsets.all(10),
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: itemData.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    color: Colors.grey[300],
                    child: ListTile(
                      title: Text('Item ${itemData[index].Title.toString()}'),
                      subtitle: Text(itemData[index].discription.toString()),
                      trailing: Icon(Icons.arrow_circle_right),
                    ),
                  ),
                );
              }),
        ),
      ),
    );
  }
}