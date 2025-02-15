import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passControler = TextEditingController();

  String? _email;
  String? _pass;

  void _login() {
    if (_formKey.currentState!.validate()) {
      // Process login
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Logging in...')));
      // You can add your logic to handle successful login or navigate to another screen
    }
  }

      @override
       Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
                      controller: _passControler,
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
                          return 'Please enter your email';
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
                      onPressed: (){},
                                   child: Text('login'),
                                  style:  ElevatedButton.styleFrom(
                                  /*minimumSize: Size(double.infinity, 50),*/
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
                        onPressed: () {
                          // Navigate to the Register screen
                        },
                        child: Text('Sign Up'),
                      ),
                    ],
                  ),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
