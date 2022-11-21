import 'package:chatappdemo/screens/login_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<User> createAccount(String name, String email, String password) async {
  FirebaseAuth _auth = FirebaseAuth.instance;

  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  try {
    User user = (await _auth.createUserWithEmailAndPassword(
            email: email, password: password))
        .user!;

    if (user != null) {
      print("Registration successful");
      user.updateDisplayName(name);
      await _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .set({"name": name, "email": email, "status": "Unavailable"});
      return user;
    } else {
      print("Registration not successful");
      return user;
    }
  } catch (e) {
    print("error: ${e}");
    return Future.value(null);
  }
}

Future<User> login(String email, String password) async {
  FirebaseAuth _auth = FirebaseAuth.instance;
  try {
    User user = (await _auth.signInWithEmailAndPassword(
            email: email, password: password))
        .user!;
    if (user != null) {
      print("Login successful");
      return user;
    } else {
      print("Login not successful");
      return user;
    }
  } catch (e) {
    print("error: ${e}");
    return Future.value(null);
  }
}

Future logOut(BuildContext context) async {
  FirebaseAuth _auth = FirebaseAuth.instance;

  try {
    await _auth.signOut().then((user) => Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
        (route) => false));
  } catch (e) {
    print("error: ${e}");
  }
}
