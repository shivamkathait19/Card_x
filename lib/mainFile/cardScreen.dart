import 'dart:math';
import 'package:card_x/main.dart';
import 'package:card_x/mainFile/FetchMemes.dart';
import 'package:card_x/mainFile/MainForm.dart';
import 'package:flutter/material.dart';
import 'package:card_x/view/LoginScreen.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class CardScreen extends StatefulWidget {
  final String? username;
  final String? full;
  final String? date;
  final String? father;
  final String? mother;
  final String? mobile;
  final String? email;



   CardScreen({
    Key? key,
    this.username,
    this.full,
    this.date,
    this.father,
    this.mother,
    this.mobile,
    this.email,
  }) : super(key: key);

  @override
  State<CardScreen> createState() => _CardScreenState();
}
bool isFavorite = false;
String imgUrl = "";
int number = 0;
int target = 10  ;
bool isLoading = true;
List<String> favorites = [];
Color currentBgColor = Color(0xFFF0F2F5);

class _CardScreenState extends State<CardScreen> with TickerProviderStateMixin {
final List<Color> bgColors = [
Color(0xFFF0F2F5),
Color(0xFFE8F5E9),
Color(0xFFFFF3E0),
Color(0xFFFFEBEE),
Color(0xFFE3F2FD),
];
List<EmojiParticle> emojiParticles = [];
  void _goToBlankPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BlankPage(
          username: widget.username,
          full: widget.full,
          date: widget.date,
          mobile: widget.mobile,
          email: widget.email,
        ),
      ),
    );
  }

@override
  void initState(){
    super.initState();
    //loadFavorites();
    UpdateImg();
  }



  Future<void> UpdateImg() async{
    String getImgUrl = await FetchMemes.fetchNewMemes();
    setState(() {
      imgUrl = getImgUrl;
      number++;
      currentBgColor = (bgColors.toList()..shuffle()).first;

      if(number == target){
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _showTargetDialog();
        });
          target +=50;
      }
      isLoading = false;
    });
  }

  void  _showTargetDialog(){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("🎉 Target Achieved!"),
          content: Text(
              "You have seen $number memes!\nNext target: $target memes."),
          actions: [
            TextButton(child: Text("Ok"), onPressed: () {
              Navigator.of(context).pop();
            }
            ),
          ],
        );
      },
    );
  }
void showEmojiBurst(String emoji) {
  final random = Random();
  for (int i = 0; i < 5; i++) {
    final controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000 + random.nextInt(500)),
    );
    final animation = Tween<Offset>(
      begin: Offset(0, 0),
      end: Offset((random.nextDouble() * 2 - 1), -2 - random.nextDouble()),
    ).animate(CurvedAnimation(parent: controller, curve: Curves.easeOut));

    final particle = EmojiParticle(
      emoji: emoji,
      controller: controller,
      animation: animation,
      key: UniqueKey(),
    );

    controller.forward().whenComplete(() {
      setState(() {
        emojiParticles.remove(particle);
      });
    });

    setState(() {
      emojiParticles.add(particle);
    });
  }
}

