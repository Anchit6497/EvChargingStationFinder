import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/components/list.dart';
import 'package:flutter_application_1/global/common/toast.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 220, 220, 202),
        elevation: 0.0,
        title: Text('My Account',style: TextStyle(color:Colors.black)),
      ),
      body:Column(children: [
        ListTile(
          leading:CircleAvatar(child:Image.asset('assests/profile.png')),
          title: Text('Username',style:TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text('useremail@gmail.com'),
        ),
        const Divider(),
        SizedBox(height:20),
        ListView(
          shrinkWrap: true,
          children: List.generate(settingList.length, (index)=>ListTile(
            onTap: (){},
            leading:Icon(settingListIcon[index]),
             title:settingList[index],
            
          ) ),
        ),

        SizedBox(height: 40,),
        GestureDetector(
            onTap: () {
              FirebaseAuth.instance.signOut();
              Navigator.pushNamed(context, "/login");
              showToast1(meassage: "Signed Out Successfully");
            },
            child: Container(
              width: 100,
              height: 45,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  "Sign Out",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
      ],)
    );
  }
}