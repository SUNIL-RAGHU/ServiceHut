import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:svlp/Views/posttask.dart';

class Buyerfilter extends StatefulWidget {
  const Buyerfilter({super.key});

  @override
  State<Buyerfilter> createState() => _BuyerfilterState();
}

class _BuyerfilterState extends State<Buyerfilter> {
  Map<String, List<String>> adj = {
    "Carpenter": [
      'General Carpentry Work',
      'Repair Work',
      'Assembly & Installation',
      'Door & Window Install',
      'sofa and other units repair'
    ],
    "Painter": [
      "Wall painting",
      "Wall paper installation",
    ]
  };

  List<String> subCategoryChosen = [];
  List<String> selectedSubcategories = [];
  String? selectedCategory;
  String? selectedProvince;

  final duplicateItems = [
    'General Carpentry Work',
    'Repair Work',
    'Assembly & Installation',
    'Door & Window Install',
    'sofa and other units repair'
  ];
  var items = [];

  @override
  void initState() {
    items.addAll(duplicateItems);
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
        body: Stack(children: [
      Container(
          padding: EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 15,
          ),
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.only(
                  bottom: 4.0, top: 50.0, left: 22.0, right: 22.0),
              child: TextField(
                onChanged: (value) {
                  filterSearchResults(value);
                },
                decoration: InputDecoration(
                    hintText: "Search",
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25.0)))),
              ),
            ),
            SizedBox(
              height: 50,
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
                      child: DropdownButton<String>(
                          hint: Text('Choose Category'),
                          value: selectedCategory,
                          isExpanded: true,
                          items: adj.keys
                              .map((value) => DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  ))
                              .toList(),
                          onChanged: (category) {
                            // if (country == 'USA') {
                            //   provinces = usaProvince;
                            // } else if (country == 'India') {
                            //   provinces = indiaProvince;
                            // } else {
                            //   provinces = [];
                            // }
                            setState(() {
                              selectedCategory = category;
                              subCategoryChosen = adj[selectedCategory]!;
                            });
                          }))),
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
                  child: DropdownButton<String>(
                    hint: Text('Choose SubCategory'),
                    value: selectedProvince,
                    isExpanded: true,
                    items: subCategoryChosen.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (province) {
                      setState(() {
                        selectedProvince = province!;
                      });
                    },
                  ),
                ),
              ),
            ),
            Expanded(
                child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) => Card(
                elevation: 1,
                margin: const EdgeInsets.all(10),
                child: ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Taskpost()),
                    );
                  },
                  leading: CircleAvatar(
                    backgroundColor: Colors.purple,
                  ),
                  title: Text(items[index]),
                  subtitle: Text(items[index]),
                ),
              ),
            ))
          ]))
    ]));
  }
}
