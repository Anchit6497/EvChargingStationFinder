import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_application_1/features/user_auth/presentation/pages/createstation.dart';
import 'package:flutter_application_1/features/user_auth/presentation/pages/home_view.dart';
import 'package:flutter_application_1/global/common/toast.dart';
import 'package:get/get.dart';

class StationCreationController extends GetxController {
  var isLoading = false.obs;
  var nameController =TextEditingController();
  var aboutController = TextEditingController();
  var addressController = TextEditingController();
  var timingController = TextEditingController();
  var stationaddressController = TextEditingController();
  var phoneController = TextEditingController();
  var ratingController = TextEditingController();
  var latitudeController = TextEditingController();
  var longitudeController = TextEditingController();

 

  Future<void> CreateStation( context) async {
    isLoading(true);
    double latitude = double.parse(latitudeController.text);
      double longitude = double.parse(longitudeController.text);
    var store = FirebaseFirestore.instance.collection('stations').doc();
    await store.set({
      // 'bookedby': FirebaseAuth.instance.currentUser?.uid,
      'latitude': latitude,
      'longitude': longitude,
      'openingtime':timingController.text,
      'stationName': nameController.text,
      'stationPhone': phoneController.text,
      'stationabout': aboutController.text,
      'stationaddress': stationaddressController.text,
      'stationrating': ratingController.text,
      'stationId':FirebaseAuth.instance.currentUser?.uid
    });
    isLoading(false);
    showToast(meassage: 'Added Station Successfully');
    Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
  }}