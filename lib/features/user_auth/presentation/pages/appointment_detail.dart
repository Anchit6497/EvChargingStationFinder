import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AppointmentDetail extends StatelessWidget {
  const AppointmentDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Station Name",style: TextStyle(fontWeight: FontWeight.bold),),
        ),
        body: Padding(padding: const EdgeInsets.all(10),
        child:Column(children: [
          
        ],)
        ),
    );
  }
}