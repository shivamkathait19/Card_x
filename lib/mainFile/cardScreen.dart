import 'package:flutter/material.dart';
class cardScreen extends StatelessWidget {

     final String? username;
     final String? date;
     final  String? father;
     final String? mother;
     final String? mobile;
     final String? email;
     final String? password;

  cardScreen({
    Key? key,
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

      body: Padding(
        padding: EdgeInsets.only(top: 100),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.blue, // Container color
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.blue.withOpacity(0.6), // Glow color
                spreadRadius: 8, // How far the glow extends
                blurRadius: 20,  // How blurred the glow is
                offset: Offset(0, 0), // Position of the glow
              ),
            ],
          ),
           child:SingleChildScrollView(
          child: Form(
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
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
               title: Text(date ??''),
            ),
                ListTile(
                  leading: Icon(Icons.person_2),
                  title: Text(father?? ''),

                ),
                ListTile(
                  leading: Icon(Icons.person),
                  title: Text(mother?? ''),
                ),
                ListTile(
                  leading: Icon(Icons.phone),
                  title: Text(mobile??''),
                ),
                ListTile(
                  leading: Icon(Icons.email),
                  title: Text(email??''),
                ),
                ListTile(
                  leading: Icon(Icons.password),
                  title: Text(password??''),
                ),
              ]

            ),

          ),
        ),
        ),
        ),
      )
    );
  }
}


