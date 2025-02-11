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
       body:  Container(
         decoration: BoxDecoration(
           boxShadow: [
             BoxShadow(
               color: Colors.white60.withOpacity(0.8), // Glow color
               spreadRadius:5, // How far the glow extends
               blurRadius:50,  // How blurred the glow is
               offset: Offset(20, 0), // Position of the glow
             ),
           ],
         ),
         child: Padding(
           padding: EdgeInsets.all(30.0),
             child: SingleChildScrollView(
               child: Form
                 (key: _key,
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
                               title:TextFormField(
                                 controller: usernameController,
                                 decoration: InputDecoration(
                                   labelText: "Username",
                                     labelStyle: TextStyle(
                                       fontStyle: FontStyle.italic,
                                     ),
                                     border: OutlineInputBorder(
                                       borderRadius: BorderRadius.circular(10.0),borderSide:BorderSide(

                                     )
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
                     SizedBox(
                             height: 10,
                             ) ,
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
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0)
                              )
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return " Date Of Birth is required";
                            }
                            return null;
                          },

                        ),
                       ),
                        SizedBox(
                          height: 10,
                        ),

                        ListTile(
                          leading: Icon(Icons.person_2),
                          title:
                          TextFormField(
                            controller : fatherController,
                          keyboardType: TextInputType.name,
                          decoration:InputDecoration(
                            labelText: "Father Name",

                              labelStyle: TextStyle(
                                fontStyle: FontStyle.italic
                              ) ,
                              border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0)
                            )

                          ),

                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return " Father name is required";
                              }
                              return null;
                            },
                        ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        ListTile(
                          leading: Icon(Icons.person),
                          title:
                          TextFormField(
                          controller: motherController,
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
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return " Mother name  is required";
                              }
                              return null;
                            },
                        ),
                        ),

                        SizedBox(
                          height: 10,
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
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0)
                            )
                          ),
                         validator: (value) {
                           if (value == null || value.isEmpty) {
                             return " Mobile name  is required";
                           }
                           return null;
                         },
                        ),
                     ),
                     SizedBox(
                          height: 10,
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
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0)

                            )
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return " email is required";
                            }
                            return null;
                          },
                        ),
                         ),
                        SizedBox(
                          height: 10,
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
                                   border: OutlineInputBorder(
                                       borderRadius: BorderRadius.circular(10.0)
                                 ),
                               ),
                                 validator: (value) {
                                   if (value == null || value.isEmpty) {
                                     return " Password is required";
                                   }
                                   if (!RegExp(r"^[a-zA-Z0-9]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)) {
                                     return "Invalid email format";
                                   }
                                   return null;
                                 },
                             ),
                             ),
                        SizedBox(
                          height: 50,
                        ),
                     Padding(
                       padding:  EdgeInsets.only(top:70,left: 200),
                       child:
                       Padding(
                         padding:  EdgeInsets.only(left: 100),
                         child: ElevatedButton(
                           onPressed: NextScreen,
                           child: Text(
                             "Log in ",
                             style: TextStyle(
                               fontStyle: FontStyle.italic,
                               color: Colors.white, // Change the text color
                             ),
                           ),
                           style: ElevatedButton.styleFrom(
                             foregroundColor: Colors.white, backgroundColor: Colors.blue, // Set color for text/icon
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
