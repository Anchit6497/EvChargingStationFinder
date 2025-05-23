
import 'package:flutter/material.dart';


class SplashScreen extends StatefulWidget {
  final Widget? child;
  const SplashScreen({super.key,this.child});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    
    Future.delayed(
      
      Duration(seconds:3),(){
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>widget.child!), (route)=>false);
      }
      );
    super.initState();
  }
    var isLoading= true;
  @override

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        
        child: 
        
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assests/logo.png'),

            Text("welcome", style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold,fontSize: 20),),
          ],
        ),
        ),
    );
  }
}