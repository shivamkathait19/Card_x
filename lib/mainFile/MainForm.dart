import 'package:card_x/mainFile/cardScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class mainForm extends StatefulWidget {
    mainForm({super.key});

  @override
  State<mainForm> createState() => _mainFormState();
}

class _mainFormState extends State<mainForm> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController fatherController = TextEditingController();
  TextEditingController motherController = TextEditingController();
  TextEditingController mobileController =TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  GlobalKey<FormState> _key = new GlobalKey();


  NextScreen(){
    if (_key.currentState != null && _key.currentState!.validate()) {
      _key.currentState!.save();
    }
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => cardScreen(
          username: usernameController.text,
          date: dateController.text,
          father: fatherController.text,
          mother: motherController.text,
          mobile: mobileController.text,
          email: emailController.text,
        ),
      ),
    );
  }
  @override
   Widget build(BuildContext context) {
     return Scaffold(
       backgroundColor: Colors.black,
       body: Container(
         child :SingleChildScrollView(
         child: Padding(
           padding: EdgeInsets.all(20.0),
           child: Form
                 (key: _key,
                 child: Column(
                   children: [
                     SizedBox(
                          height: 200,
                        ),

                         ListTile(
                               leading: Icon(Icons.person),
                               title:TextFormField(
                                 controller: usernameController,
                                 decoration: InputDecoration(
                                   labelText: "Username",
                                     labelStyle: TextStyle(
                                       fontStyle: FontStyle.italic,
                                     ),

                                 ),
                                   validator: (value) {
                                   if (value == null || value.isEmpty) {
                                     return "Username is required";
                                   }
                                   return null;
                                 },

                               ),
                             ),

                     ListTile(
                         leading: Icon(Icons.calendar_today),
                         title:
                         TextFormField(
                          controller: dateController,
                          decoration: InputDecoration(
                            labelText: "Date Of Birth",
                              labelStyle: TextStyle(
                                  fontStyle: FontStyle.italic
                              ) ,

                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return " Date Of Birth is required";
                            }
                            return null;
                          },

                        ),
                       ),



                     ListTile(
                       leading: Icon(Icons.phone),
                       title:
                       TextFormField(
                          controller: mobileController,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          decoration: InputDecoration(
                              labelText: "Mobile number",
                             labelStyle: TextStyle(
                                  fontStyle: FontStyle.italic
                              ) ,

                          ),
                         validator: (value) {
                           if (value == null || value.isEmpty) {
                             return " Mobile name  is required";
                           }
                           return null;
                         },
                        ),
                     ),


                     ListTile(
                           leading: Icon(Icons.email),
                           title:
                           TextFormField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            labelText: "Email address",
                            labelStyle: TextStyle(
                              fontStyle: FontStyle.italic
                            ),

                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return " email is required";
                            }
                            return null;
                          },
                        ),
                         ),

                         ListTile(
                               leading: Icon(Icons.password),
                               title: TextFormField(
                                 controller: passController,
                                 keyboardType: TextInputType.visiblePassword,
                                 decoration: InputDecoration(
                                   labelText:"Password",
                                   labelStyle: TextStyle(
                                     fontStyle: FontStyle.italic,
                                   ),

                               ),
                                 validator: (value) {
                                   if (value == null || value.isEmpty) {
                                     return " Password is required";
                                   }
                                   if (value.length < 6) {
                                     return "Password must be at least 6 characters";
                                   }
                                   return null;
                                 },
                             ),
                             ),
                        SizedBox(
                          height: 30,
                        ),
                     Padding(
                       padding:  EdgeInsets.only(top:50,left: 200,),
                       child:
                       Padding(
                         padding:  EdgeInsets.only(left: 100),
                         child: ElevatedButton(
                           onPressed: (NextScreen),
                           child: Text(
                             "Done",
                             style: TextStyle(
                               fontStyle: FontStyle.italic,
                               color: Colors.white, // Change the text color
                             ),
                           ),
                           style: ElevatedButton.styleFrom(
                             foregroundColor: Colors.white, backgroundColor: Colors.black12, // Set color for text/icon
                             padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 10.0 ,),// Optional: padding
                           ),
                         ),
                       )
                       ),
                   ],
                     ),

                 ),

           ),
         ),
       ),
       );

   }
}

