import 'dart:math';
import 'package:card_x/main.dart';
import 'package:card_x/mainFile/Barcoms.dart';
import 'package:card_x/mainFile/FetchMemes.dart';
import 'package:flutter/material.dart';
import 'package:card_x/view/LoginScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CardScreen extends StatefulWidget {
  @override
  State<CardScreen> createState() => _CardScreenState();
}

// ================= Global Variables =================
bool isFavorite = false;
String imgUrl = "";
int number = 0;
int target = 10;
bool isLoading = true;
List<String> favorites = []; // ✅ Saved memes list
Color currentBgColor = Color(0xFFF0F2F5);

class _CardScreenState extends State<CardScreen>
    with TickerProviderStateMixin {
  final List<Color> bgColors = [
    Color(0xFFA9A16C),
    Color(0xFF644D4F),
  ];
  List<EmojiParticle> emojiParticles = [];

  @override
  void initState() {
    super.initState();
    loadFavorites(); // ✅ load saved memes
    UpdateImg();
  }

  // ✅ Load favorites from SharedPreferences
  Future<void> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final savedList = prefs.getStringList('favorites') ?? [];
    setState(() {
      favorites = savedList;
    });
  }

  // ✅ Save favorites to SharedPreferences
  Future<void> saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('favorites', favorites);
  }

  Future<void> UpdateImg() async {
    String getImgUrl = await FetchMemes.fetchNewMemes();
    setState(() {
      imgUrl = getImgUrl;
      number++;
      currentBgColor = (bgColors.toList()..shuffle()).first;

      if (number == target) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _showTargetDialog();
        });
        target += 50;
      }
      isLoading = false;
    });
  }

  void _showTargetDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("🎉 Target Achieved!"),
          content: Text(
              "You have seen $number memes!\nNext target: $target memes."),
          actions: [
            TextButton(
                child: Text("Ok"),
                onPressed: () {
                  Navigator.of(context).pop();
                }),
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
      backgroundColor: currentBgColor.withOpacity(0.7),
      appBar: AppBar(
          backgroundColor: Colors.black.withOpacity(0.5),
          title: const Text(
            "Funny Memes",
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          elevation: 3,
          shadowColor: Colors.white,
          automaticallyImplyLeading: true),
      drawer: Drawer(
        backgroundColor: Colors.black,
        shadowColor: Colors.white,
        child: ListView(
          padding: EdgeInsets.zero,
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
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
            ListTile(
                leading: Icon(Icons.favorite),
                title: Text(
                  'Favorite Memes',
                  style: TextStyle(color: Colors.white60),
                ),
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Favoritespage()))),
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
              leading: Icon(Icons.arrow_back),
              title: Text(
                "Home Screen ",
                style: TextStyle(color: Colors.white60),
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Barcoms()));
              },
            ),
            SizedBox(height: 20),
            Center(
              child: Text(
                "Made with ❤️ by Shivam",
                style: TextStyle(color: Colors.grey),
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
      body: Stack(children: [
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Target: ",
                      style:
                      TextStyle(fontSize: 18,color: Colors.black)),
                  Text("$number/$target",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.teal.shade700)),
                ],
              ),
              SizedBox(height: 10),
              AnimatedContainer(
                duration: Duration(milliseconds: 50),
                height: 500,
                width: 700,
                margin: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.0),
                  borderRadius: BorderRadius.circular(20),

                ),
                child: isLoading
                    ? Center(child: CircularProgressIndicator())
                    : ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    imgUrl,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                          child: CircularProgressIndicator());
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
                    onTap: () => showEmojiBurst("🥱"),
                    child: Text("🥱", style: TextStyle(fontSize: 36)),
                  ),
                ],
              ),
              SizedBox(height: 10),

              // ✅ Save Meme Button
              ElevatedButton.icon(
                onPressed: () async {
                  if (imgUrl.isNotEmpty) {
                    setState(() {
                      if (!favorites.contains(imgUrl)) {
                        favorites.add(imgUrl);
                      }
                    });
                    await saveFavorites(); // save permanently
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Meme saved to Favorites!")),
                    );
                  }
                },
                icon: Icon(Icons.favorite, color: Colors.red),
                label: Text("Save Meme"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.red,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 32, vertical: 14),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  textStyle: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),

              SizedBox(height: 10),

              ElevatedButton.icon(
                onPressed: () async {
                  setState(() => isLoading = true);
                  await UpdateImg();
                },
                icon: Icon(Icons.navigate_next),
                label: Text("Next Meme"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 32, vertical: 14),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  textStyle: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
        ...emojiParticles,
      ]),
    );
  }
}

// ================= Emoji Animation Class =================
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

// ================= Favorites Page =================
class Favoritespage extends StatefulWidget {
  Favoritespage({Key? key}) : super(key: key);

  @override
  State<Favoritespage> createState() => _FavoritespageState();
}

class _FavoritespageState extends State<Favoritespage> {
  Future<void> deleteFavorite(int index) async {
    setState(() {
      favorites.removeAt(index);
    });
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('favorites', favorites);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Meme removed from Favorites")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Favorites'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: favorites.isEmpty
          ? Center(
        child: Text(
          "No saved memes yet!",
          style: TextStyle(fontSize: 18, color: Colors.grey[700]),
        ),
      )
          : ListView.builder(
        itemCount: favorites.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.all(10),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15)),
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.network(
                    favorites[index],
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        Center(child: Text("Failed to load image")),
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: CircleAvatar(
                    backgroundColor: Colors.black54,
                    child: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () => deleteFavorite(index),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
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
