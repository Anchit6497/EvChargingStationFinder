import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/RoleSelectionPage.dart';
import 'package:flutter_application_1/features/app/splash_screen/splash_screen.dart';
import 'package:flutter_application_1/features/station_owners/login_owner.dart';
import 'package:flutter_application_1/features/station_owners/ownerNavigation.dart';
import 'package:flutter_application_1/features/user_auth/presentation/adminnavigation.dart';
import 'package:flutter_application_1/features/user_auth/presentation/loginadmin.dart';
import 'package:flutter_application_1/features/user_auth/presentation/pages/login.dart';
import 'package:flutter_application_1/features/user_auth/presentation/pages/search.dart';
import 'package:flutter_application_1/features/user_auth/presentation/pages/home.dart';



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
        child:RoleSelectionPage(),),
        routes: {
          '/home':(context)=>Home(),
          '/login':(context)=>LoginPage(),
          '/search':(context)=>BaatoSearchPage(),
          '/stationowner':(context)=>LoginOwner(),
          '/RoleSelectionPage':(context)=>RoleSelectionPage(),
          '/ownerNavigation':(context)=>Ownernavigation(),
          '/admin':(context)=>Loginadmin(),
          '/adminNavigation':(context)=>Adminnavigation(),
          
          
        },
    );
  }
}
