import 'package:flutter/material.dart';

class RoleSelectionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Select Role'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assests/logo.png'),
            SizedBox(height: 10,),
            Text("Choose your account type.",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 32),),
            SizedBox(height:30),
            ElevatedButton(
                style:ButtonStyle(
                  backgroundColor: WidgetStateProperty.all<Color>(Color.fromARGB(255, 219, 222, 224)),
                  padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
                  EdgeInsets.symmetric(vertical: 18.0, horizontal: 50.0),
                  )

                ),
              onPressed: () {
                Navigator.pushNamed(context, '/login'); // Navigate to typical user page
              },
              child: Text('Sign in as Regular User',style: TextStyle(color:Colors.black),),
            ),
            SizedBox(height: 20),
            ElevatedButton(
               style:ButtonStyle(
                  backgroundColor: WidgetStateProperty.all<Color>(Colors.blue),
                  padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
                  EdgeInsets.symmetric(vertical: 18.0, horizontal: 50.0),
                  )

                ),
              onPressed: () {
                Navigator.pushNamed(context, '/stationowner'); // Navigate to station owner page
              },
              child: Text('Sign in as Station Owner',style: TextStyle(color: Colors.white),),
            ),
               SizedBox(height: 20),
            ElevatedButton(
               style:ButtonStyle(
                  backgroundColor: WidgetStateProperty.all<Color>(Colors.blue),
                  padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
                  EdgeInsets.symmetric(vertical: 18.0, horizontal: 50.0),
                  )

                ),
              onPressed: () {
                Navigator.pushNamed(context, '/admin'); // Navigate to station owner page
              },
              child: Text('Sign in as Admin',style: TextStyle(color: Colors.white),),
            ),
          ],
        ),
      ),
    );
  }
}
