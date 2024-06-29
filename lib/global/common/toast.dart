import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showToast({required String meassage}){
  Fluttertoast.showToast(
  msg:meassage,
  toastLength: Toast.LENGTH_SHORT,
  gravity:ToastGravity.BOTTOM,
  timeInSecForIosWeb: 1,
  backgroundColor: Colors.red,
  textColor:Colors.white,
  fontSize: 16.0,
  
  );
}

void showToast1({required String meassage}){
  Fluttertoast.showToast(
  msg:meassage,
  toastLength: Toast.LENGTH_SHORT,
  gravity:ToastGravity.BOTTOM,
  timeInSecForIosWeb: 1,
  backgroundColor: Colors.blue,
  textColor:Colors.white,
  fontSize: 16.0,
  
  );
}