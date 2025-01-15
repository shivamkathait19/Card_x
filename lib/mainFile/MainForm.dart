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
                       TextField(
                         decoration: InputDecoration(
                           labelText: "username",
                           border: OutlineInputBorder(
                               borderRadius: BorderRadius.circular(10.10))),
                         ),

                 ],
               ),
           ),
       ),

       );
   }
 }
