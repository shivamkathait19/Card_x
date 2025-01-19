import 'package:card_x/mainFile/cardScreen.dart';
import 'package:floating_action_bubble_custom/floating_action_bubble_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class mainForm extends StatefulWidget {
    mainForm({super.key});

  @override
  State<mainForm> createState() => _mainFormState();
}



class _mainFormState extends State<mainForm> {
   nextScreen () {
     if( _key.currentState!=null){
       _key.currentState!.save();
       Navigator.push(context,
           MaterialPageRoute(builder: (BuildContext context) =>  cardScreen(),
           )
       );
     }
   }
  var username,Dateofbirth,fathername,mobilenumber,emailaddress,password;
  GlobalKey<FormState> _key = new GlobalKey();

   @override
   Widget build(BuildContext context) {
     return Scaffold(
         body:
         Padding(
         padding: const EdgeInsets.all(20.0),
         child:SingleChildScrollView(
         child: Form(key:  _key,
           child: Column(
             children: [
                  SizedBox(
                    height: 50,
                  ),

                       Text("Enter Your Details",style:

                         TextStyle(fontSize: 17,fontStyle: FontStyle.italic)),
                      SizedBox(
                        height: 10,
                      ),
                     ListTile(
                       leading: Icon(Icons.person),
                       title:TextField(

                         decoration: InputDecoration(

                             labelText: "Username",
                             labelStyle: TextStyle(
                                 fontStyle: FontStyle.italic,
                             ) ,
                             border: OutlineInputBorder(
                               borderRadius: BorderRadius.circular(10.10)),
                         ),
                         ),
                     ),
                        SizedBox(
                       height: 10,
                       ) ,
                 
                 ListTile(
                   leading: Icon(Icons.calendar_today),
                   title:

                  TextField(
                    decoration: InputDecoration(
                      labelText: "DATE OF BIRTH",
                        labelStyle: TextStyle(
                            fontStyle: FontStyle.italic
                        ) ,

                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.10))),
                  ),
                 ),
                  SizedBox(
                    height: 10,
                  ),

                  ListTile(
                    leading: Icon(Icons.person),
                    title:
                    TextField(
                    keyboardType: TextInputType.name,
                    decoration:InputDecoration(
                      labelText: "Father Name",

                        labelStyle: TextStyle(
                          fontStyle: FontStyle.italic
                        ) ,
                        border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.9)
                      )

                    ),
                  ),
                  ),
                  ListTile(
                    leading: Icon(Icons.person_2),
                    title:

                  TextField(
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      labelText: "Mother Name",
                      labelStyle: TextStyle(
                        fontStyle: FontStyle.italic
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0)
                      )
                    ),
                  ),
                  ),
                  
                  SizedBox(
                    height: 10,
                  ),
               
               
               ListTile(
                 leading: Icon(Icons.phone),
                 title:


                  TextField(
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    decoration: InputDecoration(
                        labelText: "Mobile number",
                       labelStyle: TextStyle(
                            fontStyle: FontStyle.italic
                        ) ,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.9)
                      )
                    ),
                  ),
               ),
                  SizedBox(
                    height: 10,
                  ),

                   ListTile(
                     leading: Icon(Icons.email),
                     title:

                  TextField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: "Email address",
                      labelStyle: TextStyle(
                        fontStyle: FontStyle.italic
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.10)

                      )
                    ),
                  ),
                   ),
                  SizedBox(
                    height: 10,
                  ),

             ListTile(
               leading: Icon(Icons.password,size: 23,),
               title:

             TextField(
               keyboardType: TextInputType.visiblePassword,

               decoration: InputDecoration(
                 labelText: "Password",
                 labelStyle: TextStyle(
                   fontStyle:FontStyle.italic,

                 ),
                 border: OutlineInputBorder(
                   borderRadius: BorderRadius.circular(10.10)
                 )

               ),
             )
             ),

                  ButtonTheme(child: ElevatedButton(
                      onPressed: (){}, child: Text("Save")))


             ],
               ),
           ),
       ),
       )

       );
   }
}
