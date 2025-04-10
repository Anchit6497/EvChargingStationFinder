import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/station_owners/firebase_auth_implementation_owner/firebase_auth_services_owner.dart';
import 'package:flutter_application_1/features/station_owners/login_owner.dart';
import 'package:flutter_application_1/features/user_auth/presentation/pages/widgets/form_container_widget.dart';
import 'package:flutter_application_1/global/common/toast.dart';

class OwnerSignupPage extends StatefulWidget {
  const OwnerSignupPage({super.key});

  @override
  State<OwnerSignupPage> createState() => _OwnerSignupPageState();
}

class _OwnerSignupPageState extends State<OwnerSignupPage> {
  bool _signingUp = false;
  final FirebaseAuthServiceOwner _auth = FirebaseAuthServiceOwner();

  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _stationNameController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _stationNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/peakpx.jpg'), 
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Owner Sign Up", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.black)),
                SizedBox(height: 30),
                Text("Create your Account", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
                SizedBox(height: 50),
                FormContainerWidget(
                  controller: _usernameController,
                  hintText: "Full Name",
                  isPasswordField: false,
                ),
                SizedBox(height: 30),
                FormContainerWidget(
                  controller: _stationNameController,
                  hintText: "Station Name",
                  isPasswordField: false,
                ),
                SizedBox(height: 30),
                FormContainerWidget(
                  controller: _emailController,
                  hintText: "Email",
                  isPasswordField: false,
                ),
                SizedBox(height: 30),
                FormContainerWidget(
                  controller: _passwordController,
                  hintText: "Password",
                  isPasswordField: true,
                ),
                SizedBox(height: 30),
                GestureDetector(
                  onTap: _signUp,
                  child: Container(
                    width: double.infinity,
                    height: 45,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: _signingUp
                        ? CircularProgressIndicator(color: Colors.white)
                        : Text("Sign Up", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
                SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an account?"),
                    SizedBox(width: 5),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => LoginOwner()));
                      },
                      child: Text("Login", style: TextStyle(color: Colors.blue, fontSize: 25, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _signUp() async {
    setState(() {
      _signingUp = true;
    });

    String fullName = _usernameController.text;
    String stationName = _stationNameController.text;
    String email = _emailController.text;
    String password = _passwordController.text;

    User? user = await _auth.signUpOwnerWithEmailAndPassword(email, password, fullName, stationName);

    setState(() {
      _signingUp = false;
    });

    if (user != null) {
      showToast(meassage: "Created account successfully");
      Navigator.pushNamed(context, "/ownerHome");
    } else {
      showToast(meassage: "Some error occurred");
    }
  }
}
