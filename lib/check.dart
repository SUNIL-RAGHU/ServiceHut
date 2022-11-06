// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:svlp/Models/taskdetail.dart';

// import 'Models/UserModel.dart';

// class name extends StatefulWidget {
//   const name({super.key});

//   @override
//   State<name> createState() => _nameState();
// }

// class _nameState extends State<name> {
//   var user = FirebaseAuth.instance.currentUser;

//   List<Taskdetail> ds = [];

//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder(
//       stream: FirebaseFirestore.instance.collection('Tasks').snapshots(),
//       builder: (BuildContext context, AsyncSnapshot snapshot) {
//         if (snapshot.hasData) {
//           FirebaseFirestore.instance
//               .collection('Tasks')
//               .get()
//               .then((QuerySnapshot querySnapshot) {
//             querySnapshot.docs.forEach((doc) {
//               ds.add(Taskdetail.fromMap(doc.data()));
//             });
//           });
//           print(ds[1].Title.toString());

//           return Scaffold(
//               body: ListView.builder(
//                   itemCount: ds.length,
//                   itemBuilder: (ctx, index) {
//                     return Text(ds[index].Title!);
//                   }));
//         }
//         return const Scaffold(
//           body: Center(child: CircularProgressIndicator()),
//         );
//       }
      
//         return StreamBuilder(
//         // future: FirebaseFirestore.instance.collection('Tasks').get(),
//         stream: FirebaseFirestore.instance
//             .collection('Users')
//             .doc(FirebaseAuth.instance.currentUser!.uid)
//             .snapshots(),
//     );
//   }
// }
