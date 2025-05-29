import 'package:card_x/mainFile/MainForm.dart';
import 'package:card_x/mainFile/cardScreen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  String? _email;
  String? _pass;

 bool isLoadinglogin = false;
 bool isLoadingsingup = false;



  void _loginUser() {
    if (_formKey.currentState!.validate()) {
      setState(() => isLoadinglogin = true);
      Future.delayed(const Duration(seconds: 2), () {
        setState(() => isLoadinglogin = false);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const CardScreen()),
        );
      });
    }
  }
  NextScreen() {
    if (_formKey.currentState!.validate()) {}
    setState(() {
      isLoadingsingup = true;
    });
    Future.delayed(Duration(seconds: 5),() {
    setState(() {
      isLoadingsingup= false;
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => MainForm())
      );
    });
    });
  }

  @override
       Widget build(BuildContext context){
    return Scaffold(backgroundColor: Colors.black,
      body: Container(
        decoration: BoxDecoration(
        ),
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      'asset/solated-on-black.jpg',
                      height: 150,
                      width: 140,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Text(
                    "Welcome Back!",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                   SizedBox(height: 10),
                     Text(
                    "Login to continue",
                    style: TextStyle(color: Colors.white54),
                  ),
                  SizedBox(
                    height: 40,
                  ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Container(
                  //padding: const EdgeInsets.all(),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.white10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child:   Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          // Email TextFormField
                          Padding(
                            padding: EdgeInsets.only(left: 10, right: 10),
                            child:  TextFormField(
                              controller: _emailController,
                              style: const TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                labelText: 'Email',
                                labelStyle: const TextStyle(color: Colors.white70),
                                prefixIcon: const Icon(Icons.email, color: Colors.white70),
                                filled: true,
                                fillColor: Colors.grey[900],
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              validator: (value) =>
                              value!.isEmpty ? 'Please enter your email' : null,
                            ),
                          ),
                          SizedBox(height: 10,),
                          Padding(
                            padding: EdgeInsets.only(left: 10, right: 10),
                            child:  TextFormField(
                              controller: _passController,
                              obscureText: true,
                              style: const TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                labelText: 'Password',
                                labelStyle: const TextStyle(color: Colors.white70),
                                prefixIcon: const Icon(Icons.lock, color: Colors.white70),
                                filled: true,
                                fillColor: Colors.grey[900],
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              validator: (value) =>
                              value!.isEmpty ? 'Please enter your password' : null,
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {},
                              child: const Text(
                                'Forgot Password?',
                                style: TextStyle(color: Colors.blueAccent),
                              ),
                            ),
                          ),
                          // Login Button
                          isLoadinglogin
                              ? const CircularProgressIndicator()
                              : Padding(
                                padding: const EdgeInsets.only(left:50,right:50),
                                child: ElevatedButton(
                                                          onPressed: _loginUser,
                                                          style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                foregroundColor: Colors.white,
                                minimumSize: Size(double.infinity,50,),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                                          ),
                                  child:Text('Login', style: TextStyle(fontWeight: FontWeight.bold),),
                                ),
                              ),

                SizedBox(height: 90,) ,
                          SizedBox(
                            width: double.infinity,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 50,right: 50),
                              child: ElevatedButton.icon(
                                onPressed: (){
                                  // Add Facebook login logic here
                                },
                                icon:  Icon(Icons.facebook, color: Colors.white),
                                label: const Text("Continue with Facebook"),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xFF1877F2),
                                  padding:  EdgeInsets.symmetric(vertical: 5),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  foregroundColor: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          Text("Or",style: TextStyle(fontSize:12,color: Colors.white60),),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton.icon(
                              onPressed: (){
                                // Add Google login logic here
                              },
                              icon:  Icon(
                                FontAwesomeIcons.google,
                                color: Colors.white,
                              ),
                              label: Text("Continue with Google"),
                              style: ElevatedButton.styleFrom(
                                backgroundColor:  Color(0xFF30A1D2), // Google red
                               padding:  EdgeInsets.symmetric(vertical:5),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                foregroundColor: Colors.white,
                              ),
                            ),
                          ),

                          SizedBox(
                            height: 50,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Don't have an account?",
                                style: TextStyle(color: Colors.white70),
                              ),
                              isLoadingsingup
                                  ? const Padding(
                                padding: EdgeInsets.only(left: 8.0),
                                child: SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(strokeWidth: 2)),
                              )
                                  : TextButton(
                                onPressed: NextScreen,
                                child:  Text(
                                  'Sign Up',
                                  style: TextStyle(color: Colors.lightBlueAccent),
                                ),
                              ),
                            ],
                          )

                        ],
                          ),

                    ),
                ),
              ),
                ],
              ),
            ),
          ),
        ),
      );

  }
}
Widget _buildTextField({
  required TextEditingController controller,
  required String label,
  required IconData icon,
  required bool isPassword,
}) {
  return TextFormField(
    controller: controller,
    obscureText: isPassword,
    style: const TextStyle(color: Colors.white),
    decoration: InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.white70),
      prefixIcon: Icon(icon, color: Colors.white70),
      filled: true,
      fillColor: Colors.white.withOpacity(0.1),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.white24),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.blueAccent),
      ),
    ),
    validator: (value) => value!.isEmpty ? 'Please enter your $label' : null,
  );
}

