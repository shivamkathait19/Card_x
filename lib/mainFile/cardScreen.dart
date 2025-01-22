import 'package:flutter/material.dart';
class cardScreen extends StatelessWidget {

  String username;
  String date;
  String father;
  String mother;
  String mobile;
  String email;
  String password;

  cardScreen({Key?key,
  required this.username,
    required this.date,
    required this.father,
    required this.mother,
    required this.mobile,
    required this.email,
    required this.password,
  }

      ):super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          " Enter your details"
        ),
      ),
      body: Form(
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
    );
  }
}
