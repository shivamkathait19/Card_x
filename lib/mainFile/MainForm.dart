import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class mainForm extends StatelessWidget {
   const mainForm({super.key});

   @override
   Widget build(BuildContext context) {
     return Scaffold(
       body: Padding(

         padding: const EdgeInsets.all(20.0),
         child:SingleChildScrollView(
         child: Form(

           child: Column(
             children: [
                  SizedBox(
                    height: 100,
                  ),
                       Text("Enter Your Details",style: TextStyle(fontSize: 15,fontStyle: FontStyle.italic,),),
                       TextField(
                         decoration: InputDecoration(
                           labelText: "Username",
                             labelStyle: TextStyle(
                                 fontStyle: FontStyle.italic,

                             ) ,


                           border: OutlineInputBorder(
                               borderRadius: BorderRadius.circular(10.10)))  ,

                         ),
                        SizedBox(
                       height: 20,
                       ) ,
                  TextField(
                    decoration: InputDecoration(
                      labelText: "DD/MM/YY",
                        labelStyle: TextStyle(
                            fontStyle: FontStyle.italic
                        ) ,

                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.10))),
                  ),
                  SizedBox(
                    height: 20,
                  ),
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
                  SizedBox(
                    height: 20,
                  ),
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
                  SizedBox(
                    height: 20,
                  ),
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
                  SizedBox(
                    height: 20,
                  ),

               ElevatedButton(
                 onPressed: () {
                   print("Button pressed");
                 },
                 child: Text("Submit"),
                 style: ElevatedButton.styleFrom(
                   foregroundColor: Colors.blueGrey,  // Text (foreground) color
                   elevation: 15, // Shadow elevation
                 ),
               )


             ],
               ),
           ),
       ),
       )

       );
   }
 }
