
// ignore_for_file: prefer_const_constructors

import 'package:chat_app_push_notification/screens/auth_screen.dart';
import 'package:chat_app_push_notification/screens/chat_sreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Chat',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        backgroundColor: Colors.blue,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
        ),
      ),
      home: StreamBuilder(stream: FirebaseAuth.instance.authStateChanges(), builder: (context, userSnapShot) {
        if (userSnapShot.hasData) {
          return ChatScreen();
        }
        return AuthScreen();
      },),
    );
  }
}
