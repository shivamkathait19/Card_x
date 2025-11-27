import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:card_x/view/LoginScreen.dart';
import 'package:flutter/material.dart';
import 'package:card_x/mainFile/MakeScreen.dart';
import 'package:card_x/mainFile/cardScreen.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';



// ====================== BARCOMS ======================
class Barcoms extends StatefulWidget {

  final String? username;
  final String? full;
  final String? date;
  final String? mobile;
  final String? email;

  const Barcoms({
    Key? key,
    this.username,
    this.full,
    this.date,
    this.mobile,
    this.email,
  }) : super(key: key);

  @override
  State<Barcoms> createState() => _BarcomsState();
}


class _BarcomsState extends State<Barcoms> {

Future<void> logout(BuildContext context) async{
  try{
    await FirebaseAuth.instance.signOut();

    final prefs  = await SharedPreferences.getInstance();
    await prefs.clear();

    Navigator.pushAndRemoveUntil(
        context, MaterialPageRoute(builder: (context)=> LoginScreen()),
  (route)=> false,
    );
  }catch(e) {
    print("Logout Error $e");
  }
}

void _goToBlankPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BlankPage(),
      ),
    );
  }

  void openCardScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CardScreen()),
    );
  }


void openMakeScreen() {
 
   Navigator.push(
     context,
     MaterialPageRoute(builder: (context) => MakeScreen()),
   );

}


  void log() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Column(
          children: [
            Text("Home",
                style: TextStyle(
                    color: Colors.black, fontFamily: 'StoryScript-Regular',
                 // fontWeight: FontWeight.w800,
                )
              ),

            Text(
                "Screen",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontFamily: 'StoryScript-Regular',
                    fontStyle: FontStyle.italic)),
          ],
        ),
      ),
      drawer: Drawer(
        backgroundColor: Colors.grey,
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.black, Colors.brown],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.person, color: Colors.teal, size: 30),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Welcome',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('My Profile',
                  style: TextStyle(
                      color: Colors.black, fontStyle: FontStyle.italic)),
              onTap: () {
                Navigator.pop(context);
                _goToBlankPage();
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings',
                  style: TextStyle(
                      color: Colors.black, fontStyle: FontStyle.italic)),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => SettingsPage(),
                    ));
              },
            ),
            ListTile(
              leading: Icon(Icons.info_outline),
              title: Text('About App',
                  style: TextStyle(
                      color: Colors.black, fontStyle: FontStyle.italic)),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => Aboutpage()));
              },
            ),
            Divider(),

            ElevatedButton(onPressed: (){
              logout(context);
            },
                child: Text("Logout",style: TextStyle(
                    color: Colors.red, fontStyle: FontStyle.italic
                ),)),
          ],
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF1e3c72), Color(0xFF2a5298)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Welcome to Card X",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  fontFamily:  'StoryScript-Regular',
                  color: Colors.white,
                  letterSpacing: 1.5,
                  decoration: TextDecoration.lineThrough,
                  decorationColor: Colors.black,
                  shadows: [
                    Shadow(
                      color: Colors.black.withOpacity(0.4),
                      blurRadius: 6,
                      offset: const Offset(2, 2),
                    ),
                  ],
                ),
              ),
              Divider(),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: openCardScreen,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white.withOpacity(0.15),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 40, vertical: 16),
                  elevation: 6,
                  shadowColor: Colors.black54,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
                child: const Text(
                  "✨ Tap to See Memes",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'EBGaramond-Italic-VariableFont_wght',
                    letterSpacing: 1,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: openMakeScreen,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepOrangeAccent.withOpacity(0.9),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 30, vertical: 16),
                  elevation: 10,
                  shadowColor: Colors.black87,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
                child: const Text(
                  "📝 Tap to Create Own Card",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'EBGaramond-Italic-VariableFont_wght',
                    letterSpacing: 1,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ====================== PROFILE PAGE ======================
class BlankPage extends StatefulWidget {
  const BlankPage({Key? key}) : super(key: key);

  @override
  State<BlankPage> createState() => _BlankPageState();
}

class _BlankPageState extends State<BlankPage> {
  String username = "";
  String fullname = "";
  String date = "";
  String mobile = "";
  String email = "";

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      fullname = prefs.getString('user_name') ?? '' ;
      email = prefs.getString('user_email') ?? '';



      username = prefs.getString('username') ?? '';
      fullname = prefs.getString('fullname') ?? '';
      date = prefs.getString('date') ?? '';
      mobile = prefs.getString('mobile') ?? '';
      email = prefs.getString('email') ?? '';
    });
  }

  Widget infoCard(String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black12,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black12.withOpacity(0.08),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
          border: Border.all(color: Colors.black12, width: 2),
        ),
        child: ListTile(
          leading: CircleAvatar(
            radius: 24,
            backgroundColor: Colors.black12,
            child: Icon(icon, color: Colors.blueAccent, size: 26),
          ),
          title: Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: Colors.white,
            ),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              value.isNotEmpty ? value : 'Not provided',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown,
      appBar: AppBar(
        title: const Text("My Profile", style: TextStyle(fontStyle: FontStyle.italic)),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: ListView(
        children: [
          const SizedBox(height: 30),
          const CircleAvatar(
            radius: 50,
            backgroundColor: Colors.white70,
            child: Icon(Icons.person, size: 50, color: Colors.black),
          ),
          const SizedBox(height: 30),
          infoCard("Username", username, Icons.person),
          infoCard("Full Name", fullname, Icons.person_outline),
          infoCard("Email", email, Icons.email_outlined),
          infoCard("Date of Birth", date, Icons.cake),
          infoCard("Mobile Number", mobile, Icons.phone_android),
        ],
      ),
    );
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown,
      appBar: AppBar(
        title: Text("My Profile", style: TextStyle(fontStyle: FontStyle.italic)),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: ListView(
        children: [
          const SizedBox(height: 30),
          const CircleAvatar(
            radius: 50,
            backgroundColor: Colors.white70,
            child: Icon(Icons.person, size: 50, color: Colors.black),
          ),
          SizedBox(height: 30),
        ],
      ),
    );
  }


