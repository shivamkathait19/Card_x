import 'dart:convert';
import 'package:card_x/main.dart';
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
        MaterialPageRoute(builder: (context) => ViewCards()),
      );
    }
  }

  Widget _buildField(String label, TextEditingController controller,
      {int maxLines = 1, bool numberOnly = false}) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: numberOnly ? TextInputType.number : TextInputType.text,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
            color: Colors.white, fontStyle: FontStyle.italic, fontSize: 15),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.blue)),
        filled: true,
        fillColor: Colors.white.withOpacity(0.10),
      ),
      style: TextStyle(color: Colors.white),
      validator: (value) =>
      value == null || value.isEmpty ? 'Required field' : null,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: Text("Make Card")),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image.network(imageUrl),
                SizedBox(height: 19),
                Row(
                  children: [
                    Expanded(child: _buildField("Enter Name", nameController)),
                    SizedBox(width: 5),
                    Expanded(child: _buildField('Gmail/Number', numberController)),
                  ],
                ),
                SizedBox(height: 16),
                _buildField('Location', locationController),
                SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                        child: _buildField('Duration', durationController,
                            numberOnly: true)),
                    SizedBox(width: 5),
                    Expanded(
                        child: _buildField('People', peopleController,
                            numberOnly: true)),
                  ],
                ),
                SizedBox(height: 10),
                _buildField('Description', descriptionController, maxLines: 2),
                SizedBox(height: 24),
                CheckboxListTile(
                  title: Text("Want a taxi for travelling",
                      style: TextStyle(color: Colors.white)),
                  value: _wantTaxi,
                  onChanged: (bool? value) {
                    setState(() {
                      _wantTaxi = value!;
                    });
                  },
                ),
                CheckboxListTile(
                  title: Text("Want a hotel",
                      style: TextStyle(color: Colors.white)),
                  value: _wantHotel,
                  onChanged: (bool? value) {
                    setState(() {
                      _wantHotel = value!;
                    });
                  },
                ),
                CheckboxListTile(
                  title: Text("Lunch/dinner",
                      style: TextStyle(color: Colors.white)),
                  value: _wantLunchDinner,
                  onChanged: (bool? value) {
                    setState(() {
                      _wantLunchDinner = value!;
                    });
                  },
                ),
                ElevatedButton.icon(
                  onPressed: clearForm,
                  icon: Icon(Icons.check, color: Colors.black),
                  label: Text("SUBMIT CARD",
                      style: TextStyle(color: Colors.black)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ================= View Cards =================
class ViewCards extends StatefulWidget {
  @override
  _ViewCardsState createState() => _ViewCardsState();
}

class _ViewCardsState extends State<ViewCards> {
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

  void deleteCard(int index) async {
    setState(() {
      cards.removeAt(index);
    });
    await CardStorage.saveCards(cards);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: Text("Saved Cards")),
      body: cards.isEmpty
          ? Center(
          child: Text("No saved cards",
              style: TextStyle(color: Colors.white, fontSize: 18)))
          : ListView.builder(
        padding: EdgeInsets.all(10),
        itemCount: cards.length,
        itemBuilder: (context, index) {
          final card = cards[index];
          return Card(
            margin: EdgeInsets.symmetric(vertical: 10),
            color: Colors.white10,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15)),
            child: ListTile(
              contentPadding:
              EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              leading: CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(card.imageUrl),
              ),
              title: Text(
                card.name,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Text(
                  "${card.number}\n📍 ${card.location} | ⏳ ${card.duration} days\n👥 People: ${card.people}\n🍴 Service: ${card.serviceOption}\n🕒 Created: ${card.createdAt}",
                  style: TextStyle(color: Colors.grey[400], height: 1.4),
                ),
              ),
              trailing: IconButton(
                icon: Icon(Icons.delete, color: Colors.red),
                onPressed: () => deleteCard(index),
              ),
              isThreeLine: true,
            ),
          );
        },
      ),
    );
  }
}
