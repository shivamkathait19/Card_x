import 'package:card_x/mainFile/MainForm.dart';
import 'package:card_x/mainFile/cardScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  String? _email;
  String? _pass;

 bool isLoadinglogin = false;
 bool isLoadingsingup = false;


 NextScreen() {
    if (_formKey.currentState!.validate()) {}
    setState(() {
      isLoadingsingup = true;
    });
    Future.delayed(Duration(seconds: 5),() {
    setState(() {
      isLoadingsingup= false;
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => mainForm())
      );
    });
    });
  }
    Nextpage() {
    if (_formKey.currentState!.validate()) {}
    setState(() {
      isLoadinglogin = true;
    });
    Future.delayed(Duration(seconds: 5), () {
      setState(() {
        isLoadinglogin = false; // Hide loading indicator
      });
      Navigator.push(
        context,
        MaterialPageRoute(builder: (BuildContext context) => cardScreen()),
      );
    });
  }

  @override
       Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.black12,
      body: Container(
        decoration: BoxDecoration(
        ),
          child: SafeArea(

            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 150),
                    child:Image.asset('asset/avatar-png.jpg',height: 100,),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  // Form widget with correct syntax
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        // Email TextFormField
                        Padding(
                          padding: EdgeInsets.only(left: 50, right: 50),
                          child: TextFormField(
                            controller: _emailController,
                            decoration: InputDecoration(
                              labelText: 'Email',
                              labelStyle: TextStyle(color: Colors.grey),
                              prefixIcon: Icon(
                                Icons.email, color: Colors.grey, size: 20,),

                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your email';
                              }
                              // Add any additional validation logic here if needed
                              return null;
                            },
                          ),
                        ),
                        SizedBox(height: 10,),
                        Padding(
                          padding: EdgeInsets.only(left: 50, right: 50),
                          child: TextFormField(
                            controller: _passController,
                            obscureText: true,
                            decoration: InputDecoration(
                              labelText: 'Password',
                              labelStyle: TextStyle(color: Colors.grey),
                              prefixIcon: Icon(
                                Icons.password, color: Colors.grey,),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your Password';
                              }
                              // Add any additional validation logic here if needed
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 220),
                          child: TextButton(onPressed: () {},
                            child: Text('Forget Password',
                              style: TextStyle(
                                  color: Colors.blue, fontSize: 13),
                            ),
                          ),
                        ),
                        // Login Button
                        Padding(
                          padding: EdgeInsets.only(left: 150, right: 150),
                            child: isLoadinglogin ?
                            CircularProgressIndicator() : ElevatedButton(
                            onPressed: () {
                              // Only navigate if form is valid
                              if (_formKey.currentState!.validate()) {
                                Nextpage();
                              }
                            },
                              child: Text('Login',style: TextStyle(fontStyle: FontStyle.italic,color: Colors.black),) ,
                            style: ElevatedButton.styleFrom( backgroundColor: Colors.lightBlue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            ),
                        ),

                       /* SizedBox(
                          height: 300,
                        ),*/

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Don\'t have an account? ', style: TextStyle(
                                color: Colors.grey
                            ),),
                             isLoadingsingup ? CircularProgressIndicator()
                                : TextButton(
                               onPressed: NextScreen,
                              // Navigate to the Register screen
                              child: Text('Sign Up'),
                            ),
                            SizedBox(
                              height: 40,
                            ),
                          ],
                        ),

                      ],
                        ),

                  ),
                ],
              ),
            ),
          ),
        ),
      //),
    );
  }
}


