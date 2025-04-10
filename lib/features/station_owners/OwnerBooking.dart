import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/features/controllers/appointment_controller.dart';
import 'package:get/get.dart';

class Ownerbooking extends StatelessWidget {
  final bool isStationOwner;
  const Ownerbooking({super.key, this.isStationOwner = true});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AppointmentController());

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Appointments",
          style: TextStyle(color: Color.fromARGB(255, 66, 66, 66)),
        ),
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: controller.getBookingData(isStationOwner),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No appointments found.'));
          }

          var appointments = snapshot.data!.docs;

          return ListView.builder(
            itemCount: appointments.length,
            itemBuilder: (BuildContext context, int index) {
              var appointment = appointments[index];
              var appointmentData = appointment.data() as Map<String, dynamic>;

              return ListTile(
                leading: CircleAvatar(child: Image.asset('assests/station.png')),
                title: Text(appointmentData['appwithname'], 
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text("${appointmentData['date']}      ${appointmentData['start_time']}  -  ${appointmentData['end_time']}"),
                // Adjust subtitle format based on your Firestore document structure
              );
            },
          );
        },
      ),
    );
  }
}
