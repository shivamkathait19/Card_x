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

  /*void _login() {
    if (_formKey.currentState!.validate()) {
      // Process login
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Logging in...')));
      // You can add your logic to handle successful login or navigate to another screen
    }
  }
*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(20.0),
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
                    padding:  EdgeInsets.all(10.0),
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
                  Padding(
                    padding: EdgeInsets.all(10.0),
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

                  // Login Button
                  ElevatedButton(
                    onPressed: (){},
                    child: Text('LOGIN'),
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
