import 'dart:async';

import 'package:card_x/mainFile/cardScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

 class MainForm extends StatefulWidget {
    MainForm({super.key});

  @override
  State<MainForm> createState() => _MainFormState();
}

class _MainFormState extends State<MainForm>{
  TextEditingController usernameController = TextEditingController();
  TextEditingController fullnameController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController mobileController =TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  GlobalKey<FormState> _key = new GlobalKey();

  bool isloadingdone = false;
  String? selectedGender;
  bool _obscurePassword = true;


  // Gradient Colors for background animation
  List<List<Color>> gradientColors = [
    [Colors.teal.shade300, Colors.blue.shade200],
    [Colors.purple.shade300, Colors.pink.shade200],
    [Colors.orange.shade200, Colors.deepOrange.shade300],
    [Colors.green.shade300, Colors.lightGreen.shade200],
  ];
  int currentGradientIndex = 0;

  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(seconds: 5), (timer) {
      setState(() {
        currentGradientIndex =
            (currentGradientIndex + 1) % gradientColors.length;
      });
    });
  }
  void _lodingcard(){
    if (_key.currentState != null && _key.currentState!.validate()){
      setState(() => isloadingdone = true);
      Future.delayed(const Duration(seconds: 2), () {
        setState(() => isloadingdone = true);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CardScreen(
            username: usernameController.text,
            full : fullnameController.text,
            date: dateController.text,
            mobile: mobileController.text,
            email: emailController.text,
          )),
        );
      });
    }
  }

  /*void _loadinguser(){
    if (_key.currentState != null && _key.currentState!.validate()){
      if(selectedGender == null){}
      _key.currentState!.save();
    }
    setState(() {
      isloadingdone = true;
    });

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => CardScreen(
          username: usernameController.text,
          full : fullnameController.text,
          date: dateController.text,
          mobile: mobileController.text,
          email: emailController.text,
        ),
      ),
    );
  }*/
  InputDecoration _inputDecoration(String label){
    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(fontStyle: FontStyle.italic,),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 8),
    );
  }
     @override
          Widget build(BuildContext context) {
          return Scaffold(
            // backgroundColor: Colors.black26,
            appBar: AppBar(
              title: Text("User Registration",style: TextStyle(fontWeight: FontWeight.bold),),
              backgroundColor: Colors.teal,
              foregroundColor: Colors.white70,
              centerTitle: true,
            ),
           //backgroundColor: Colors.white,
          body: Container(
            child :SingleChildScrollView(
         child: Padding(
           padding: EdgeInsets.all(16),
           child: Form
                 (key: _key,
                 child: Column(
                   children: [
                     SizedBox(
                          height:10,
                        ),
                     Row(
                       children:[
                         Expanded(
                           child:  ListTile(
                             leading: Icon(Icons.person),
                             title:
                            TextFormField(
                             controller: usernameController,
                             decoration: InputDecoration(
                               labelText: "Username",
                             ),
                             validator: (value) {
                               if (value == null || value.isEmpty){
                                 return "Username is required";
                               }
                               return null;
                             },
                           ),
                         ),
                         ),
                         SizedBox(width: 10), // Space between the fields
                         Expanded(
                           child: ListTile(leading: Icon(Icons.badge),
                             title: TextFormField(
                             controller: fullnameController,
                             decoration: InputDecoration(
                               labelText: "Full Name",
                             ),

                             validator: (value){
                               if (value == null || value.isEmpty) {
                                 return "Full Name is required";
                               }
                               return null;
                             },
                           ),
                         ),
                         ),
                       ],
                     ),
             SizedBox(
               height: 10,
             ),
                     ListTile(
                         leading: Icon(Icons.calendar_today),
                         title:
                         TextFormField(
                          controller: dateController,
                          readOnly: true,
                          onTap:() async{
                            DateTime? pickedDate =await showDatePicker(context: context,
                              initialDate: DateTime(2000),
                            firstDate: DateTime(1900),
                            lastDate: DateTime.now(),
                            );
                           if (pickedDate != null) {

                             String formattedDate =
                                  "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
                           setState(() {
                             dateController.text=formattedDate;
                           });
                             }
                            },

                             decoration: _inputDecoration("Date of Birth").copyWith(
                               suffixIcon: const Icon(Icons.calendar_today),
                             ),
                             validator: (value) =>
                           value!.isEmpty? "Date of Birth is required" : null
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
                          decoration: _inputDecoration("Mobile number",),
                           validator: (value) =>
                           value!.isEmpty? "Date of Birth is required" : null
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
                          decoration: _inputDecoration(
                            "Email address",

                          ),
                               validator: (value) =>
                               value!.isEmpty? "Date of Birth is required" : null
                        ),
                         ),
                     SizedBox(
                       height: 10,
                     ),
                     ListTile(
                         leading: Icon(Icons.password) ,
                       title:TextFormField(
                       controller: passController,
                       obscureText: _obscurePassword,
                       decoration: _inputDecoration("Password").copyWith(
                         suffixIcon: IconButton(
                           icon: Icon(_obscurePassword ? Icons.visibility : Icons.visibility_off),
                           onPressed: () {
                             setState(() {
                               _obscurePassword = !_obscurePassword;
                             });
                           },
                         ),
                       ),
                       validator: (value) {
                         if (value == null || value.isEmpty) {
                           return "Password is required";
                         }
                         if (value.length < 6) {
                           return "Password must be at least 6 characters";
                         }
                         return null;
                       },
                     ),
                     ),
                     SizedBox(
                       height: 10,
                     ),

               Card(
    //   elevation: 2,
       shape: RoundedRectangleBorder(
       borderRadius: BorderRadius.circular(10)),
       child: Padding(
       padding: EdgeInsets.symmetric(vertical: 8),
       child: Column(
       children: [
       const ListTile(
       leading: Icon(Icons.wc),
       title: Text("Select Gender",style: TextStyle(fontWeight: FontWeight.w300 ),),
       ),
       RadioListTile<String>(
       title: const Text("Male"),
       value: "Male",
       groupValue: selectedGender,
       onChanged: (value) =>
       setState(() => selectedGender = value),
       ),
       RadioListTile<String>(
       title: const Text("Female"),
       value: "Female",
       groupValue: selectedGender,
       onChanged: (value) =>
       setState(() => selectedGender = value),
       ),
       if (selectedGender == null)
       const Padding(
       padding: EdgeInsets.only(left: 16.0),
       child: Align(
       alignment: Alignment.centerLeft,
       child: Text(
       "Please select gender",
       style:
       TextStyle(color: Colors.red, fontSize: 12),
       ),
       ),
       ),
       ],
       ),
       ),
       ),
                     SizedBox(
                          height: 10,
                        ),
                     isloadingdone
                         ?  CircularProgressIndicator()
                         : ElevatedButton(
                       onPressed: _lodingcard,
                       style: ElevatedButton.styleFrom(
                         backgroundColor: Colors.teal,
                         foregroundColor: Colors.white,
                         minimumSize: const Size(double.infinity, 50),
                         shape: RoundedRectangleBorder(
                           borderRadius: BorderRadius.circular(12),
                         ),
                       ),
                       child: const Text(
                         'Login',
                         style: TextStyle(fontWeight: FontWeight.bold),
                       ),
                     ),
                     /*  SizedBox(
                             width: double.infinity,
                             child: ElevatedButton.icon(
                               onPressed: isloadingdone ? null : _lodingcard,
                               style: ElevatedButton.styleFrom(
                                 padding: const EdgeInsets.symmetric(vertical: 16),
                                 backgroundColor: Colors.teal,
                                 shape: RoundedRectangleBorder(
                                   borderRadius: BorderRadius.circular(12),
                                 ),
                               ),
                               icon: isloadingdone
                                   ? const SizedBox(
                                 height: 20,
                                 width: 20,
                                 child: CircularProgressIndicator(
                                   color: Colors.white,
                                   strokeWidth: 2,
                                 ),
                               )
                                   : const Icon(Icons.navigate_next),
                               label: Text(
                                 isloadingdone ? "Loading..." : "Submit",
                                 style: const TextStyle(fontSize: 16),
                               ),
                             ),
                           ),*/
                     SizedBox(
                       height: 100,
                     )
                   ],
                     ),
                 ),

         ),
       ),
          ),

       );
  }
}



