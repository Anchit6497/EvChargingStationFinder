import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/global/common/toast.dart';

class FirebaseAuthServiceOwner {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void isOwnerAlreadyLoggedIn(BuildContext context) async {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        Navigator.pushNamed(context, "/ownerHome");
      } else {
        Navigator.pushNamed(context, "/ownerLogin");
      }
    });
  }

  Future<User?> signUpOwnerWithEmailAndPassword(String email, String password, String fullName, String stationName) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      await storeOwnerData(credential.user!.uid, fullName, email, stationName);
      return credential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        showToast(meassage: 'The Email is already in use.');
      } else {
        showToast(meassage: 'An Error occurred');
      }
      return null;
    }
  }

  Future<User?> signInOwnerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return credential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        showToast(meassage: 'Invalid Email or Password');
      } else {
        showToast(meassage: 'An Error Occurred: ${e.code}');
      }
      return null;
    }
  }

  Future<void> storeOwnerData(String uid, String fullName, String email, String stationName) async {
    var store = FirebaseFirestore.instance.collection('owners').doc(uid);
    await store.set({
      'fullName': fullName,
      'email': email,
      'stationName': stationName
    });
  }
}
