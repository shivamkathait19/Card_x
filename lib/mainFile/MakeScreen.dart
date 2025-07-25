import 'package:flutter/material.dart';

class Makescreen extends StatelessWidget {
  const Makescreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Form(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 100,right: 20,left: 20),
                child: TextFormField(
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    labelText: "Enter the location name "
                  ),
                ),
              ),
SizedBox(
  height: 20,
),
              Padding(
                padding:  EdgeInsets.only(top: 20,right: 20,left: 20),
                child: TextFormField(
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    labelText: 'ENTER THE PRICE '
                  ),
                ),
              )
            ],
          ),
        )
      )
      );

  }
}
/*child: Form(
          key: _formKey,
          child: Column(
            children: [*/