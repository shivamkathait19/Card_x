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
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
              // Replace with your image URL or use Image.asset() if it's a local image
              "https://static.vecteezy.com/system/resources/thumbnails/001/427/158/small/abstract-classic-blue-background-free-vector.jpg", // You can put the URL of your amazing background image here
            ),
            fit: BoxFit.cover, // Makes sure the image covers the entire screen
          ),
        ),
        child: Padding(
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
                            labelStyle: TextStyle(color: Colors.grey),
                            hintText: 'Enter your email',
                            prefixIcon: Icon(Icons.email,color: Colors.grey,) ,
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
                            labelStyle: TextStyle(color: Colors.grey),
                            hintText: 'Enter your Password',
                            prefixIcon: Icon(Icons.password,color: Colors.grey,),
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

                      Padding(
                        padding: EdgeInsets.only(left: 220),
                        child: TextButton(onPressed: (){},
                          child: Text('Forgot Password',
                            style: TextStyle(color: Colors.blue,fontSize: 13),
                          ),
                        ),
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
      ),
    );
  }
}

