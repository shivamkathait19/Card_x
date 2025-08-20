import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

// ================= Main =================
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

// ================= Make Screen =================
class MakeScreen extends StatefulWidget {
  @override
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

  List<CardData> savedCards = [];
  String imageUrl =
      "https://t3.ftcdn.net/jpg/05/92/76/32/360_F_592763239_V1Bj5YHCIRHreEfYRFwIcVaRBEqcCt1i.jpg";

  bool _wantTaxi = false;
  bool _wantHotel = false;
  bool _wantLunchDinner = false;

  @override
  void initState() {
    super.initState();
    loadSavedCards();
  }

  void loadSavedCards() async {
    final loaded = await CardStorage.loadCards();
    setState(() {
      savedCards = loaded;
    });
  }

  void clearForm() async {
    if (_formKey.currentState!.validate()) {
      String selectedServices = '';
      if (_wantTaxi) selectedServices += 'Taxi ';
      if (_wantHotel) selectedServices += 'Hotel ';
      if (_wantLunchDinner) selectedServices += 'Lunch/Dinner';

      final newCard = CardData(
        name: nameController.text,
        number: numberController.text,
        location: locationController.text,
        duration: durationController.text,
        people: peopleController.text,
        description: descriptionController.text,
        imageUrl: imageUrl,
        serviceOption: selectedServices.trim(),
        createdAt: DateTime.now().toString(),
      );

      savedCards.add(newCard);
      await CardStorage.saveCards(savedCards);

      // Clear form
      nameController.clear();
      numberController.clear();
      locationController.clear();
      durationController.clear();
      peopleController.clear();
      descriptionController.clear();

      setState(() {
        _wantHotel = false;
        _wantTaxi = false;
        _wantLunchDinner = false;
      });

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Fixdetalis(cards: savedCards)),
      );
    }
  }

  Widget _buildField(String label, TextEditingController controller,
      {int maxLines = 1, bool numberOnly = false}) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 6,
        shadowColor: Colors.white,
        title: Text("Make Card"),
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
                backgroundImage: NetworkImage(
                  "https://previews.123rf.com/images/kotangens/kotangens1109/kotangens110900008/10486923-woman-on-top-of-the-mountain-reaches-for-the-sun.jpg",
                ),
              ),
              accountName: Text(
                " Welcome",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              accountEmail: null,
            ),
            ListTile(
              leading: Icon(Icons.save_as_outlined, color: Colors.pinkAccent),
              title: Text(
                "Your card",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontStyle: FontStyle.italic),
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TempCards(cards: savedCards)));
              },
            ),
            ListTile(
              leading: Icon(Icons.credit_card, color: Colors.tealAccent),
              title: Text(
                'View all details',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Fixdetalis(cards: savedCards)),
                );
              },
            ),
          ],
        ),
      ),
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
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(20),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.network(imageUrl,
                              height: 180, width: 500, fit: BoxFit.cover),
                        ),
                        SizedBox(height: 24),
                        Container(
                          padding: EdgeInsets.all(18),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.05),
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                      child: _buildField(
                                          "Enter Name", nameController)),
                                  SizedBox(width: 10),
                                  Expanded(
                                      child: _buildField(
                                          "Gmail/Number", numberController)),
                                ],
                              ),
                              SizedBox(height: 16),
                              _buildField("Location", locationController),
                              SizedBox(height: 16),
                              Row(
                                children: [
                                  Expanded(
                                      child: _buildField("Duration",
                                          durationController,
                                          numberOnly: true)),
                                  SizedBox(width: 10),
                                  Expanded(
                                      child: _buildField("People",
                                          peopleController,
                                          numberOnly: true)),
                                ],
                              ),
                              SizedBox(height: 16),
                              _buildField("Description", descriptionController,
                                  maxLines: 3),
                            ],
                          ),
                        ),
                        SizedBox(height: 24),
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
                                onChanged: (val) =>
                                    setState(() => _wantTaxi = val!),
                                title: Text("Taxi Service",
                                    style: TextStyle(color: Colors.white)),
                              ),
                              CheckboxListTile(
                                value: _wantHotel,
                                onChanged: (val) =>
                                    setState(() => _wantHotel = val!),
                                title: Text("Hotel Booking",
                                    style: TextStyle(color: Colors.white)),
                              ),
                              CheckboxListTile(
                                value: _wantLunchDinner,
                                onChanged: (val) => setState(
                                        () => _wantLunchDinner = val!),
                                title: Text("Lunch/Dinner",
                                    style: TextStyle(color: Colors.white)),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 30),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.deepPurpleAccent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                              padding: EdgeInsets.symmetric(vertical: 14),
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
                            onPressed: clearForm,
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
class TempCards extends StatefulWidget {
  final List<CardData> cards;
  TempCards({required this.cards});

  _TempCardsState createState() => _TempCardsState();
}

class _TempCardsState extends State<TempCards> {
  late List<CardData> localCards;

  @override
  void initState() {
    super.initState();
    localCards = List.from(widget.cards);
  }

  void deleteCard(int index) async {
    setState(() {
      localCards.removeAt(index);
      
    });

    await CardStorage.saveCards(localCards);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text("View Cards")),
      body: localCards.isEmpty
          ? Center(
          child: Text("No cards here",
              style: TextStyle(color: Colors.black)))
          : ListView.builder(
        itemCount: localCards.length,
        itemBuilder: (context, index) {
          final card = localCards[index];
          return Card(
            color: Colors.white,
            elevation: 3,
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(card.imageUrl),
              ),
              title:
              Text(card.name, style: TextStyle(color: Colors.black)),
              subtitle: Text(
                "${card.number}\n${card.location} | ${card.duration} days\nPeople: ${card.people}\nService: ${card.serviceOption}",
                style: TextStyle(color: Colors.grey[800]),
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
class Fixdetalis extends StatefulWidget {
  final List<CardData>? cards;
  Fixdetalis({this.cards});
  _FixdetalisState createState() => _FixdetalisState();
}

class _FixdetalisState extends State<Fixdetalis> {
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Saved Cards",
            style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: cards.isEmpty
          ? Center(
        child: Text("No saved cards",
            style: TextStyle(color: Colors.black87, fontSize: 18)),
      )
          : RefreshIndicator(
        onRefresh: () async => loadCards(),
        child: ListView.builder(
          padding: EdgeInsets.all(16),
          itemCount: cards.length,
          itemBuilder: (context, index) {
            final card = cards[index];
            return Container(
              margin: EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade300,
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
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Divider(color: Colors.black26, thickness: 1),
                    SizedBox(height: 12),
                    _buildDetailRow(
                        Icons.email, "Contact", card.number),
                    _buildDetailRow(
                        Icons.location_on, "Location", card.location),
                    _buildDetailRow(Icons.schedule, "Duration",
                        "${card.duration} days"),
                    _buildDetailRow(
                        Icons.group, "People", card.people),
                    _buildDetailRow(
                        Icons.room_service,
                        "Services",
                        card.serviceOption.isEmpty
                            ? "None"
                            : card.serviceOption),
                    _buildDetailRow(
                        Icons.access_time, "Created", card.createdAt),
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
          Icon(icon, color: Colors.blueGrey[700], size: 20),
          SizedBox(width: 10),
          SizedBox(
            width: 80,
            child: Text(
              "$label:",
              style: TextStyle(
                  color: Colors.black87, fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(color: Colors.black, fontSize: 15),
            ),
          ),
        ],
      ),
    );
  }
}
