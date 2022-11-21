import 'package:chatappdemo/screens/home_screen.dart';
import 'package:chatappdemo/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Authenication extends StatefulWidget {
  const Authenication({Key? key}) : super(key: key);

  @override
  _AuthenicationState createState() => _AuthenicationState();
}

class _AuthenicationState extends State<Authenication> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    if(_auth.currentUser == null) {
      return LoginScreen();
    } else {
      return HomeScreen();
    }
  }
}
