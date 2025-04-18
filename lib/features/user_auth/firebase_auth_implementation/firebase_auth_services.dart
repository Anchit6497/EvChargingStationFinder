import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/global/common/toast.dart';


class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

 void isUserAlreadyLoggedIn(BuildContext context) async {
  FirebaseAuth.instance.authStateChanges().listen((User? user) {
    if (user != null) {
      Navigator.pushNamed(context, "/home");
    } else {
      Navigator.pushNamed(context, "/login");
    }
  });
}




  Future<User?> signUpWithEmailAndPassword(String email, String password, String fullname) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      await storeUserData(credential.user!.uid, fullname, email);
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

  

  Future<User?> signInWithEmailAndPassword(String email, String password) async {
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

  Future<void> storeUserData(String uid, String fullname, String email) async {
    var store = FirebaseFirestore.instance.collection('users').doc(uid);
    await store.set({
      'fullname': fullname,
      'email': email
    });
  }
}
