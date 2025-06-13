import 'dart:async';
import 'package:card_x/mainFile/cardScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

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
  
  List<List<Color>> gradientColors = [
  //  [Colors.teal.shade300, Colors.blue.shade200],
    //[Colors.purple.shade300, Colors.pink.shade200],
    //[Colors.orange.shade200, Colors.deepOrange.shade300],
    //[Colors.green.shade300, Colors.lightGreen.shade200],
  ];
  int currentGradientIndex = 0;

  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(seconds: 2), (timer) {
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

  InputDecoration _inputDecoration(String label){
    return InputDecoration(
      labelText: label ,
      labelStyle: TextStyle(
        fontStyle: FontStyle.italic,
        color: Colors.white,
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white54),
        borderRadius: BorderRadius.circular(12),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white, width: 2),
        borderRadius: BorderRadius.circular(12),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.redAccent),
        borderRadius: BorderRadius.circular(12),
      ),
      filled: true,
      fillColor: Colors.white.withOpacity(0.1),
      contentPadding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
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
          body:
          Container(
            color: Colors.black,
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
                             leading: Icon(Icons.person,color: Colors.white,),
                             title:
                            TextFormField(
                             controller: usernameController, style: TextStyle(color: Colors.white),
                             decoration: _inputDecoration(
                                 "Username"
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
                           child: ListTile(leading: Icon(Icons.badge,color: Colors.white,),
                             title: TextFormField(
                             controller: fullnameController,style: TextStyle(color: Colors.white),
                             decoration: _inputDecoration(
                               "Full Name",
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
                         leading: Icon(Icons.calendar_today,color: Colors.white,),
                         title:
                         TextFormField(
                          controller: dateController, style: TextStyle(color: Colors.white),
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
                               suffixIcon: const Icon(Icons.calendar_today,color: Colors.white,),
                             ),
                             validator: (value) =>
                           value!.isEmpty? "Date of Birth is required" : null
                         ),
                       ),
                     SizedBox(
                       height: 10,
                     ),
                     ListTile(
                       leading: Icon(Icons.phone,color: Colors.white),
                       title:
                       TextFormField(
                          controller: mobileController, style: TextStyle(color: Colors.white),
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
                           leading: Icon(Icons.email,color: Colors.white,),
                           title:
                           TextFormField(
                          controller: emailController, style: TextStyle(color: Colors.white),
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
                         leading: Icon(Icons.password,color: Colors.white,) ,
                       title:TextFormField(
                       controller: passController, style: TextStyle(color: Colors.white),
                       obscureText: _obscurePassword,
                       decoration: _inputDecoration("Password").copyWith(
                         suffixIcon: IconButton(
                           icon: Icon(_obscurePassword ? Icons.visibility : Icons.visibility_off,color: Colors.white),
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
       borderRadius: BorderRadius.circular(10),),color: Colors.white70.withOpacity(0.500),
       child: Padding(
       padding: EdgeInsets.symmetric(vertical: 8),
       child: Column(
       children: [
       const ListTile(
       leading: Icon(Icons.wc,color: Colors.white,),
       title: Text("Select Gender",style: TextStyle(fontWeight: FontWeight.w300 ),),
       ),
       RadioListTile<String>(
       title: const Text("Male",style: TextStyle(color: Colors.white),),
       value: "Male",
       groupValue: selectedGender,
       onChanged: (value) =>
       setState(() => selectedGender = value),
       ),
       RadioListTile<String>(
       title: const Text("Female",style: TextStyle(color: Colors.white)),
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
                     SizedBox(height: 10,),
                     isloadingdone
                         ? SpinKitPouringHourGlass(
                       color: Colors.white70,
                       size: 100.0,
                       //type: SpinKitWaveType.center,
                     )
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

                     SizedBox(
                       height: 150,
                     )
                   ],
                     ),
                 ),

         ),
       ),
          ),
       //   ),
       );
  }
}



