import 'package:card_x/mainFile/MainForm.dart';
import 'package:card_x/mainFile/cardScreen.dart';
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

  NextScreen() {
    if (_formKey.currentState!.validate()) {}
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => mainForm(

        ),
      ),
    );
  }
  Nextpage() {
    if (_formKey.currentState!.validate()) {}
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => cardScreen(
        ),
      ),
    );
  }
      @override
       Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      body: Padding(
        padding:  EdgeInsets.only(top: 200),
        child: SafeArea(
          child : SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Image.network(
                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSDVkVllngyTXkUOquySPzD1zArMpBLGC4dMycEAhIGjg7zCDp7HLkLYBAuqHD8EdC05Oo&usqp=CAU",
                  height: 120,
                ),
              ),
                SizedBox(
                height: 20,
                 ),
              // Form widget with correct syntax
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    // Email TextFormField
                    Padding(
                      padding:  EdgeInsets.only(left: 30,right:30),
                      child: TextFormField(
                        controller: _emailController,

                        decoration: InputDecoration(
                          labelText: 'Email',
                          hintText: 'Enter your email',
                          prefixIcon: Icon(Icons.email),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
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
                      padding: EdgeInsets.only(left: 30,right:30),
                      child: TextFormField(
                        controller: _passController,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          hintText: 'Enter your Password',
                          prefixIcon: Icon(Icons.password),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0)
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your Pass';
                          }
                          // Add any additional validation logic here if needed
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                  height: 10,
                         ),
                    // Login Button
                    Padding(
                      padding:  EdgeInsets.only(left: 150,right: 150),
                      child: ElevatedButton(
                        onPressed: Nextpage,
                                     child: Text('login'),
                                    style:  ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                    ),
                     TextButton(onPressed: (){},
                        child: Text('Forgot Password',
                          style: TextStyle(color: Colors.blue),
                        ),
                     ),
                    SizedBox(
                      height: 10,
                    ),
                   SizedBox(height: 200,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Don\'t have an account? '),
                        TextButton(
                          onPressed: NextScreen,
                            // Navigate to the Register screen
                          child: Text('Sign Up'),
                        ),
                        SizedBox(
                          height: 50,
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
    );
  }
}

