import 'package:flutter/material.dart';
class cardScreen extends StatelessWidget {

  String username;
  String date;
  String father;
  String mother;
  String mobile;
  String email;
  String password;

  cardScreen({super.key,
    required this.username,
    required this.date,
    required this.father,
    required this.mother,
    required this.mobile,
    required this.email,
    required this.password,
  }

      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(70.10),
            ),
            child: Column(
            children: [
              Padding(padding: EdgeInsets.all(10.0),),
              ListTile(
        
                leading: Icon(Icons.person),
                title: Text(username),
              )
            ],
          ),
          ),
        
        ),
      ),
    );
  }
}
