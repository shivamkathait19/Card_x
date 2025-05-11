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
  TextEditingController fullnameController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController mobileController =TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  GlobalKey<FormState> _key = new GlobalKey();

  bool isloadingdone = false;

  NextScreen(){
    if (_key.currentState != null && _key.currentState!.validate()) {
      _key.currentState!.save();
    }
    setState(() {
      isloadingdone = true;
    });
    Future.delayed(Duration(seconds:1),() {
      setState(() {
        isloadingdone= false;
        Navigator.push(
            context,
            MaterialPageRoute(builder: (BuildContext context) => BlankPage())
        );
      });
    });
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => cardScreen(
          username: usernameController.text,
          full : fullnameController.text,
          date: dateController.text,
          mobile: mobileController.text,
          email: emailController.text,
        ),
      ),
    );
  }
     @override
          Widget build(BuildContext context) {
          return Scaffold(
           backgroundColor: Colors.white,
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
                     Row(
                       children: [
                         Expanded(
                           child: TextFormField(
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
                         SizedBox(width: 16), // Space between the fields
                         Expanded(
                           child: TextFormField(
                             controller: fullnameController,
                             decoration: InputDecoration(
                               labelText: "Full Name",
                               labelStyle: TextStyle(
                                 fontStyle: FontStyle.italic,
                               ),
                             ),
                             validator: (value) {
                               if (value == null || value.isEmpty) {
                                 return "Full Name is required";
                               }
                               return null;
                             },
                           ),
                         ),
                       ],
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
                           child:
                             isloadingdone ? CircularProgressIndicator():
                                Icon(Icons.navigate_next,
                                    size: 50,),
                               style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white, // Set color for text/icon
                             padding: EdgeInsets.symmetric(vertical: 1.0, horizontal: 5.0 ,),// Optional: padding

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

