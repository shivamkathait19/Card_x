import 'package:flutter/material.dart';
 class mainForm extends StatelessWidget {
   const mainForm({super.key});

   @override
   Widget build(BuildContext context) {
     return Scaffold(
       body: Padding(
         padding: const EdgeInsets.all(18.0),
         child: Form(
            child: Column(
                children: [
                  SizedBox(
                    height: 100,
                  ),
                       Text("Enter Your Details",style: TextStyle(fontSize: 15,fontStyle: FontStyle.italic),),
                       TextField(
                         decoration: InputDecoration(
                           labelText: "Username",
                           border: OutlineInputBorder(
                               borderRadius: BorderRadius.circular(10.10))),
                         ),
SizedBox(
  height: 20,
),
                  TextField(
                    decoration: InputDecoration(
                        labelText: "DD/MM/YY",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.10))),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
                    decoration:InputDecoration(
                      labelText: "Enter Father Name",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.9)
                      )

                    ),
                  ),
                  TextField(
                    decoration: InputDecoration(
                      labelText: "Mobile number",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.9)
                      )
                    ),
                  )
                 ],
               ),
           ),
       ),

       );
   }
 }
