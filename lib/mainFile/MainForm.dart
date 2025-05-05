/*import 'package:card_x/mainFile/cardScreen.dart';
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

  bool isloadingdone = false;

  NextScreen(){
    if (_key.currentState != null && _key.currentState!.validate()) {
      _key.currentState!.save();
    }
    setState(() {
      isloadingdone = true;
    });
    Future.delayed(Duration(seconds:7),() {
      setState(() {
        isloadingdone= false;
        Navigator.push(
            context,
            MaterialPageRoute(builder: (BuildContext context) => CardScreen())
        );
      });
    });
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => CardScreen(
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
           backgroundColor: Colors.black12,
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
                           child:
                             isloadingdone ? CircularProgressIndicator():
                                Icon(Icons.navigate_next,
                                    size: 50,),
                               style: ElevatedButton.styleFrom(
                             foregroundColor: Colors.white, backgroundColor: Colors.black45, // Set color for text/icon
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
*/
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:card_x/mainFile/cardScreen.dart';

class MainForm extends StatefulWidget {
  const MainForm({super.key});

  @override
  State<MainForm> createState() => _MainFormState();
}

class _MainFormState extends State<MainForm> {
  // Controllers for form fields
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController fatherController = TextEditingController();
  final TextEditingController motherController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  bool isLoading = false;

  void nextScreen() {
    if (_key.currentState != null && _key.currentState!.validate()) {
      _key.currentState!.save();

      setState(() {
        isLoading = true;
      });

      Future.delayed(const Duration(seconds: 7), () {
        setState(() {
          isLoading = false;
        });

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => CardScreen(
              username: usernameController.text,
              date: dateController.text,
              father: fatherController.text,
              mother: motherController.text,
              mobile: mobileController.text,
              email: emailController.text,
            ),
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _key,
          child: Column(
            children: [
              const SizedBox(height: 100),
              _buildTextField(Icons.person, "Username", usernameController),
              _buildTextField(Icons.calendar_today, "Date Of Birth", dateController),
              _buildTextField(Icons.person_outline, "Father's Name", fatherController),
              _buildTextField(Icons.person_outline, "Mother's Name", motherController),
              _buildTextField(
                Icons.phone,
                "Mobile Number",
                mobileController,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
              _buildTextField(
                Icons.email,
                "Email Address",
                emailController,
                keyboardType: TextInputType.emailAddress,
              ),
              _buildTextField(
                Icons.lock,
                "Password",
                passController,
                isPassword: true,
              ),
              const SizedBox(height: 50),
              Center(
                child: ElevatedButton(
                  onPressed: nextScreen,
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.black45,
                    padding: const EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: 20.0,
                    ),
                  ),
                  child: isLoading
                      ? const CircularProgressIndicator()
                      : const Icon(Icons.navigate_next, size: 50),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
      IconData icon,
      String label,
      TextEditingController controller, {
        TextInputType keyboardType = TextInputType.text,
        List<TextInputFormatter>? inputFormatters,
        bool isPassword = false,
      }) {
    return ListTile(
      leading: Icon(icon),
      title: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        obscureText: isPassword,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(fontStyle: FontStyle.italic),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return '$label is required';
          }
          if (isPassword && value.length < 6) {
            return 'Password must be at least 6 characters';
          }
          return null;
        },
      ),
    );
  }
}
