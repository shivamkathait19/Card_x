import 'package:flutter/material.dart';
class cardScreen extends StatelessWidget {

  final String? username;
  final String? date;
   final String? father;
    final String? mother;
    final String? mobile;
    final String? email;
    final String? password;

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
  Widget build(BuildContext context){
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
                title: Text(username!),
                
              ),
          ListTile(
           leading: Icon(Icons.calendar_today),
          title: Text(date!),
          ),
            ],

          ),
        
        ),
      ),
            ),
    );

  }
}
