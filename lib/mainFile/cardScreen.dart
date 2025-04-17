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
    return Scaffold(
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

ListTile(
  leading: Icon(Icons.person,),
  title: Container(
    decoration: BoxDecoration(
      border: Border(
        bottom: BorderSide(
          color: Colors.black,
          width: 2.0,
      ),
    ),
    ),
      child:Text(widget.username ?? "username"
      ,),
  ),
),

 ListTile(
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
     child: Text(widget.date ??'date'),
   ),
 ),
            ListTile(
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
                child: Text(widget.father ??' father name'),
              ),
            ),
             ListTile(
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
                  child: Text(widget.mother ?? "enter a monther name "),
                ),
             ),
            ListTile(
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
                child: Text(widget.mother ?? "enter a mobile name "),
              ),
            ),
            ListTile(
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
                child: Text(widget.mother ?? "enter a email name "),
              ),
            ),


          

          ],
        ),
      ),
    );
  }
}
