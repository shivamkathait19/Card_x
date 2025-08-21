import 'dart:ui';
import 'package:card_x/mainFile/Barcoms.dart';
import 'package:card_x/mainFile/MainForm.dart';
import 'package:card_x/mainFile/cardScreen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  runApp(MaterialApp(home: LoginScreen()));
}

class JumpingDots extends StatefulWidget {
  const JumpingDots({super.key, this.color = Colors.white});
  final Color color;

  @override
  State<JumpingDots> createState() => _JumpingDotsState();
}

class _JumpingDotsState extends State<JumpingDots>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<Animation<double>> _animations;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        duration: const Duration(milliseconds: 800), vsync: this)
      ..repeat(reverse: true);
    _animations = List.generate(3, (i) {
      return Tween<double>(begin: 0, end: -8).animate(CurvedAnimation(
        parent: _controller,
        curve: Interval(i * 0.2, 1.0, curve: Curves.easeInOut),
      ));
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildDot(Animation<double> animation) {
    return AnimatedBuilder(
      animation: animation,
      builder: (_, child) {
        return Transform.translate(offset: Offset(0, animation.value), child: child);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 2),
        width: 8,
        height: 8,
        decoration: BoxDecoration(
          color: widget.color,
          shape: BoxShape.circle,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: _animations.map(_buildDot).toList(),
    );
  }
}

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



  void _loginUser(){
    if (_formKey.currentState!.validate()){
      setState(() => isLoadinglogin = true);
      Future.delayed(const Duration(seconds: 2), () {
        setState(() => isLoadinglogin = false);
        Navigator.push(context, MaterialPageRoute(builder: (context)=>Barcoms()));
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
  bool get showOverlay => isLoadinglogin || isLoadingsingup;
  Widget build(BuildContext context){
    return Scaffold(backgroundColor: Colors.black,
      body: Container(
        decoration: BoxDecoration(
        ),
          child: Stack(
    children: [
          SafeArea(
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
                            padding: EdgeInsets.only(left: 10, right: 10,top: 30),
                            child:  TextFormField(
                              controller: _emailController,
                              style:  TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                labelText: 'Email',
                                labelStyle:  TextStyle(color: Colors.white70),
                                prefixIcon:  Icon(Icons.email, color: Colors.white70),
                                filled: true,
                                fillColor: Colors.grey[900],
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                             validator: (value){
                                if(value == null || value.isEmpty){
                                  return 'Plase enter your email';
                                }
                                if (!value.endsWith("@gamil.com")){
                                  return 'Please enter a vaild Gmail address';
                                }
                                return null;
                             },
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
                              ? const JumpingDots(color: Colors.white,)
                              : Padding(
                                padding: const EdgeInsets.only(left:10,right:10),
                                child: ElevatedButton(
                                  onPressed: _loginUser,
                                  style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue.withOpacity(0.30),
                                foregroundColor: Colors.white,
                                minimumSize: Size(double.infinity,50,),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                                          ),
                                  child:Text('Login', style: TextStyle(fontWeight: FontWeight.bold),),
                                ),
                              ),

                           SizedBox(height: 80,) ,
                          SizedBox(
                            width: double.infinity,
                            height: 45,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10,right: 10),
                              child: ElevatedButton.icon(
                                onPressed: (){
                                  // Add Facebook login logic here
                                },
                                icon:  Icon(Icons.facebook, color: Colors.white),
                                label: const Text("Continue with Facebook"),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue.withOpacity(0.50),
                                 //padding:  EdgeInsets.symmetric(vertical:10),
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
                            height: 45,
                            child: Padding(
                              padding: EdgeInsets.only(left: 10,right: 10),
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
                                  backgroundColor:  Colors.blue.withOpacity(0.70), // Google red
                                // padding:  EdgeInsets.symmetric(vertical:5),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  foregroundColor: Colors.white,
                                ),
                              ),
                            ),
                          ),

                          SizedBox(
                            height: 20,
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
                                    child: JumpingDots(color: Colors.white,)),
                              )
                                  : TextButton(
                                onPressed: NextScreen,
                                child:  Text(
                                  'Sign Up',
                                  style: TextStyle(color: Colors.lightBlueAccent),
                                ),
                              ),
                              SizedBox(height: 80,)
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


    if (showOverlay)
    Positioned.fill(
    child: BackdropFilter(
    filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
    child: Container(
    color: Colors.black.withOpacity(0.5),
    alignment: Alignment.center,
    child: const JumpingDots(),
    ),
    ),
    ),
    ],
        ),
      ),
    );
  }
}

