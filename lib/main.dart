import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:svlp/AdminPanel/views/AdminDashboard.dart';
import 'package:svlp/Authorization/login_page.dart';

import 'package:svlp/Provider/views/providerProfilePage.dart';
import 'package:svlp/navigations/Admintabbar.dart';

import 'AdminPanel/views/Providerinfo.dart';
import 'auth/Role.dart';
import 'navigations/Providertabbar.dart';

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
      home: const LoginPage(),
    );
  }
}
