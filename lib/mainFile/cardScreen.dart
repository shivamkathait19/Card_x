import 'package:flutter/material.dart';
class cardScreen extends StatefulWidget {

     final String? username;
     final String? date;
     final  String? father;
     final String? mother;
     final String? mobile;
     final String? email;


     cardScreen({
       Key? key,
     this.username,
     this.date,
     this.father,
     this.mother,
     this.mobile,
     this.email,

     }
  );
     @override
  State<cardScreen> createState() => _cardScreenState();
}

class _cardScreenState extends State<cardScreen> {
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body:
        Padding(
        padding: EdgeInsets.only(top: 200),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 50.0, horizontal: 10.0),
          child: Container(
            height: 430,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: Colors.black54.withOpacity(0.8), // Glow color
                  spreadRadius:5, // How far the glow extends
                  blurRadius:5,  // How blurred the glow is
                  offset: Offset(0, 0), // Position of the glow
                ),
              ],
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
                      title: Text(widget.username?? '',),
                    ),
                  ),
                      SizedBox(
                        height: 10,
                      ),
                 Container(
                   decoration: BoxDecoration(
                   border: Border.all(
                   color: Colors.black54,
                   ),// Container color
                   borderRadius: BorderRadius.circular(20),
                   ),
                   child: ListTile(
                   leading: Icon(Icons.calendar_today),
                   title: Text(widget.date ??''),
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
                      title: Text(widget.father?? ''),

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
                      title: Text(widget.mother?? ''),
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
                      title: Text(widget.mobile??''),
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
                      title: Text(widget.email??''),
                    ),
                  ),
                      SizedBox(
                        height: 10,
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


