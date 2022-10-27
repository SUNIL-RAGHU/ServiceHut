import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  static const myUser = User(
    imagePath:
        'https://images.unsplash.com/photo-1554151228-14d9def656e4?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=333&q=80',
    name: 'Sarah Abs',
    phonenumber: '9876543210',
    location: "arni",
    Category: "Carpenter",
    subcategory: [
      "general repair and paint",
    ],
    about:
        'Certified Personal Trainer and Nutritionist with years of experience in creating effective diets and training plans focused on achieving individual customers goals in a smooth way.',
  );
  final user = myUser;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: ListView(children: [
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Center(child: buildImage()),
        ),
        const SizedBox(height: 24),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 48),
          child: Column(
            children: [
              Text(
                user.name,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    user.phonenumber,
                    style: TextStyle(color: Colors.grey),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.location_history),
                  ),
                  Text(
                    user.location,
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 4),
                ],
              ),
              Text(
                user.Category,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
              SizedBox(height: 10),
              Wrap(
                spacing: 10,
                children: List.generate(user.subcategory!.length,
                    (index) => chip(user.subcategory![index], Colors.green)),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        // ListView.builder(
        //   shrinkWrap: true,
        //   scrollDirection: Axis.horizontal,
        //   itemCount: user.subcategory?.length,
        //   itemBuilder: (BuildContext context, int index) {
        //     return Wrap(
        //       spacing: 2.0,
        //       runSpacing: 1.0,
        //       children: [chip(user.subcategory![index], Colors.green)],
        //     );
        //   },
        // ),

        buildAbout(user),
        SizedBox(
          height: 10,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 48.0),
            child: GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    childAspectRatio: 3 / 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20),
                itemCount: user.name.length,
                itemBuilder: (BuildContext ctx, index) {
                  return Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(15)),
                    child: Stack(children: [Text(user.name.toString())]),
                  );
                }),
          ),
        ),
      ]),
    ));
  }
  // ),(
  //   child: Padding(
  //     padding: const EdgeInsets.symmetric(horizontal: 48.0),
  //     child: Center(
  //       child: Wrap(
  //         spacing: 5.0,
  //         runSpacing: 1.0,
  //         children: <Widget>[
  //           chip('Health', Color(0xFFff8a65)),
  //           chip('Food', Color(0xFF4fc3f7)),
  //           chip('Lifestyle', Color(0xFF9575cd)),
  //           chip('Sports', Color(0xFF4db6ac)),
  //           chip('Nature', Color(0xFF5cda65)),
  //           chip('Learn', Color(0xFFacbb65)),
  //         ],
  //       ),
  //     ),

  Widget buildName(User user) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 48),
        child: Column(
          children: [
            Text(
              user.name,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  user.phonenumber,
                  style: TextStyle(color: Colors.grey),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(Icons.location_history),
                ),
                Text(
                  user.location,
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 4),
                Text(
                  user.Category,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                ),
              ],
            )
          ],
        ),
      );
  Widget chip(String label, Color color) {
    return Chip(
      labelPadding: EdgeInsets.all(5.0),
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

  Widget buildImage() {
    final image = NetworkImage(user.imagePath);

    return ClipOval(
      child: Material(
        color: Colors.transparent,
        child: Ink.image(
          image: image,
          fit: BoxFit.cover,
          width: 128,
          height: 128,
        ),
      ),
    );
  }
}

Widget buildAbout(User user) => Container(
      padding: EdgeInsets.symmetric(horizontal: 48),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'About',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Text(
            user.about,
            style: TextStyle(fontSize: 16, height: 1.4),
          ),
        ],
      ),
    );

class User {
  final String imagePath;
  final String name;
  final String phonenumber;
  final String about;
  final String location;
  final String Category;
  final List<String>? subcategory;

  const User({
    required this.imagePath,
    required this.name,
    required this.phonenumber,
    required this.location,
    required this.about,
    required this.Category,
    required this.subcategory,
  });
}
