import 'dart:convert';
import 'package:card_x/main.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:ui';


// ================= Main =================
void main() {
  runApp(MyApp());
}

class Makescreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: MakeScreen(),
    );
  }
}


// ================= CardData Model =================
class CardData {
  final String name;
  final String number;
  final String location;
  final String duration;
  final String people;
  final String description;
  final String imageUrl;
  final String serviceOption;
  final String createdAt;

  CardData({
    required this.name,
    required this.number,
    required this.location,
    required this.duration,
    required this.people,
    required this.description,
    required this.imageUrl,
    required this.serviceOption,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'number': number,
      'location': location,
      'duration': duration,
      'people': people,
      'description': description,
      'imageUrl': imageUrl,
      'serviceOption': serviceOption,
      'createdAt': createdAt,
    };
  }

  factory CardData.fromMap(Map<String, dynamic> map) {
    return CardData(
      name: map['name'],
      number: map['number'],
      location: map['location'],
      duration: map['duration'],
      people: map['people'],
      description: map['description'],
      imageUrl: map['imageUrl'],
      serviceOption: map['serviceOption'],
      createdAt: map['createdAt'],
    );
  }
}

// ================= Storage Helper =================
class CardStorage {
  static const String key = "saved_cards";

  static Future<void> saveCards(List<CardData> cards) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> jsonList =
    cards.map((card) => json.encode(card.toMap())).toList();
    await prefs.setStringList(key, jsonList);
  }

  static Future<List<CardData>> loadCards() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? jsonList = prefs.getStringList(key);

    if (jsonList == null) return [];
    return jsonList
        .map((jsonStr) => CardData.fromMap(json.decode(jsonStr)))
        .toList();
  }
}



// ================= Make Screen =================
class MakeScreen extends StatefulWidget {
  List<CardData> savedCards = [];
  _MakeScreenState createState() => _MakeScreenState();
}

class _MakeScreenState extends State<MakeScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController durationController = TextEditingController();
  final TextEditingController peopleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  String imageUrl =
      "https://t3.ftcdn.net/jpg/05/92/76/32/360_F_592763239_V1Bj5YHCIRHreEfYRFwIcVaRBEqcCt1i.jpg";

  bool _wantTaxi = false;
  bool _wantHotel = false;
  bool _wantLunchDinner = false;

  Widget _buildField(String label, TextEditingController controller,
      {int maxLines = 1, bool numberOnly = false}) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: numberOnly ? TextInputType.number : TextInputType.text,
      style: TextStyle(color: Colors.white, fontSize: 15),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          color: Colors.white70,
          fontSize: 14,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.5,
        ),
        filled: true,
        fillColor: Colors.white.withOpacity(0.08),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      ),
      validator: (value) =>
      value == null || value.isEmpty ? 'Required field' : null,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: Text("Make Card")
      ),
      drawer: Drawer(
        backgroundColor: Colors.black,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.deepPurple, Colors.indigoAccent],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              currentAccountPicture: CircleAvatar(
                radius: 40,
                backgroundImage: NetworkImage(
                  "https://previews.123rf.com/images/kotangens/kotangens1109/kotangens110900008/10486923-woman-on-top-of-the-mountain-reaches-for-the-sun.jpg",
                ),
              ),
              accountName: Text(
                "WELCOME",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              accountEmail: Text(
                "Username@example.com",
                style: TextStyle(color: Colors.white70, fontSize: 14),
              ),
            ),

            // Home
            ListTile(
              leading: Icon(Icons.home_outlined, color: Colors.deepPurpleAccent),
              title: Text(
                'Home',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              onTap: () {},
            ),

            // View Card
            ListTile(
              leading: Icon(Icons.credit_card, color: Colors.tealAccent),
              title: Text(
                'View Card',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HomeScreen(cards: savedCards)),
                );
              },
            ),

            // Save Info
            ListTile(
              leading: Icon(Icons.save_as_outlined, color: Colors.pinkAccent),
              title: Text(
                "Save Info",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ViewCards(cards: savedCards)));
              },
            ),

            Divider(color: Colors.white24, thickness: 1, indent: 16, endIndent: 16),

          ],
        ),
      ),
      // Premium gradient background
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF1A1A2E), Color(0xFF16213E), Color(0xFF0F3460)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Custom AppBar
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.deepPurple, Colors.indigoAccent],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.4),
                      blurRadius: 6,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Icon(Icons.create, color: Colors.white),
                    SizedBox(width: 10),
                    Text(
                      "Create Your Card",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.6,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),

              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(20),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.network(imageUrl, height: 180, fit: BoxFit.cover),
                        ),
                        SizedBox(height: 24),

                        // Form fields grouped inside card
                        Container(
                          padding: EdgeInsets.all(18),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.05),
                            borderRadius: BorderRadius.circular(18),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                blurRadius: 8,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(child: _buildField("Enter Name", nameController)),
                                  SizedBox(width: 10),
                                  Expanded(child: _buildField("Gmail/Number", numberController)),
                                ],
                              ),
                              SizedBox(height: 16),
                              _buildField("Location", locationController),
                              SizedBox(height: 16),
                              Row(
                                children: [
                                  Expanded(child: _buildField("Duration", durationController, numberOnly: true)),
                                  SizedBox(width: 10),
                                  Expanded(child: _buildField("People", peopleController, numberOnly: true)),
                                ],
                              ),
                              SizedBox(height: 16),
                              _buildField("Description", descriptionController, maxLines: 3),
                            ],
                          ),
                        ),

                        SizedBox(height: 24),

                        // Service options checkboxes
                        Container(
                          padding: EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.04),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Column(
                            children: [
                              CheckboxListTile(
                                value: _wantTaxi,
                                onChanged: (val) => setState(() => _wantTaxi = val!),
                                title: Text("Taxi Service", style: TextStyle(color: Colors.white)),
                                activeColor: Colors.deepPurple,
                                checkColor: Colors.white,
                              ),
                              CheckboxListTile(
                                value: _wantHotel,
                                onChanged: (val) => setState(() => _wantHotel = val!),
                                title: Text("Hotel Booking", style: TextStyle(color: Colors.white)),
                                activeColor: Colors.deepPurple,
                                checkColor: Colors.white,
                              ),
                              CheckboxListTile(
                                value: _wantLunchDinner,
                                onChanged: (val) => setState(() => _wantLunchDinner = val!),
                                title: Text("Lunch/Dinner", style: TextStyle(color: Colors.white)),
                                activeColor: Colors.deepPurple,
                                checkColor: Colors.white,
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: 30),

                        // Submit Button
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.deepPurpleAccent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                              padding: EdgeInsets.symmetric(vertical: 14),
                              elevation: 6,
                            ),
                            icon: Icon(Icons.check, color: Colors.white),
                            label: Text(
                              "Submit Card",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 1,
                                color: Colors.white,
                              ),
                            ),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                // TODO: Call your save logic here
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("Card Submitted!")),
                                );
                              }
                            },
                          ),
                        ),
                      ],
                    ),
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

