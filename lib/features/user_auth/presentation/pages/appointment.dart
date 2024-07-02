import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Appointment extends StatelessWidget {
  const Appointment({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Appointments",style: TextStyle(color: const Color.fromARGB(255, 66, 66, 66)),),
      ),
      body:ListView.builder(
        itemCount: 4,
        itemBuilder: (BuildContext context,int index){
          return ListTile(
            leading: CircleAvatar(child: Image.asset('assests/station.png'),),
            title:Text("Station Name", style: TextStyle(fontWeight: FontWeight.bold),),
            subtitle: Text("Booked Time"),
            
          );
        },
      )
    );
  }
}