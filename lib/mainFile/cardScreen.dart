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
      backgroundColor: Colors.white12,
        body: Padding(
        padding: EdgeInsets.only(top: 200),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 500,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue, Colors.yellow], // Add your colors
                begin: Alignment.topLeft,
                end: Alignment.bottomCenter,
              ),
            ),
             child:SingleChildScrollView(
               child: Column(
                    children: [
                  SizedBox(
                    height: 20,
                  ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black54
                          ),
                          borderRadius: BorderRadius.circular(20),

                    ),
                    child: ListTile(
                      leading: Icon(Icons.person),
                      title: Text(username?? '',),
                    ),
                  ),
                      SizedBox(
                        height: 10,
                      ),
                 Container(decoration: BoxDecoration(
                   border: Border.all(
                   color: Colors.black54,
                   ),// Container color
                   borderRadius: BorderRadius.circular(20),

                 ),

                   child: ListTile(
                   leading: Icon(Icons.calendar_today),
                   title: Text(date ??''),
                               ),
                 ),
                      SizedBox(
                        height: 10,
                      ),
                  Container(decoration: BoxDecoration(
                    border: Border.all(
                    color: Colors.black54,
                  ),// Container color
                    borderRadius: BorderRadius.circular(20),
                  ),

                    child: ListTile(
                      leading: Icon(Icons.person_2),
                      title: Text(father?? ''),

                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(decoration: BoxDecoration(
                    border: Border.all(
                    color: Colors.black54,
                    ),// Container color
                     borderRadius: BorderRadius.circular(20),

                  ),
                    child: ListTile(
                      leading: Icon(Icons.person),
                      title: Text(mother?? ''),
                    ),
                  ),
                      SizedBox(
                        height: 10,
                      ),
                  Container(decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black54,
                    ),
                     // Container color
                    borderRadius: BorderRadius.circular(20),

                  ),
                    child: ListTile(
                      leading: Icon(Icons.phone),
                      title: Text(mobile??''),
                    ),
                  ),
                      SizedBox(
                        height: 10,
                      ),
                  Container(decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black54,
                    ),// Container color
                    borderRadius: BorderRadius.circular(20),

                  ),
                    child: ListTile(
                      leading: Icon(Icons.email),
                      title: Text(email??''),
                    ),
                  ),
                      SizedBox(
                        height: 10,
                      ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black54,
                      ), // Container color
                      borderRadius: BorderRadius.circular(20),

                    ),
                    child: ListTile(
                      leading: Icon(Icons.password),
                      title: Text(password??''),
                    ),
                  ),
                ]

              ),

            ),
          ),
        ),
        ),


    );
  }
}