// ================= View Cards =================
class ViewCards extends StatefulWidget {
  final List<CardData> cards;
  ViewCards({required this.cards});

  @override
  _ViewCardsState createState() => _ViewCardsState();
}

class _ViewCardsState extends State<ViewCards> {
  late List<CardData> localCards;

  @override
  void initState() {
    super.initState();
    // Copy original cards → local list
    localCards = List.from(widget.cards);
  }

  void deleteCard(int index) {
    setState(() {
      localCards.removeAt(index); // Sirf local list se remove karo
    });
    // ⚠️ Storage se delete mat karo!
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: Text("View Cards")),
      body: localCards.isEmpty
          ? Center(
          child: Text("No cards here", style: TextStyle(color: Colors.white)))
          : ListView.builder(
        itemCount: localCards.length,
        itemBuilder: (context, index) {
          final card = localCards[index];
          return Card(
            color: Colors.white10,
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(card.imageUrl),
              ),
              title: Text(card.name, style: TextStyle(color: Colors.white)),
              subtitle: Text(
                "${card.number}\n${card.location} | ${card.duration} days\nPeople: ${card.people}\nService: ${card.serviceOption}",
                style: TextStyle(color: Colors.grey),
              ),
              trailing: IconButton(
                icon: Icon(Icons.delete, color: Colors.red),
                onPressed: () => deleteCard(index),
              ),
            ),
          );
        },
      ),
    );
  }
}



// ================== HomeScreen ==================
class HomeScreen extends StatefulWidget {
  final List<CardData>? cards;
  HomeScreen ({this.cards});
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<CardData> cards = [];

  @override
  void initState() {
    super.initState();
    loadCards();
  }

  void loadCards() async {
    final loaded = await CardStorage.loadCards();
    setState(() {
      cards = loaded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Saved Cards", style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        elevation: 0,
      ),
      body: cards.isEmpty
          ? Center(
        child: Text(
          "No saved cards",
          style: TextStyle(color: Colors.white70, fontSize: 18),
        ),
      )
          : RefreshIndicator( // 🔄 Add pull-to-refresh
        onRefresh: () async => loadCards(),
        child: ListView.builder(
          padding: EdgeInsets.all(16),
          itemCount: cards.length,
          itemBuilder: (context, index) {
            final card = cards[index];
            return Container(
              margin: EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 6,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 28,
                          backgroundImage: NetworkImage(card.imageUrl),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: Text(
                            card.name,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Divider(color: Colors.white24, thickness: 1),
                    SizedBox(height: 12),
                    _buildDetailRow(Icons.email, "Contact", card.number),
                    _buildDetailRow(Icons.location_on, "Location", card.location),
                    _buildDetailRow(Icons.schedule, "Duration", "${card.duration} days"),
                    _buildDetailRow(Icons.group, "People", card.people),
                    _buildDetailRow(Icons.room_service, "Services",
                        card.serviceOption.isEmpty ? "None" : card.serviceOption),
                    _buildDetailRow(Icons.access_time, "Created", card.createdAt),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.blueGrey[200], size: 20),
          SizedBox(width: 10),
          SizedBox(
            width: 80,
            child: Text(
              "$label:",
              style: TextStyle(color: Colors.white70, fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(color: Colors.white, fontSize: 15),
            ),
          ),
        ],
      ),
    );
  }
}