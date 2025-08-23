import 'dart:convert';
import 'package:card_x/mainFile/Barcoms.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ================= CardData Model =================


class CardData {
  final String name;

  final String Gmail;
  final String location;
  final String duration;
  final String people;
  final String description;
  final String imageUrl;
  final String serviceOption;
  final String createdAt;

  CardData({

    required this.name,
    required this.Gmail,
    required this.location,
    required this.duration,
    required this.people,
    required this.description,
    required this.imageUrl,
    required this.serviceOption,
    required this.createdAt,
  });

  Map<String, dynamic> toMap(){
    return {
      'name': name,
      'number': Gmail,
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
      Gmail: map['number'],
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


  /*Future<void>saveCardsToPrefs(List<CardData>cards)async{
    final prefs = await SharedPreferences.getInstance();
    List<String> jsonCards =
        cards.map((card)=> jsonEncode(card.toJson())).toList();
    await prefs.setStringList("savedCards", jsonCards);
  }
*/
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
/*Future<void> loadCardsFromPrefs() async {
  final prefs = await SharedPreferences.getInstance();
  List<String>? jsonCards = prefs.getStringList("savedCards");

  if (jsonCards != null) {
    setState(() {
      localCards = jsonCards
          .map((card) => CardData.fromJson(jsonDecode(card)))
          .toList();
    });
  }
}
*/
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
  final TextEditingController GmailController = TextEditingController();
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
        Gmail: GmailController.text,
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
      GmailController.clear();
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
      validator: (value){
        if(value == null || value.isEmpty)
          return "Enter a full details";
      }
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

            ListTile(
              leading: Icon(Icons.save_as_outlined, color: Colors.pinkAccent),
              title: Text(
                "Help and support",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontStyle: FontStyle.italic),
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Helpsupprot()));
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.arrow_back, color: Colors.pinkAccent),
              title: Text(
                "Home Screen ",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontStyle: FontStyle.italic),
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Barcoms()));
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
                                      child:TextFormField(
                                        controller: GmailController,
                                       // obscureText: true,
                                        style: TextStyle(color: Colors.white,fontSize: 16),
                                        decoration: InputDecoration(
                                          labelText: 'Gmail',
                                          labelStyle: TextStyle(color: Colors.white,fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            letterSpacing: 0.5,),
                                          filled: true,
                                          fillColor: Colors.white70.withOpacity(0.08),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(14),
                                            borderSide: BorderSide.none,
                                        ),
                                          ),
                                        validator: (value){
                                          if(value == null || value.isEmpty){
                                            return " Please enter the gmail";
                                          }
                                          if(!value.endsWith('@gmail.com')){
                                            return "enter valid gmail";
                                          }
                                        },
                                  ),
                                  ),
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
                                      child:TextFormField (
                                        controller: peopleController,
                                        //obscureText: true,
                                        decoration: InputDecoration(
                                            labelText: "People",
                                          labelStyle: TextStyle(
                                            color: Colors.white,fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            letterSpacing: 0.5,
                                          ),
                                          filled: true,
                                            fillColor: Colors.white.withOpacity(0.08),
                                           // focusColor: Colors.white.withOpacity(0.08),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(14),
                                            borderSide: BorderSide.none
                                          )
                                        ),
                                        keyboardType: TextInputType.number,
                                        inputFormatters: [
                                          FilteringTextInputFormatter.digitsOnly
                                        ],
                                      ),
                                  )
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
                              backgroundColor: Colors.black54,
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

    // ✅ Snackbar confirmation
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Card deleted successfully")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'View ',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple),
            ),
            Text(
              'Card',
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.pinkAccent),
            ),
          ],
        ),
      ),
      body: localCards.isEmpty
          ? Center(
          child: Text("No cards here",
              style: TextStyle(color: Colors.black)))
          : ListView.builder(
        itemCount: localCards.length,
        itemBuilder: (context, index) {
          final card = localCards[index];
          return Card(
            color: Colors.black.withOpacity(0.50),
            elevation: 3,
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(card.imageUrl),
              ),
              title: Text(card.name,
                  style: TextStyle(
                      color: Colors.brown,
                      fontWeight: FontWeight.bold)),
              subtitle: Text(
                "${card.Gmail}\n${card.location} | ${card.duration} days\nPeople: ${card.people}\nService: ${card.serviceOption}",
                style: TextStyle(
                  color: Colors.white.withOpacity(0.5),
                  fontStyle: FontStyle.italic,
                ),
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
                        Icons.email, "Contact", card.Gmail),
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



class Helpsupprot extends StatefulWidget {
  final List<CardData>? cards; // ✅ cards optional rakha
  Helpsupprot({this.cards, super.key});

  @override
  State<Helpsupprot> createState() => _HelpsupprotState();
}

class _HelpsupprotState extends State<Helpsupprot> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Help & Support"),
        centerTitle: true,
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          // ================= How to use section =================
          Text(
            "📖 How to use this app",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 12),
          _buildGuideStep(
            step: "1",
            title: "Create a Card",
            description:
            "Go to 'Make Card' option in the drawer. Fill in your details such as name, number, location, and description, then press 'Submit Card'.",
          ),
          _buildGuideStep(
            step: "2",
            title: "View Your Cards",
            description:
            "Check all cards you created by going to 'View All Details'. You can see your saved cards with full details.",
          ),
          _buildGuideStep(
            step: "3",
            title: "Temporary Cards",
            description:
            "Go to 'Your Card' to see temporary saved cards. You can also delete a card from here.",
          ),
          _buildGuideStep(
            step: "4",
            title: "Edit or Update",
            description:
            "Currently, editing is limited. If you want to change details, you can delete the card and create a new one.",
          ),
          _buildGuideStep(
            step: "5",
            title: "Support",
            description:
            "If you face any issue, use the below contact options to reach us.",
          ),

          SizedBox(height: 24),
          Divider(color: Colors.white54),

          // ================= Contact section =================
          Text(
            "☎️ Contact Options",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 12),

          Card(
            color: Colors.deepPurple.withOpacity(0.2),
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            child: ListTile(
              leading: Icon(Icons.email, color: Colors.pinkAccent),
              title: Text("Contact via Email",
                  style: TextStyle(color: Colors.white)),
              subtitle: Text("support@cardx.com",
                  style: TextStyle(color: Colors.white70)),
              onTap: () {
                print("Open Email app here (use url_launcher)");
              },
            ),
          ),
          SizedBox(height: 12),
          Card(
            color: Colors.teal.withOpacity(0.2),
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            child: ListTile(
              leading: Icon(Icons.phone, color: Colors.tealAccent),
              title: Text("Call Support", style: TextStyle(color: Colors.white)),
              subtitle: Text("+91 9876543210",
                  style: TextStyle(color: Colors.white70)),
              onTap: () {
                print("Dial number here (use url_launcher)");
              },
            ),
          ),
          SizedBox(height: 12),
          Card(
            color: Colors.green.withOpacity(0.2),
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            child: ListTile(
              leading: Icon(Icons.message, color: Colors.greenAccent),
              title:
              Text("WhatsApp Chat", style: TextStyle(color: Colors.white)),
              subtitle: Text("Chat with us on WhatsApp",
                  style: TextStyle(color: Colors.white70)),
              onTap: () {
                print("Open WhatsApp here (use url_launcher)");
              },
            ),
          ),
          SizedBox(height: 12),
          Card(
            color: Colors.blue.withOpacity(0.2),
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            child: ListTile(
              leading: Icon(Icons.info, color: Colors.blueAccent),
              title: Text("About App", style: TextStyle(color: Colors.white)),
              subtitle: Text("Learn more about CardX",
                  style: TextStyle(color: Colors.white70)),
              onTap: () {
                showAboutDialog(
                  context: context,
                  applicationName: "CardX",
                  applicationVersion: "1.0.0",
                  applicationIcon: Icon(Icons.credit_card),
                  children: [
                    Text(
                        "This app helps you create, save, and manage your cards easily."),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // helper widget to show steps
  Widget _buildGuideStep({
    required String step,
    required String title,
    required String description,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.08),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: Colors.deepPurpleAccent,
            child: Text(step,
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold)),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
                SizedBox(height: 6),
                Text(description,
                    style: TextStyle(color: Colors.white70, fontSize: 14)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
