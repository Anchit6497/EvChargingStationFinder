import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_application_1/features/user_auth/presentation/pages/book_appointment.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:flutter_application_1/features/components/custom_button.dart';

class StationView extends StatelessWidget {
    final DocumentSnapshot doc;
  const StationView({super.key, required this.doc});

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 238, 229, 194),
      appBar: AppBar(
        title: Text('Station Detail',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
        ),
        body:Padding(
        
          padding: const EdgeInsets.all(14.0),
          
          child: Column(
            
            children: [
          
            Container(
              padding: const EdgeInsets.all(10),
             
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),

              ),
              child:Row(
               
                children: [
                Padding(padding: EdgeInsets.all(8)),
                CircleAvatar(
                  
                  backgroundImage: AssetImage('assests/station.png'),
                  radius: 40,
                 
              
                ),
                SizedBox(width: 15,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                 
                  children: [
                    
                    Text(doc['stationName'],style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                    SizedBox(height: 10,),
                    
                   
                    VxRating(
                      selectionColor: Colors.yellow,
                      onRatingUpdate: (value){},
                    maxRating: 5,
                    count:5,
                    value:double.parse(doc['stationrating'].toString()),
                    stepInt: true,
                    )
                  ],
                ),
                SizedBox(width: 20,),
                Text("See all Reviews",style: TextStyle(color: Color.fromARGB(255, 2, 80, 145)),),

              ],)
              
            ),
            SizedBox(height: 20,),
            Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,

                ),
                child:Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  
                  children:[ 
                ListTile(
                  title: Text('Phone Number'),
                  subtitle:Text(doc['stationPhone'],style: TextStyle(color: Colors.black.withOpacity(0.5)), ),
                  
                  trailing: Container(
                    width: 50,
                    padding:const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: const Color.fromARGB(255, 196, 181, 45),
                    ),
                    child:Icon(
                      Icons.phone,
                      color: Colors.white,
                    )
                  ),
                  ),
                  SizedBox(height: 15,),
                   Text('About',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                    SizedBox(height: 5,),
                    Text(doc['stationabout']),
                     SizedBox(height: 15,),
                    Text('Address',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                    SizedBox(height: 5,),
                    Text(doc['stationaddress']),
                    SizedBox(height: 15,),
                    Text('Opening time',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                    SizedBox(height: 5,),
                    Text(doc['openingtime']),

                  ],
                  )
            ),
          ],),
        ),
        bottomNavigationBar:Padding(
          padding: const EdgeInsets.all(15.0),
          child: CustomButton(buttonText: "Book Station", onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) =>BookAppointment(docId: doc['stationId'],docName:doc['stationName'] ,)));
          },),
        ),
    );
  }
}