// ====================== ABOUT PAGE ======================


class Aboutpage extends StatelessWidget {
  const Aboutpage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black26,
      appBar: AppBar(
        title: Padding(
          padding: EdgeInsets.only(right: 50),
          child: Center(
              child: Text("About phone", style: TextStyle(color: Colors.black))),
        ),
        backgroundColor: Colors.teal,
      ),
      body: ListView(
        children: [
          SizedBox(height: 50),
          ListTile(
            title: Text("Device Name",
                style: TextStyle(
                    color: Colors.white,
                    fontStyle: FontStyle.italic,
                    fontSize: 20)),
            subtitle: Text("Card X Ultra Pro Max"),
            leading: Icon(Icons.devices),
          ),
          ListTile(
            title: Text("Model Number",
                style: TextStyle(
                    color: Colors.white,
                    fontStyle: FontStyle.italic,
                    fontSize: 20)),
            subtitle: Text("CX-9999"),
            leading: Icon(Icons.confirmation_number),
          ),
          ListTile(
            title: Text("Android Version",
                style: TextStyle(
                    color: Colors.white,
                    fontStyle: FontStyle.italic,
                    fontSize: 20)),
            subtitle: Text("14.0 (Tiramisu++)"),
            leading: Icon(Icons.android),
          ),
          ListTile(
            title: Text("Security Patch Level",
                style: TextStyle(
                    color: Colors.white,
                    fontStyle: FontStyle.italic,
                    fontSize: 20)),
            subtitle: Text("1 June 2025"),
            leading: Icon(Icons.security),
          ),
          ListTile(
            title: Text("Build Number",
                style: TextStyle(
                    color: Colors.white,
                    fontStyle: FontStyle.italic,
                    fontSize: 20)),
            subtitle: Text("CAX999.1.5.9.21"),
            leading: Icon(Icons.code),
          ),
          ListTile(
            title: Text("Kernel Version",
                style: TextStyle(
                    color: Colors.white,
                    fontStyle: FontStyle.italic,
                    fontSize: 20)),
            subtitle: Text("5.15.92-android"),
            leading: Icon(Icons.memory),
          ),
        ],
      ),
    );
  }
}

// ====================== SETTINGS PAGE ======================
class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool isDarkMode = false;
  bool notificationsEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text("SETTINGS",
            style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.teal, Colors.deepPurple],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      backgroundColor: Colors.black,
      body: Container(
        padding:
        EdgeInsets.only(top: 10, left: 16, right: 16, bottom: 16),
        child: ListView(
          children: [
            _buildSwitchTile(
              icon: Icons.dark_mode,
              title: "Dark Mode",
              subtitle: "Toggle app theme",
              value: isDarkMode,
              onChanged: (value) => setState(() => isDarkMode = value),
            ),
            _buildSwitchTile(
              icon: Icons.notifications_active_outlined,
              title: "Notifications",
              subtitle: "Enable push notifications",
              value: notificationsEnabled,
              onChanged: (value) =>
                  setState(() => notificationsEnabled = value),
            ),
            _buildTile(
              icon: Icons.language,
              title: "Language",
              subtitle: "English",
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Language settings coming soon!"),
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Colors.teal,
                  ),
                );
              },
            ),
            _buildTile(
              icon: Icons.privacy_tip_outlined,
              title: "Privacy Policy",
              onTap: () {
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: const Text("Privacy Policy"),
                    content: const Text("Your data is safe."),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text("OK"),
                      ),
                    ],
                  ),
                );
              },
            ),
            _buildTile(
              icon: Icons.info_outline,
              title: "About App",
              subtitle: "Version 1.0.0",
              onTap: () {
                showAboutDialog(
                  context: context,
                  applicationName: "Card X",
                  applicationVersion: "1.0.0",
                  applicationLegalese: "© 2025 by Shivam",
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSwitchTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required Function(bool) onChanged,
  }) {
    return Card(
      color: Colors.white.withOpacity(0.08),
      elevation: 6,
      shape:
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: SwitchListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
        secondary: Icon(icon, color: Colors.tealAccent),
        title: Text(title,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.w500)),
        subtitle: Text(subtitle,
            style: const TextStyle(color: Colors.white70)),
        value: value,
        onChanged: onChanged,
        activeColor: Colors.tealAccent,
        inactiveThumbColor: Colors.grey,
        inactiveTrackColor: Colors.white24,
      ),
    );
  }

  Widget _buildTile({
    required IconData icon,
    required String title,
    String? subtitle,
    required VoidCallback onTap,
  }) {
    return Card(
      color: Colors.white.withOpacity(0.08),
      elevation: 6,
      shape:
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        leading: Icon(icon, color: Colors.tealAccent),
        title: Text(title,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.w500)),
        subtitle: subtitle != null
            ? Text(subtitle,
            style: const TextStyle(color: Colors.white70))
            : null,
        onTap: onTap,
      ),
    );
  }
}
