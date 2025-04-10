import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/station_owners/OwnerBooking.dart';
import 'package:flutter_application_1/features/station_owners/Owner_home.dart';
import 'package:flutter_application_1/features/station_owners/Owner_profile.dart';


class Ownernavigation extends StatefulWidget {
  const Ownernavigation ({super.key});

  @override
  State<Ownernavigation> createState() => _Ownernavigation();
}

class _Ownernavigation extends State<Ownernavigation> {
  int SelectedIndex =0;
  List ScreenList =[
    OwnerHomePage(),
    Ownerbooking(),
    OwnerProfile(),

    

 

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
        BottomNavigationBarItem(icon: Icon(Icons.home),label:"Home"),
        BottomNavigationBarItem(icon: Icon(Icons.charging_station_rounded),label:"Bookings"),
        BottomNavigationBarItem(icon: Icon(Icons.person),label:"Profile"),
      ],),
    );
  }
}