@override
void dispose() {
  for (var p in emojiParticles) {
    p.controller.dispose();
  }
  super.dispose();
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: currentBgColor,
      appBar: AppBar(
        backgroundColor: Colors.teal.shade500,
        title: const Text("Funny Memes"),
        centerTitle: true,
        elevation: 5,
        shadowColor: Colors.teal,
        automaticallyImplyLeading: true,
      ),
      drawer: Drawer(
        backgroundColor: Colors.black,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.teal, Colors.tealAccent.shade200],
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
                    'Welcome, ${widget.username ?? "User"}',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  SizedBox(height: 10,),

                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home',style: TextStyle(color: Colors.white60),),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('My Profile',style: TextStyle(color: Colors.white60),),
              onTap: () {
                Navigator.pop(context);
                _goToBlankPage();
              },
            ),
            ListTile(
              leading: Icon(Icons.favorite),
              title: Text('Favorites',style: TextStyle(color: Colors.white60),),
              onTap: () {
               Navigator.pop(context);
               Navigator.push(context, MaterialPageRoute(builder: (_)=> Favoritespage(),));
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings',style: TextStyle(color: Colors.white60),),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (_)=>  SettingsPage(),));
              },
            ),
            ListTile(
              leading: Icon(Icons.info_outline),
              title: Text('About App',style: TextStyle(color: Colors.white60),),
              onTap: () {
               Navigator.pop(context);
                Navigator.push(context,
                   MaterialPageRoute(builder: (_) => Aboutpage()));
              },
            ),
            ListTile(
              leading: Icon(Icons.help_outline),
              title: Text('Help & Support',style: TextStyle(color: Colors.white60),),
              onTap:(){
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (_)=> Helppage()));
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text("Log Out", style: TextStyle(color: Colors.red)),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (_) => LoginScreen()));
              },
            ),
            SizedBox(height: 20),
            Center(
              child: Text(
                "Made with ❤️ by shivam",
                style: TextStyle(color: Colors.grey),
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
      body: Stack(
          children: [

      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Target: ", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Text("$number/$target", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.teal.shade700)),
              ],
            ),
            SizedBox(height: 10),
             AnimatedContainer(
             duration: Duration(milliseconds: 100),
             height: 650,
             width: double.infinity,
             margin: EdgeInsets.symmetric(horizontal: 20),
             decoration: BoxDecoration(
             color: Colors.white,
             borderRadius: BorderRadius.circular(20),
             boxShadow:  [
             BoxShadow(color: Colors.black26, blurRadius: 10, offset: Offset(0, 6)),
             ],
             ),
               child: isLoading
                   ? Center(child: CircularProgressIndicator())
                   : ClipRRect(
                 borderRadius: BorderRadius.circular(20),

                 child: Image.network(
                   imgUrl,
                  // fit: BoxFit.cover,
                   loadingBuilder: (context, child, loadingProgress) {
                     if (loadingProgress == null) return child;
                     return Center(child: CircularProgressIndicator());
                   },
                   errorBuilder: (context, error, stackTrace) =>
                       Center(child: Text("Failed to load image")),
                 ),
               ),
            ),
             Row(
               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
             children: [
                 GestureDetector(
                 onTap: () => showEmojiBurst("😂"),
      child: Text("😂", style: TextStyle(fontSize: 36)),
    ),
    GestureDetector(
    onTap: () => showEmojiBurst("😒"),
    child: Text("😒", style: TextStyle(fontSize: 36)),
    ),
    ],
             ),
            SizedBox(height: 5,),
            ElevatedButton.icon(
              onPressed:()async{
                setState(() => isLoading = true);
                await UpdateImg();
              },
              icon: Icon(Icons.navigate_next),
              label: Text("Next Meme"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
      ...emojiParticles,
    ]
      ),
    // ✅ Floating Button

    );
  }
}
 class EmojiParticle extends StatelessWidget {
   final String emoji;
   final AnimationController controller;
   final Animation<Offset> animation;

   const EmojiParticle({
     super.key,
     required this.emoji,
     required this.controller,
     required this.animation,
   });

   @override
   Widget build(BuildContext context) {
     return AnimatedBuilder(
       animation: controller,
       builder: (_, __) {
         return Positioned(
           bottom: 100,
           left: MediaQuery.of(context).size.width / 2 - 16,
           child: SlideTransition(
             position: animation,
             child: Opacity(
               opacity: 1 - controller.value,
               child: Text(
                 emoji,
                 style: TextStyle(fontSize: 28),
               ),
             ),
           ),
         );
       },
     );
   }
 }


class BlankPage extends StatefulWidget {
  final String? username;
  final String? full;
  final String? date;
  final String? mobile;
  final String? email;

  const BlankPage({
    Key? key,
    this.username,
    this.full,
    this.date,
    this.mobile,
    this.email,
  }) : super(key: key);

  @override
  State<BlankPage> createState() => _BlankPageState();
}

