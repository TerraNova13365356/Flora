import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flora1/db/db_functions/db_functions.dart';
import 'package:flora1/progress_page/progress_page.dart';
import 'package:flora1/sign_up/sign_up_page_User_info.dart';
import 'package:flora1/splash_screen.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Platform.isAndroid
      ? await Firebase.initializeApp(
          options: const FirebaseOptions(
            apiKey: "AIzaSyB4F8cxe2f9Jp5tBIHKd6cAS3yB625_5QA",
            appId: "1:1052249878381:android:7aef52d7a4b7322bf6b464",
            messagingSenderId: "1052249878381",
            projectId: "flora-4bcf1",
          ),
        )
      : await Firebase.initializeApp();

  runApp(const MyApp());
  await opendb();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 21, 255, 0)),
        useMaterial3: true,
      ),
      home: splash_screen(),
    );
  }
}
