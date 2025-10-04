import 'dart:ui';import 'dart:async';
import 'package:card_x/mainFile/Barcoms.dart';
import 'package:card_x/mainFile/MainForm.dart';
import 'package:card_x/mainFile/cardScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
//import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  bool _isLoading = false ;
  bool isLoadinglogin = false;
  bool isLoadingsingup = false;

  @override
  void initState(){
    super.initState();
      //_loadUserData();
    }

/*Future<void>_loadUserData()async{
   // final prefs = await SharedPreferences.getInstance();
    final user = FirebaseAuth.instance.currentUser;
    if(user != null){
      String? savedCards = await UserDataManger.loadData("cards");
      String? savedMemes = await UserDataManger.loadData("memes");

      if(savedCards !=null){
        print("preview cards for ${user.uid}: $savedCards");

      }
      if (savedCards != null){
        print("preview cards for ${user.uid} : $savedCards");
      }
    }
}*/


  Future<void> loginWithEmailPassword(
      BuildContext context, String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Login success → next screen pe bhejo
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Barcoms()),
      );
    } on FirebaseAuthException catch (e) {
      String message;
      if (e.code == 'user-not-found') {
        message = "";
      } else if (e.code == 'wrong-password') {
        message = "Wrong password ";
      } else if (e.code == 'invalid-email') {
        message = "Email format wrong";
      } else {
        message = "Login failed: ${e.message}";
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    }
    final User? user = FirebaseAuth.instance.currentUser;
    if(user !=null){
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString("uid", user.uid);
      await prefs.setString('uid', user.uid);
      await prefs.setString('uid',user.uid);
      await prefs.setString('uid', user.uid);
    }
  }

  /* Future<void> _loginUser(BuildContext context) async {
      try {
        UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passController.text.trim(),
        );

        // ✅ Login successful → navigate to home
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Welcome ${userCredential.user?.email}")),
        );
        Navigator.pushReplacementNamed(context, "/home");

      } on FirebaseAuthException catch (e) {
        String message = "An error occurred";
        if (e.code == 'user-not-found') {
          message = "No user found for this email.";
        } else if (e.code == 'wrong-password') {
          message = "Incorrect password.";
        }
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
      }
    }*/
// Facebook auth hai

  Future<User?> signInWithGoogle() async {
    setState(() => _isLoading = true);
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) {
        // 👉 User ne cancel / bg pe click kiya


        setState(() => _isLoading = false);
        return null; // ❌ yaha se return ho jayega, aage nahi jayega
      }

      // ✅ Agar user ne account select kiya
      final GoogleSignInAuthentication googleAuth =
      await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final user =
          (await FirebaseAuth.instance.signInWithCredential(credential)).user;



      return user;
    } catch (e) {
      
      return null;
    } finally {
      setState(() => _isLoading = false);
    }
  }





  /*  Future<void> signInWithFacebook(BuildContext context) async {
    try {
      final LoginResult result = await FacebookAuth.instance.login();

      if (result.status == LoginStatus.success) {
        final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(result.accessToken!.tokenString);

        await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Facebook Sign-In successful!")),
        );

        Navigator.pushReplacementNamed(context, "/home");
      }else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Facebook Sign-In failed: ${result.message}")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    }
  }*/
 /*static Future<void>clearUserData()async{
   final user = FirebaseAuth.instance.currentUser;
   if(user == null) return;
   final prefs = await SharedPreferences.getInstance();
   await prefs.remove("${user.uid}_cards");
   await prefs.remove("${user.uid}_memes");
   await prefs.remove("uid");
 }*/



 void loginUser(){
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
                  height: 550,
                  width: 500,
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
                                  return ' Enter your email';
                                }
                                if (!RegExp(r'^[a-zA-Z0-9._%+-]+@gmail\.com$',caseSensitive: false
                                ).hasMatch(value.trim())) {
                                  return 'Please enter a valid Gmail address';
                                }
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
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate()) {
                                      setState(() => isLoadinglogin = true);

                                      await loginWithEmailPassword(
                                        context,
                                        _emailController.text.trim(),
                                        _passController.text.trim(),
                                      );

                                      setState(() => isLoadinglogin = false);
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blue.withOpacity(0.30),
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

                          ),
                          SizedBox(height: 80,) ,
                        /*  SizedBox(
                            width: double.infinity,
                            height: 45,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10,right: 10),
                              child: ElevatedButton.icon(
                                onPressed: () {},
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
                          ),*/
                          Padding(
                            padding:  EdgeInsets.only(bottom: 10,top: 10),
                            child: Text("Or",style: TextStyle(fontSize:17,color: Colors.white60,fontFamily: 'StoryScript-Regular'),),
                          ),
                          SizedBox(
                            width: double.infinity,
                            height: 40,
                            child: Padding(
                              padding: EdgeInsets.only(left: 10,right: 10),
                              child : _isLoading ? Padding(
                                padding: const EdgeInsets.only(bottom: 50),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CircularProgressIndicator(),
                                    SizedBox(height: 15,),
                                    Text(" Signing in , please wait ")
                                  ],
                                ),
                              ) : ElevatedButton.icon(
                                onPressed: ()async{
                                  setState(() {
                                    _isLoading = true;
                                  });
                                  final user = await signInWithGoogle();
                                  if(signInWithGoogle!=null){
                                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Barcoms()));
                                  }
                                  /*final UserCredential = await signInWithGoogle();
                                  if(signInWithGoogle != null){
                                  }*/
                                  // Add Google login logic here
                                /*final user = await signInWithGoogle();
                                  if( user != null){
                                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Barcoms()));
                                  }*/
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
                            height: 7,
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
 /*class UserDataManger{
  static Future<void> savedDataForUSer(String key , String value)async{
    final User? user = FirebaseAuth.instance.currentUser;
    if(user != null){
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString("${user.uid}_$key", value);
    }
  }
   static Future loadData(String key)async{
    final User? user = FirebaseAuth.instance.currentUser;
    if(user !=null){
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString("${user.uid}_$key");
    } return null ;
   }
 }*/

