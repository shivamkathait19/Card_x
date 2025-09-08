 import 'package:card_x/view/LoginScreen.dart';
import 'package:flutter/material.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  void openloginScreen (){
    Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Card_x"),
      ),
    body: Column(
      children: [
        ElevatedButton(onPressed: openloginScreen,
            child: Text("Sing_In"))
      ],
    ),
    );
  }
}
