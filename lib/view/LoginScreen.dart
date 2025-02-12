import 'package:flutter/material.dart';
class LoginScreen extends StatefulWidget {
     LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();

  String? _email;
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
           child:Column(
               mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 170, bottom: 10),
                  child: Image.network("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTR90LRqys3ItqiLIzthGpWk-mK_RaKXLHQJddJzObzeFXAhfEFDh1NvshrFGSyLYSNM-o&usqp=CAU",
                    height: 120,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              Form(
                key: _formKey,
                (child: Column (
                children:[
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      hintText: 'Enter your email',
                      prefixIcon: Icon(Icons.email),
                      border: OutlineInputBorder(),
                    ),
                  )
                ],
              )
                ),
              ],
           ),
       ),
    );
  }
}
