
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 220, 220, 202),
        title: Row(
          children: [
            Text("Welcome"),
            SizedBox(width: 10,),
            Text("User"),
          ],
        ),
      ),
      body: Column(
         
        mainAxisAlignment: MainAxisAlignment.center,
        
        children: [

         
      
          GestureDetector(
            onTap: (){
              Navigator.pushNamed(context, "/stationview");
              
            },
            child: Center(
              child: Text(
                "Welcome to Homepage",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SizedBox(height: 30),
          
        ],
      ),
    );
  }
}
