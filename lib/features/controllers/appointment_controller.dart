import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/user_auth/presentation/pages/home_view.dart';
import 'package:flutter_application_1/global/common/toast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AppointmentController extends GetxController {
  var isLoading = false.obs;

  var appointmentDate = TextEditingController();
  var appointmentStartTime = TextEditingController();
  var appointmentEndTime = TextEditingController();

  // Define stationName as observable
  var stationName = ''.obs;

  Future<void> bookAppointment(String docId, context) async {
    isLoading(true);

    try {
      // Before booking, check for conflicts
      bool hasConflict = await _checkTimeConflict(docId);
      if (hasConflict) {
        showToast(meassage: 'The selected time slot is already booked. Please choose another time.');
        isLoading(false);
        return;
      }

      var store = FirebaseFirestore.instance.collection('booking').doc();
      await store.set({
        'bookedby': FirebaseAuth.instance.currentUser?.uid,
        'date': appointmentDate.text,
        'start_time': appointmentStartTime.text,
        'end_time': appointmentEndTime.text,
        'bookwith': docId,
        'appwithname': stationName.value
      });

      showToast(meassage: 'Booking Successful');
      Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
    } catch (e) {
      print('Error booking appointment: $e');
      showToast(meassage: 'An error occurred while booking. Please try again.');
    } finally {
      isLoading(false);
    }
  }

  Future<bool> _checkTimeConflict(String docId) async {
    try {
      QuerySnapshot<Map<String, dynamic>> existingBookings = await FirebaseFirestore.instance
          .collection('booking')
          .where('bookwith', isEqualTo: docId)
          .where('date', isEqualTo: appointmentDate.text)
          .get();

      for (var doc in existingBookings.docs) {
        String startTime = doc['start_time'];
        String endTime = doc['end_time'];

        print('Checking against existing appointment: Start - $startTime, End - $endTime');

        // Convert stored time strings to DateTime objects
        DateTime storedStartTime = _convertTimeStringToDateTime(startTime);
        DateTime storedEndTime = _convertTimeStringToDateTime(endTime);
        DateTime newStartTime = _convertTimeStringToDateTime(appointmentStartTime.text);
        DateTime newEndTime = _convertTimeStringToDateTime(appointmentEndTime.text);

        // Check if the new booking overlaps with any existing booking
        if ((newStartTime.isAfter(storedStartTime) && newStartTime.isBefore(storedEndTime)) ||
            (newEndTime.isAfter(storedStartTime) && newEndTime.isBefore(storedEndTime)) ||
            (newStartTime.isAtSameMomentAs(storedStartTime) || newEndTime.isAtSameMomentAs(storedEndTime))) {
          return true;
        }
      }
    } catch (e) {
      print('Error checking time conflicts: $e');
    }
    return false;
  }

  DateTime _convertTimeStringToDateTime(String timeString) {
    try {
      // Convert to a 24-hour format time string for proper parsing
      final format = DateFormat('hh:mm a'); // using intl package to parse the time string
      return format.parse(timeString);
    } catch (e) {
      print('Error parsing time: $e');
      return DateTime.now(); // Return current time in case of a parsing error to prevent crashes
    }
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getBookingData(bool isStationOwner) async {
    if (isStationOwner) {
      return await FirebaseFirestore.instance
          .collection('booking')
          .where('bookwith', isEqualTo: FirebaseAuth.instance.currentUser?.uid)
          .get();
    } else {
      return await FirebaseFirestore.instance
          .collection('booking')
          .where('bookedby', isEqualTo: FirebaseAuth.instance.currentUser?.uid)
          .get();
    }
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getAllAppointments() async {
    return await FirebaseFirestore.instance.collection('booking').get();
  }
}
