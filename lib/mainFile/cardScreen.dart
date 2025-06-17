import 'dart:math';
import 'package:card_x/main.dart';
import 'package:card_x/mainFile/FetchMemes.dart';
import 'package:card_x/mainFile/MainForm.dart';
import 'package:flutter/material.dart';
import 'package:card_x/view/LoginScreen.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
//import 'package:shared_preferences/shared_preferences.dart';

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

 // ✅ Define this at the top of your State class




@override
  void initState() {
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
        backgroundColor: Colors.teal.shade700,
        title: const Text("Funny Memes"),
        centerTitle: true,
        elevation: 5,
        shadowColor: Colors.teal,
        automaticallyImplyLeading: true,
      ),
      drawer: Drawer(
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
              title: Text('Home'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('My Profile'),
              onTap: () {
                Navigator.pop(context);
                _goToBlankPage();
              },
            ),
            ListTile(
              leading: Icon(Icons.favorite),
              title: Text('Favorites'),
              onTap: () {
               Navigator.pop(context);
               Navigator.push(context, MaterialPageRoute(builder: (_)=> Favoritespage(),));
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.info_outline),
              title: Text('About App'),
              onTap: () {
               // Navigator.pop(context);
                //Navigator.push(context, MaterialPageRoute(builder: (_) => AboutAppPage()));
              },
            ),
            ListTile(
              leading: Icon(Icons.help_outline),
              title: Text('Help & Support'),
              onTap:(){},
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
            SizedBox(height: 20),
             AnimatedContainer(
             duration: Duration(milliseconds: 100),
             height: 500,
             width: double.infinity,
             margin: const EdgeInsets.symmetric(horizontal: 20),
             decoration: BoxDecoration(
             color: Colors.white,
             borderRadius: BorderRadius.circular(20),
             boxShadow: const [
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

            SizedBox(height: 20),
            /*ElevatedButton.icon(onPressed: (){}, label: Text("Add to favorite"),icon: Icon(Icons.favorite
            ),
            ),*/
            ElevatedButton.icon(
              icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border, color: Colors.red),
              label: Text(isFavorite ? "Saved" : "Save"),
              onPressed: (){},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                side: BorderSide(color: Colors.redAccent),
              ),
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
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 3)),
          ],
        ),
        child: ListTile(
          leading: Icon(icon, color: Colors.teal, size: 28),
          title: Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.w500,fontStyle: FontStyle.italic),
          ),
          subtitle: Text(
            value ?? 'Not provided',
            style: const TextStyle(color: Colors.black87, fontSize: 16),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
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
          const SizedBox(height: 30),
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
class Favoritespage extends StatelessWidget{
  Favoritespage ({Key? key }) : super (key: key);
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



