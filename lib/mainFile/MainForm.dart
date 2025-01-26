import 'package:card_x/mainFile/cardScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class mainForm extends StatefulWidget {
    mainForm({super.key});

  @override
  State<mainForm> createState() => _mainFormState();
}



class _mainFormState extends State<mainForm> {
        var
        username,
      date,
      father,
      mother,
      mobile,
      email,
      password;
  GlobalKey<FormState> _key = new GlobalKey();

  NextScreen(){
    if(_key.currentState!=null){
      _key.currentState!.save();

    }
    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>cardScreen(
      username: username,
      date:date,
      father:father,
      mother: mother,
      mobile: mobile,
      email: email,
      password: password,

    ),
    )
    );
  }


   @override
   Widget build(BuildContext context) {
     return Scaffold(
         body:

         Padding(
         padding: EdgeInsets.all(20.0),

         child: SingleChildScrollView(

          child: Form (key: _key,
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

                           onSubmitted: (input)=>username=input,
                           decoration: InputDecoration(
                             labelText: "Username",
                               labelStyle: TextStyle(
                                 fontStyle: FontStyle.italic,
                               ),
                               border: OutlineInputBorder(
                                 borderRadius: BorderRadius.circular(10.0)),
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
                      onSubmitted: (input)=>date=input,
                      decoration: InputDecoration(
                        labelText: "Date Of Birth",
                          labelStyle: TextStyle(
                              fontStyle: FontStyle.italic
                          ) ,

                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0))),
                    ),
                   ),
                    SizedBox(
                      height: 10,
                    ),

                    ListTile(
                      leading: Icon(Icons.person_2),
                      title:
                      TextField(
                        onSubmitted: (input)=>father=input,
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
                    ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ListTile(
                      leading: Icon(Icons.person),
                      title:

                    TextField(
                      onSubmitted: (input)=>mother=input,
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
                      onSubmitted: (input)=>mobile=input,
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
                    ),
                 ),
                    SizedBox(
                      height: 10,
                    ),

                     ListTile(
                       leading: Icon(Icons.email),
                       title:

                    TextField(
                      onSubmitted: (input)=>email=input,
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
                    ),
                     ),
                    SizedBox(
                      height: 10,
                    ),


                    SizedBox(
                      height: 10,
                    ),

                    ButtonTheme(child: ElevatedButton(
                        onPressed: NextScreen, child: Text("Submit")))


               ],
                 ),
             ),
         ),

       )

       );
   }
}
