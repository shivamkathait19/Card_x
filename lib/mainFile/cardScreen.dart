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
            color: Colors.cyan, // Container color
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black87.withOpacity(0.8), // Glow color
                spreadRadius:5, // How far the glow extends
                blurRadius:5,  // How blurred the glow is
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

                Container(
                  decoration: BoxDecoration(
                    color: Colors.cyan, // Container color
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black87.withOpacity(0.8), // Glow color
                        spreadRadius:5, // How far the glow extends
                        blurRadius:5,  // How blurred the glow is
                        offset: Offset(0, 0), // Position of the glow
                      ),
                    ],
                  ),
                  child: ListTile(
                    leading: Icon(Icons.person),
                    title: Text(username?? '',),
                  ),
                ),
               Container(decoration: BoxDecoration(
                 color: Colors.cyan, // Container color
                 borderRadius: BorderRadius.circular(20),
                 boxShadow: [
                   BoxShadow(
                     color: Colors.black87.withOpacity(0.8), // Glow color
                     spreadRadius:5, // How far the glow extends
                     blurRadius:5,  // How blurred the glow is
                     offset: Offset(0, 0), // Position of the glow
                   ),
                 ],
               ),
                 child: ListTile(
                 leading: Icon(Icons.calendar_today),
                 title: Text(date ??''),
                             ),
               ),
                Container(decoration: BoxDecoration(
                  color: Colors.cyan, // Container color
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black87.withOpacity(0.8), // Glow color
                      spreadRadius:5, // How far the glow extends
                      blurRadius:5,  // How blurred the glow is
                      offset: Offset(0, 0), // Position of the glow
                    ),
                  ],
                ),
                  child: ListTile(
                    leading: Icon(Icons.person_2),
                    title: Text(father?? ''),

                  ),
                ),
                Container(decoration: BoxDecoration(
                  color: Colors.cyan, // Container color
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black87.withOpacity(0.8), // Glow color
                      spreadRadius:5, // How far the glow extends
                      blurRadius:5,  // How blurred the glow is
                      offset: Offset(0, 0), // Position of the glow
                    ),
                  ],
                ),
                  child: ListTile(
                    leading: Icon(Icons.person),
                    title: Text(mother?? ''),
                  ),
                ),
                Container(decoration: BoxDecoration(
                  color: Colors.cyan, // Container color
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    
                  ],
                ),
                  child: ListTile(
                    leading: Icon(Icons.phone),
                    title: Text(mobile??''),
                  ),
                ),
                Container(decoration: BoxDecoration(
                  color: Colors.cyan, // Container color
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [

                  ],
                ),
                  child: ListTile(
                    leading: Icon(Icons.email),
                    title: Text(email??''),
                  ),
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


