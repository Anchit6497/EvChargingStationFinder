import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/user_auth/presentation/overallbooking.dart';
import 'package:flutter_application_1/features/user_auth/presentation/pages/profile_view.dart';



class Adminnavigation extends StatefulWidget {
  const Adminnavigation ({super.key});

  @override
  State<Adminnavigation> createState() => _AdminnavigationState();
}

class _AdminnavigationState extends State<Adminnavigation> {
  int SelectedIndex =0;
  List ScreenList =[
   
    OverallBooking(),
    ProfileView(),

  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:ScreenList.elementAt(SelectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Color.fromARGB(255, 0, 0, 0),
        selectedLabelStyle: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
        selectedIconTheme:IconThemeData(color: const Color.fromARGB(255, 0, 0, 0)),
        backgroundColor: Color.fromARGB(255, 220, 220, 202),
        type:BottomNavigationBarType.fixed,
        currentIndex: SelectedIndex,
        onTap: (value){
          setState(() {
            SelectedIndex =value;
          });
        },
        items: [
        
        BottomNavigationBarItem(icon: Icon(Icons.charging_station_rounded),label:"Bookings"),
        BottomNavigationBarItem(icon: Icon(Icons.person),label:"Profile"),
      ],),
    );
  }
}