import 'package:card_x/view/LoginScreen.dart';
import 'package:flutter/material.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Card_x",style: TextStyle(
          fontSize: 15
        ),),
      ),
      body: Center(
        child: ElevatedButton(onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginScreen()));
        },
            child: Text("Sign-In")),
      ),
    );
  }
}