class _BlankPageState extends State<BlankPage> {
  void mainPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (BuildContext context) => LoginScreen()),
    );
  }

  Widget infoCard(String label, String? value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
      child: Container(
        height: 90,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.10),
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 3)),
          ],

        ),
        child: ListTile(
          leading: Icon(icon, color: Colors.teal, size: 28),
          title: Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.w500,fontStyle: FontStyle.italic,color: Colors.white),
          ),
          subtitle: Text(
            value ?? 'Not provided',
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      ),

    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black26,
      appBar: AppBar(
        title: const Text("My Profile"),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
       body: ListView(
         children: [
           const SizedBox(height: 30),
           const CircleAvatar(
            radius: 50,
            backgroundColor: Colors.teal,
            child: Icon(Icons.person, size: 50, color: Colors.white),
          ),
            SizedBox(height: 30),
          infoCard("Username", widget.username, Icons.person),
          infoCard("Full Name", widget.full, FeatherIcons.userCheck),
          infoCard("Email", widget.email, Icons.email_outlined),
          infoCard("Date of Birth", widget.date, Icons.cake),
          infoCard("Mobile Number", widget.mobile, Icons.phone_android),
          const SizedBox(height: 40),
          Center(

          ),
          SizedBox(height: 40),
        ],
      ),
    );
  }
}
class Favoritespage extends StatelessWidget {
  Favoritespage({Key? key }) : super (key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Favorites'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          "Your favorite memes will appear here.",
          style: TextStyle(fontSize: 18, color: Colors.grey[700]),
        ),
      ),
    );
  }
}



 class Aboutpage extends StatefulWidget{
  Aboutpage ({Key? key}) : super (key: key);

  @override
  State<Aboutpage> createState()=> _AboutpageState();
 }
 class _AboutpageState extends State<Aboutpage>{

  @override
   Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.black26,
      appBar: AppBar(
        title: Padding(
          padding:  EdgeInsets.only(right:50),
          child: Center(child: Text("About phone",style: TextStyle(color: Colors.black),)),
        ),
        backgroundColor: Colors.teal,
      ),
      body:
      ListView(
        children: [
          SizedBox(
            height: 50,
          ),
          ListTile(
            title: Text("Device Name",style: TextStyle(color: Colors.white,fontStyle: FontStyle.italic,fontSize: 20),),
            subtitle: Text("Card X Ultra Pro Max"),
            leading: Icon(Icons.devices),
          ),
          ListTile(
            title: Text("Model Number",style: TextStyle(color: Colors.white,fontStyle: FontStyle.italic,fontSize: 20),),
            subtitle: Text("CX-9999"),
            leading: Icon(Icons.confirmation_number),
          ),
          ListTile(
            title: Text("Android Version",style: TextStyle(color: Colors.white,fontStyle: FontStyle.italic,fontSize: 20),),
            subtitle: Text("14.0 (Tiramisu++)"),
            leading: Icon(Icons.android),
          ),
          ListTile(
            title: Text("Security Patch Level",style: TextStyle(color: Colors.white,fontStyle: FontStyle.italic,fontSize: 20),),
            subtitle: Text("1 June 2025"),
            leading: Icon(Icons.security),
          ),
          ListTile(
            title: Text("Build Number",style: TextStyle(color: Colors.white,fontStyle: FontStyle.italic,fontSize: 20),),
            subtitle: Text("CAX999.1.5.9.21"),
            leading: Icon(Icons.code),
          ),
          ListTile(
            title: Text("Kernel Version",style: TextStyle(color: Colors.white,fontStyle: FontStyle.italic,fontSize: 20),),
            subtitle: Text("5.15.92-android"),
            leading: Icon(Icons.memory),
          ),
        ],
      ),
    );
  }

 }


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
        title: const Text("SETTINGS", style: TextStyle(fontWeight: FontWeight.bold)),
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
        padding: EdgeInsets.only(top: 10, left: 16, right: 16, bottom: 16),
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
              onChanged: (value) => setState(() => notificationsEnabled = value),
            ),
            _buildTile(
              icon: Icons.language,
              title: "Language",
              subtitle: "shivam",
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
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: SwitchListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
        secondary: Icon(icon, color: Colors.tealAccent),
        title: Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500)),
        subtitle: Text(subtitle, style: const TextStyle(color: Colors.white70)),
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
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        leading: Icon(icon, color: Colors.tealAccent),
        title: Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500)),
        subtitle: subtitle != null
            ? Text(subtitle, style: const TextStyle(color: Colors.white70))
            : null,
        onTap: onTap,
      ),
    );
  }
}



class Helppage extends StatefulWidget {
  const Helppage({super.key});

  @override
  State<Helppage> createState() => _HelppageState();
}

class _HelppageState extends State<Helppage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(
          "Help & Support",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.deepPurple, Colors.pinkAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      backgroundColor: Colors.black,
      body: Container(
        padding: const EdgeInsets.only(top: kToolbarHeight + 20, left: 16, right: 16, bottom: 16),
        child: ListView(
          children: [
            _buildHelpCard(
              icon: Icons.question_answer_outlined,
              title: "How to use the app?",
              subtitle: "Tap on Next Meme to load memes.\nReact using 😂 or 😒.",
            ),
            _buildHelpCard(
              icon: Icons.favorite,
              title: "How to save favorites?",
              subtitle: "Tap the heart icon 💖 to save memes to your Favorites.",
            ),
            _buildHelpCard(
              icon: Icons.person_outline,
              title: "How to view my profile?",
              subtitle: "Go to the drawer and tap on My Profile.",
            ),
            _buildHelpCard(
              icon: Icons.bug_report_outlined,
              title: "Found a bug or issue?",
              subtitle: "Contact us: help@cardxapp.com",
            ),
            _buildHelpCard(
              icon: Icons.feedback_outlined,
              title: "Want to give feedback?",
              subtitle: "We love your feedback!\nEmail us at: feedback@cardxapp.com",
            ),
            _buildHelpCard(
              icon: Icons.phone_outlined,
              title: "Need more help?",
              subtitle: "Call us at: +91 7895272732",
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHelpCard({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Card(
      color: Colors.white.withOpacity(0.08),
      elevation: 8,
      margin: const EdgeInsets.symmetric(vertical: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: Colors.purpleAccent, size: 28),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      )),
                  const SizedBox(height: 6),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 15,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
