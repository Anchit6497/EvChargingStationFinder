import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/features/station_owners/firebase_auth_implementation_owner/firebase_auth_services_owner.dart';
import 'package:flutter_application_1/features/station_owners/signup_owner.dart';
import 'package:flutter_application_1/features/user_auth/presentation/pages/widgets/form_container_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/global/common/toast.dart';

class LoginOwner extends StatefulWidget {
  const LoginOwner({super.key});

  @override
  State<LoginOwner> createState() => _LoginOwnerState();
}

class _LoginOwnerState extends State<LoginOwner> {



  bool _isSigning =false;
  final FirebaseAuthServiceOwner _auth =FirebaseAuthServiceOwner(); 

 
  TextEditingController _emailController =TextEditingController();
   TextEditingController _passwordController =TextEditingController();

@override
  void dispose(){
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("login"),
      // ),
      body:Center(
       
          child: Container(
            decoration: BoxDecoration(image: DecorationImage(image: AssetImage('assests/peakpx.jpg'),fit:BoxFit.cover)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children:[
                    
                       
                        Image.asset('assests/icon.jpg',
                        height: 200,
                        width: double.infinity,
                        fit:BoxFit.cover
                      
                        ),
                      
                       
                      
          
                          SizedBox(height: 30,),
                         
          
                 
                  Text("Login",style: TextStyle(fontSize: 35,fontWeight: FontWeight.bold,color: Colors.black),),
                  SizedBox(
                    height:30,
                  ),
              
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
              
              
                  SizedBox(height:30,),
            
                  GestureDetector(
                    onTap: _singIn,
                    child: Container(
                      width:100,
                      height: 45,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child:Center(
                        child:_isSigning?CircularProgressIndicator(color: Colors.white,): Text("Login", 
                        style:TextStyle(color: Colors.white,fontSize: 18, fontWeight: FontWeight.bold) ,))
                    ),
                  ),
                    SizedBox(height: 25,),
                Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account?"),
                  SizedBox(width: 5,),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>OwnerSignupPage()));
                    },
                    child:Text("Sign Up", style: TextStyle(color:Colors.blue,fontSize: 20, fontWeight: FontWeight.bold),) ,
                  )
          
                ],)
              
                ]
                 ,),
            ),
          ),
       
      )
    );
    
  }
    void _singIn() async {
      setState(() {
        
        _isSigning =true;
      });
  // String username = _usernameController.text;
  String email =_emailController.text;
  String password = _passwordController.text;

  User? user = await _auth.signInOwnerWithEmailAndPassword(email, password);
  setState(() {
    _isSigning=false;
  });
  if(user != null){
    showToast1(meassage: "Signed In succesfully");
    Navigator.pushNamed(context, "/ownerNavigation");
  
    
    
  }else{
      showToast1(meassage: "some error occured");
    
    
   
  }

}
}