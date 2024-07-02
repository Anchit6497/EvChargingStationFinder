import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/app/splash_screen/splash_screen.dart';

import 'package:flutter_application_1/features/user_auth/presentation/pages/login.dart';
import 'package:flutter_application_1/features/user_auth/presentation/pages/search.dart';
import 'package:flutter_application_1/features/user_auth/presentation/pages/home.dart';
import 'package:flutter_application_1/features/user_auth/presentation/pages/station_view.dart';

Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
  if(kIsWeb){
    await Firebase.initializeApp(options: FirebaseOptions(apiKey:"AIzaSyBKynLJZ3JPiZrfDhq2xy4IfnUMWBZZWPM", appId: "1:912469034938:web:5ea387ebda52b9569fff83", messagingSenderId:"912469034938", projectId:"semproject-f02aa"));
  }
  else{
  await Firebase.initializeApp();
  }
  runApp(MyApp(
    
    // initialRoute: 'login',
    // routes: {'login':(context)=> mylogin(),
    // 'signup':(context)=>myregister(),
    // 'search':(context)=>BaatoSearchPage()
    // },
  ));
}

class MyApp extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
       debugShowCheckedModeBanner: false,
      title: 'project',
      home:SplashScreen(
        child:LoginPage(),),
        routes: {
          '/home':(context)=>Home(),
          '/login':(context)=>LoginPage(),
          '/search':(context)=>BaatoSearchPage(),
          '/stationview':(context)=>StationView(),
        },
    );
  }
}
