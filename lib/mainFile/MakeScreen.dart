import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: Makescreen(),
    );
  }
}

class CardData {
  final String text;
  final String location;
  final String duration;
  final String people;
  final String description;
  final String imageUrl;

  CardData({
    required this.text,
    required this.location,
    required this.duration,
    required this.people,
    required this.description,
    required this.imageUrl,
  });

  Map<String, dynamic> toJson() => {
    'text': text,
    'location': location,
    'duration': duration,
    'people': people,
    'description': description,
    'imageUrl': imageUrl,
  };

  factory CardData.fromJson(Map<String, dynamic> json) => CardData(
    text: json['text'],
    location: json['location'],
    duration: json['duration'],
    people: json['people'],
    description: json['description'],
    imageUrl: json['imageUrl'],
  );
}

class Makescreen extends StatefulWidget {
  @override
  _MakescreenState createState() => _MakescreenState();
}

class _MakescreenState extends State<Makescreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController textController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController durationController = TextEditingController();
  final TextEditingController peopleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  String imageUrl =
      "https://t3.ftcdn.net/jpg/05/92/76/32/360_F_592763239_V1Bj5YHCIRHreEfYRFwIcVaRBEqcCt1i.jpg";

  void saveCard() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> cards = prefs.getStringList('cards') ?? [];

    CardData newCard = CardData(
      text: textController.text,
      location: locationController.text,
      duration: durationController.text,
      people: peopleController.text,
      description: descriptionController.text,
      imageUrl: imageUrl,
    );

    cards.add(jsonEncode(newCard.toJson()));
    await prefs.setStringList('cards', cards);

    // Clear fields after saving
    textController.clear();
    locationController.clear();
    durationController.clear();
    peopleController.clear();
    descriptionController.clear();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Card Saved!")),
    );
  }

  void goToHome() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.white10,
        elevation: 5,
        leadingWidth: 100,
        leading: Builder(
          builder: (context) => Row(
            children: [
              IconButton(
                icon: Icon(Icons.menu, color: Colors.white),
                onPressed: () => Scaffold.of(context).openDrawer(),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 0),
                child: CircleAvatar(
                  radius: 16,
                  backgroundImage: AssetImage("assets/avatar-png.jpg"),
                ),
              ),
            ],
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('Make', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.deepPurple)),
            Text('Card', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.pinkAccent)),
          ],
        ),
      ),
      drawer: Drawer(
        backgroundColor: Colors.black,
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [Colors.deepPurple, Colors.pinkAccent]),
              ),
              child: Text('Menu', style: TextStyle(color: Colors.white, fontSize: 24)),
            ),
            ListTile(
              leading: Icon(Icons.home, color: Colors.white),
              title: Text('Home', style: TextStyle(color: Colors.white)),
              onTap: goToHome,
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(25),
          ),
          padding: EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Image.network(imageUrl),
                  SizedBox(height: 19),
                  _buildField('Text', textController),
                  SizedBox(height: 16),
                  _buildField('Location', locationController),
                  SizedBox(height: 16),
                  _buildField('Duration', durationController),
                  SizedBox(height: 16),
                  _buildField('People', peopleController),
                  SizedBox(height: 16),
                  _buildField('Description', descriptionController, maxLines: 2),
                  SizedBox(height: 24),
                  ElevatedButton.icon(
                    onPressed: saveCard,
                    icon: Icon(Icons.save, color: Colors.black),
                    label: Text("SAVE CARD", style: TextStyle(color: Colors.black)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.withOpacity(0.6),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 14),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildField(String label, TextEditingController controller, {int maxLines = 1}) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.white, fontStyle: FontStyle.italic, fontSize: 15),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        filled: true,
        fillColor: Colors.white10,
      ),
      style: TextStyle(color: Colors.white),
    );
  }
}

class HomeScreen extends StatelessWidget {
  Future<List<CardData>> loadCards() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> cardsJson = prefs.getStringList('cards') ?? [];
    return cardsJson.map((card) => CardData.fromJson(jsonDecode(card))).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Saved Cards"),
      ),
      body: FutureBuilder<List<CardData>>(
        future: loadCards(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
          final cards = snapshot.data!;
          if (cards.isEmpty) return Center(child: Text("No cards saved", style: TextStyle(color: Colors.white)));
          return ListView.builder(
            itemCount: cards.length,
            itemBuilder: (context, index) {
              final card = cards[index];
              return Card(
                color: Colors.white10,
                margin: EdgeInsets.all(10),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                child: ListTile(
                  contentPadding: EdgeInsets.all(10),
                  leading: Image.network(card.imageUrl, width: 60, height: 60, fit: BoxFit.cover),
                  title: Text(card.text, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  subtitle: Text(card.description, style: TextStyle(color: Colors.white70)),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
