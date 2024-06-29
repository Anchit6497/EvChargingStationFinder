import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter_application_1/global/common/toast.dart';


class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signUpWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return credential.user;
    } on FirebaseAuthException catch (e) {
      if(e.code == 'email-already-in-use'){
        showToast(meassage:'The Email is already in use.');
      }
      else{
        showToast(meassage: 'An Error occured');
      }
       return null;
    }
   
  }

  Future<User?> signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return credential.user;
    } on FirebaseAuthException catch (e) {
        if(e.code == 'user-not-found'|| e.code == 'wrong-password'){
          showToast(meassage: 'Invalid Email or Password');
        }
        else{
          showToast(meassage: 'An Error Occured:${e.code}');
        }
   return null;
    }
       
  }
}
