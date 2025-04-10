import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class HomeController extends GetxController{
  var isLoading =false.obs;
  Future<QuerySnapshot<Map<String, dynamic>>> getStationList() async {
    var stations = FirebaseFirestore.instance.collection('stations').get();
    return stations;
  }
}