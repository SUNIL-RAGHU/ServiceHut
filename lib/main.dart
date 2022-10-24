import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:svlp/Views/Homepage.dart';
import 'package:svlp/Views/login_page.dart';
import 'package:svlp/Views/posttask.dart';
import 'package:svlp/Views/searchbar.dart';

import 'Views/buyerfilter.dart';
import 'Views/providerdashboard.dart';
import 'auth/main_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Providerdashboard(),
    );
  }
}
