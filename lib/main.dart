import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:svlp/AdminPanel/views/AllProviderInfo.dart';
import 'package:svlp/AdminPanel/views/ProviderInfovalid.dart';
import 'package:svlp/AdminPanel/views/TaskInfovalid.dart';
import 'package:svlp/Authorization/SigninBuyer.dart';
import 'package:svlp/Authorization/login_page.dart';
import 'package:svlp/Views/posttask.dart';
import 'package:svlp/Views/profilpage.dart';
import 'package:svlp/Views/providerdashboard.dart';
import 'package:svlp/Views/recentproviderdashboard.dart';
import 'package:svlp/Authorization/SigninProvider.dart';
import 'package:svlp/navigations/tabbar.dart';

import 'AdminPanel/views/AdminDashboard.dart';

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
    return MaterialApp(debugShowCheckedModeBanner: false, home: RegisterPage());
  }
}
