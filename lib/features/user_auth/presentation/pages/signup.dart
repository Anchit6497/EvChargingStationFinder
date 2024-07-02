import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/user_auth/firebase_auth_implementation/firebase_auth_services.dart';
import 'package:flutter_application_1/features/user_auth/presentation/pages/login.dart';

import 'package:flutter_application_1/features/user_auth/presentation/pages/widgets/form_container_widget.dart';
import 'package:flutter_application_1/global/common/toast.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {

  bool _siginingup =false;
  final FirebaseAuthService _auth =FirebaseAuthService(); 

  TextEditingController _usernameController =TextEditingController();
  TextEditingController _emailController =TextEditingController();
   TextEditingController _passwordController =TextEditingController();

@override
  void dispose(){
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("SignUP"),
      // ),
      body:Center(
        child: Container(
          decoration: BoxDecoration(image: DecorationImage(image: AssetImage('assests/peakpx.jpg'),fit:BoxFit.cover)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children:[
                Text("Sign Up",style: TextStyle(fontSize: 32,fontWeight: FontWeight.bold,color: Colors.black),),
                SizedBox(
                  height:30,
                ),
                Text("Create your Account",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22),),
             SizedBox(
                  height:50
                ),
                FormContainerWidget(
                  controller: _usernameController,
                  hintText: "Username",
                  isPasswordField: false,
            
                ),
                SizedBox(height:30),
          
                 FormContainerWidget(

                  controller: _emailController,
                  hintText: "Email",
                  isPasswordField: false,
            
                ),
                SizedBox(height:30),
                
            
                 FormContainerWidget(
                  controller: _passwordController,
                  hintText: "Password",
                  isPasswordField: true,
            
                ),
            
            
                SizedBox(height:30),
                GestureDetector(
                  onTap: _signUP,
                  child: Container(
                    width:double.infinity,
                    height: 45,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child:Center(
                      child: _siginingup?CircularProgressIndicator(color: Colors.white,):Text("SignUp ", style:TextStyle(color: Colors.white,fontSize: 18, fontWeight: FontWeight.bold) ,))
                  ),
                ),

                  SizedBox(height: 25,),
                Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already have an account?"),
                  SizedBox(width: 5,),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()));
                    },
                    child:Text("Login", style: TextStyle(color:Colors.blue,fontSize:25,fontWeight: FontWeight.bold),) ,
                  )
          
                ],)
            
              ]
               ,),
          ),
        ),
      )
    );
    
  }
  void _signUP() async {
    setState(() {
      _siginingup= true;
    });
  // String username = _usernameController.text;
  String email =_emailController.text;
  String password = _passwordController.text;

  User? user = await _auth.signUpWithEmailAndPassword(email, password);
setState(() {
  _siginingup=false;
});
  if(user != null){
    showToast1(meassage: "created account succesfully");
    Navigator.pushNamed(context, "/home");   
  }
  else{
    
     showToast(meassage: "some error occured");
    
   
  }

}
}


