import 'package:flutter/material.dart';
class cardScreen extends StatelessWidget {

    final String? username;
     final String? date;
    final  String? father;
     final String? mother;
     final String? mobile;
     final String? email;
     final String? password;

  cardScreen({super.key,
     this.username,
     this.date,
     this.father,
     this.mother,
     this.mobile,
     this.email,
     this.password,
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
                title: Text(username?? ''),

              ),
             ListTile(
             leading: Icon(Icons.calendar_today),
             title: Text(date!),
          ),
              ListTile(
                leading: Icon(Icons.person_2),
                title: Text(father!),

              ),
              ListTile(
                leading: Icon(Icons.person),
                title: Text(mother!),
              ),
              ListTile(
                leading: Icon(Icons.phone),
                title: Text(mobile!),
              ),
              ListTile(
                leading: Icon(Icons.email),
                title: Text(email!),
              ),
              ListTile(
                leading: Icon(Icons.password),
                title: Text(password!),
              ),
            ],

          ),
        
        ),
      ),
            ),
    );

  }
}


