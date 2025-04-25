import 'package:flutter/material.dart';


class cardScreen extends StatefulWidget {
  final String? username;
  final String? date;
  final String? father;
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
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white,
      body: Center(
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
          padding:  EdgeInsets.only(bottom:200),
          child: Image.asset('asset/solated-on-black.jpg',
            height: 200,
            width: 150,
          ),
        ),
  Container(
  child: ListTile(
    leading: Icon(Icons.person,),
    title: Padding(
      padding: const EdgeInsets.only(left: 30,right: 30),
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.black,
              width: 2.0,
          ),
        ),
        ),
          child:Text(widget.username ?? "Username", style: TextStyle(
            fontStyle: FontStyle.italic
          ),
      ),
      ),
    ))),
      Padding(
   padding: EdgeInsets.only(left: 30,right: 30),
   child: ListTile(
     leading: Icon(Icons.date_range ,),
     title: Container(
       decoration: BoxDecoration(
         border: Border( bottom:
         BorderSide(
           color: Colors.black,
           width: 2.0,
       ),
         )
       ),
       child: Text(widget.date ??'date',style: TextStyle(
           fontStyle: FontStyle.italic
       ),),
     ),
   ),
 ),
            Padding(
              padding: EdgeInsets.only(left: 30,right: 30),
              child: ListTile(
                leading: Icon(Icons.person_2),
                title:Container(
                  decoration: BoxDecoration(
                    border: Border( bottom:
                      BorderSide(
                        color: Colors.black,
                        width: 2.0,
                      ),

                    ),


                  ),
                  child: Text(widget.father ??' Father name',style: TextStyle(
                      fontStyle: FontStyle.italic
                  ),),
                ),
              ),
            ),
             Padding(
               padding: EdgeInsets.only(left: 30,right: 30),
               child: ListTile(
                 leading: Icon(Icons.person_2),
                  title: Container(
                    decoration: BoxDecoration(
                      border: Border(bottom:
                       BorderSide(
                          color: Colors.black,
                         width: 2.0,
                       )
                      )
                    ),
                    child: Text(widget.mother ?? " Mother name ",style: TextStyle(
                        fontStyle: FontStyle.italic
                    ),),
                  ),
               ),
             ),
            Padding(
              padding: const EdgeInsets.only(left: 30,right: 30),
              child: ListTile(
                leading: Icon(Icons.numbers),
                title: Container(
                  decoration: BoxDecoration(
                      border: Border(bottom:
                      BorderSide(
                        color: Colors.black,
                        width: 2.0,
                      )
                      )
                  ),
                  child: Text(widget.mother ?? " mobile number ",style: TextStyle(
                      fontStyle: FontStyle.italic
                  ),),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 30,right: 30),
              child: ListTile(
                leading: Icon(Icons.email),
                title: Container(
                  decoration: BoxDecoration(
                      border: Border(bottom:
                      BorderSide(
                        color: Colors.black,
                        width: 2.0,
                      )
                      )
                  ),
                  child: Text(widget.mother ?? " Email  ",style: TextStyle(
                      fontStyle: FontStyle.italic
                  ),),
                ),
              ),
            ),

                ],

        ),
      ),
    );
  }
}
