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
  }): super(key: key);


  @override
  State<cardScreen> createState() => _cardScreenState();
}

class _cardScreenState extends State<cardScreen> {



    @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.black,
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
       Column(
         
          children: [ ListTile(
            leading: Icon(Icons.person,),
            title: Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.white,
                width: 2.0,
            ),
          ),
          ),
            child:Center(
              child: Text(widget.username ?? "Username", style: TextStyle(
                fontStyle: FontStyle.italic,color: Colors.white24
              ),
                    ),
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
                          color: Colors.white,
                          width: 2.0,
                        ),

                      ),


                    ),
                    child: Center(
                      child: Text(widget.father ??' Father name',style: TextStyle(
                          fontStyle: FontStyle.italic,color: Colors.white24
                      ),),
                    ),
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
                            color: Colors.white,
                           width: 2.0,
                         )
                        )
                      ),
                      child: Center(
                        child: Text(widget.mother ?? " Mother name ",style: TextStyle(
                            fontStyle: FontStyle.italic,color: Colors.white24
                        ),),
                      ),
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
                          color: Colors.white,
                          width: 2.0,
                        )
                        )
                    ),
                    child: Center(
                      child: Text(widget.mother ?? " Mobile number ",style: TextStyle(
                          fontStyle: FontStyle.italic,color: Colors.white24
                      ),),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 30,right: 30),
                child: ListTile(
                  leading: Icon(Icons.date_range ,),
                  title: Container(
                    decoration: BoxDecoration(
                        border: Border( bottom:
                        BorderSide(
                          color: Colors.white,
                          width: 2.0,
                        ),
                        )
                    ),
                    child: Center(
                      child:Text(widget.date ??'Date',style: TextStyle(
                          fontStyle: FontStyle.italic,color: Colors.white24
                      ),),
                    ),

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
                          color: Colors.white,
                          width: 2.0,
                        )
                        )
                    ),
                    child:  Center(
                      child: Text(widget.mother ?? " Email  ",style: TextStyle(
                          fontStyle: FontStyle.italic,color: Colors.white24
                      ),),
                    )
                  ),
                ),
              ),


             ],
       ),
    ),
    ),
    );
  }
}
