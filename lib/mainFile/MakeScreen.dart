import 'dart:convert';
import 'package:card_x/mainFile/Barcoms.dart';
import 'package:card_x/mainFile/cardScreen.dart';
import 'package:flutter/foundation.dart';
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
  final bool isEdited;

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
    this.isEdited = false,
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
       'isEdited' :isEdited,
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
      isEdited: map['isEdited'] ?? false,
    );
  }
}

// ================= Storage Helper =================
class CardStorage {


  static const String key = "saved_cards";
  static const String fixDetailsKey = "fixdetails";
  static const String tempCardsKey = "tempcards";


  static Future<void> saveFixDetails(List<CardData> cards) async {
    final prefs = await SharedPreferences.getInstance();
    final data = cards.map((c) => c.toMap()).toList();
    prefs.setString(fixDetailsKey, jsonEncode(data));
  }

  static Future<List<CardData>> loadFixDetails() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(fixDetailsKey);
    if (data == null) return [];
    final List decoded = jsonDecode(data);
    return decoded.map((e) => CardData.fromMap(e)).toList();
  }

  // TempCards save/load
  static Future<void> saveTempCards(List<CardData> cards) async {
    final prefs = await SharedPreferences.getInstance();
    final data = cards.map((c) => c.toMap()).toList();
    prefs.setString(tempCardsKey, jsonEncode(data));
  }

  static Future<List<CardData>> loadTempCards() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(tempCardsKey);
    if (data == null) return [];
    final List decoded = jsonDecode(data);
    return decoded.map((e) => CardData.fromMap(e)).toList();
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
    final loaded = await CardStorage.loadFixDetails();
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
     await CardStorage.saveFixDetails(savedCards);
     List<CardData> temp  = await CardStorage.loadTempCards();
     temp.add(newCard);
     await CardStorage.saveTempCards(temp);
     //await CardStorage.fixDetailsKey(savedCards);


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
         // borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white10,width:3),
          borderRadius: BorderRadius.circular(14)

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
                        builder: (context) => TempCards()));
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
                                         /* if (!RegExp(r'^[a-zA-Z0-9._%+-]+@gmail\.com$').hasMatch(value)) {
                                            return 'Please enter a valid Gmail address';
                                          }*/
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
                                title: Text("Room Service",
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
    final loaded = await CardStorage.loadFixDetails();
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


class TempCards extends StatefulWidget {
  const TempCards({super.key});

  @override
  State<TempCards> createState() => _TempCardsState();
}

class _TempCardsState extends State<TempCards> {
  List<CardData> localCards = [];


  @override
  void initState() {
    super.initState();
    loadTemp();
  }

  Future<void> loadTemp() async {
    localCards = await CardStorage.loadTempCards();
    setState(() {});
  }

  void deleteCard(int index) async {
    setState(() {
      localCards.removeAt(index);
    });
    await CardStorage.saveTempCards(localCards);
   // await CardStorage.saveDeletedCard(removedcard);
  }

  /// ✅ Ye function TempCards + FixDetails dono ko update karega
  /*Future<void> updateCard(int index, CardData updatedCard) async {
    setState(() {
      localCards[index] = updatedCard;
    });
    await CardStorage.saveTempCards(localCards);

    // ✅ Permanent (FixDetails) update bhi
    List<CardData> fixCards = await CardStorage.loadFixDetails();
    if (index < fixCards.length) {
      fixCards[index] = updatedCard;
      await CardStorage.saveFixDetails(fixCards);

    }
  }*/
  Future<void> updateCards(int index,CardData updatedCard)async{
    final newCard = CardData(
      name: updatedCard.name,
      Gmail: updatedCard.Gmail,
      location: updatedCard.location,
      duration: updatedCard.duration,
      people: updatedCard.people,
      imageUrl: updatedCard.imageUrl,
      description: updatedCard.description,
      serviceOption: updatedCard.serviceOption,
      createdAt: updatedCard.createdAt,
      isEdited: true,   // ✅ mark as edited
    );

    setState(() {
      localCards.removeAt(index);
     localCards[index] = newCard;
      // localCards.insert(index,newCard);
    });
    await CardStorage.saveTempCards(localCards);




    List<CardData> fixCards = await CardStorage.loadFixDetails();
    if (index < fixCards.length) {
      fixCards[index]=newCard;
      //fixCards.removeAt(index);
    }
    fixCards.add(updatedCard);
    await CardStorage.saveFixDetails(fixCards);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cards"),
      ),
      body: localCards.isEmpty
          ? Center(
        child: Text("No cards saved yet"),
      )
     : ListView.builder(
        itemCount: localCards.length,
        itemBuilder: (context, index) {
          final card = localCards[index];
          return Card(
            margin: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ✅ Number hamesha dikhana
                Container(
                  width: double.infinity,
                  color: Colors.grey[200],
                  padding: EdgeInsets.all(8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${index + 1}.",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      // ✅ Sirf Edited Card ke liye text
                      if (card.isEdited)
                        Text(
                          "Edited Card",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.orange,
                            fontSize: 16,
                          ),
                        ),
                    ],
                  ),
                ),

                // ✅ Card Details
                ListTile(
                 leading: CircleAvatar(
                   backgroundImage: NetworkImage(""),
                 ),
                  title: Text(card.name),
              subtitle:Text(
                "${card.Gmail}\n${card.location} | ${card.duration} days\nPeople: ${card.people}\nService: ${card.serviceOption}", style: TextStyle(color: Colors.white70, fontSize: 13),
              ),
                  trailing: PopupMenuButton<String>(
                    onSelected: (value){
                      if( value == 'edit '){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>
                        EditPages(card: localCards[index], index: index, onUpdate: (updateCard) async{
                          await updateCards(index,updateCard);
                        }

                        )
                        ));
                      }else if (value == 'delete'){
                        deleteCard(index);

                      }
                    },itemBuilder: (context)=>[
                      PopupMenuItem(value: 'edit', child: Text("Edit"),),
                    //PopupMenuItem(value:'Delete', Text("Delete"))
                  ],
                  ),
                ),
              ],
            ),
          );
        },
      )

    );
  }
}

class EditPages extends StatefulWidget {
  final CardData card;
  final int index;
 // final Function(CardData) onUpdate;
  final Future<void>Function(CardData) onUpdate;


  EditPages({
    Key?key,
    required this.card,
    required this.index,
    required this.onUpdate,
}) :super(key: key);

  //EditPages({required this.card, required this.index, required this.onUpdate});

  @override
  State<EditPages> createState() => _EditPagesState();
}

class _EditPagesState extends State<EditPages> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController nameController;
  late TextEditingController gmailController;
  late TextEditingController locationController;
  late TextEditingController durationController;
  late TextEditingController peopleController;
  late TextEditingController descriptionController;
  late TextEditingController serviceOptionController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.card.name);
    gmailController = TextEditingController(text: widget.card.Gmail);
    locationController = TextEditingController(text: widget.card.location);
    durationController = TextEditingController(text: widget.card.duration);
    peopleController = TextEditingController(text: widget.card.people);
    descriptionController = TextEditingController(text: widget.card.description);
    serviceOptionController =
        TextEditingController(text: widget.card.serviceOption);

  }

  void saveEdits() {
    if (_formKey.currentState!.validate(
    )) {
      final updatedCard = CardData(
        name: nameController.text,
        Gmail: gmailController.text,
        location: locationController.text,
        duration: durationController.text,
        people: peopleController.text,
        description: descriptionController.text,
        imageUrl: widget.card.imageUrl,
        serviceOption: serviceOptionController.text, // ✅ Fix
        createdAt: widget.card.createdAt,
      );

      widget.onUpdate(updatedCard); // callback call
      Navigator.pop(context); // list page par wapas
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Edit Card")),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16),
          children: [
            TextFormField(
                controller: nameController,
                decoration: InputDecoration(labelText: "Name")),
            TextFormField(
                controller: gmailController,
                decoration: InputDecoration(labelText: "Gmail")),
            TextFormField(
                controller: locationController,
                decoration: InputDecoration(labelText: "Location")),
            TextFormField(
                controller: durationController,
                decoration: InputDecoration(labelText: "Duration")),
            TextFormField(
                controller: peopleController,
                decoration: InputDecoration(labelText: "People")),
            TextFormField(
                controller: descriptionController,
                decoration: InputDecoration(labelText: "Description")),
            TextFormField(
                controller: serviceOptionController,
                decoration: InputDecoration(labelText: "Service Option")),

            SizedBox(height: 20),
        ElevatedButton(
          onPressed: () async {
            CardData updatedCard = CardData(
              name: nameController.text,
              Gmail: gmailController.text,
              location: locationController.text,
              duration: durationController.text,
              people: peopleController.text,
              description: descriptionController.text,
              serviceOption: serviceOptionController.text,
              imageUrl: widget.card.imageUrl,
              createdAt: DateTime.now().toString(),

              isEdited: true, // mark as edited
            );
          //  await CardStorage.updateCard(widget.index, updatedCard);
              await widget.onUpdate(updatedCard);
              Navigator.pop(context);
          },
          child: const Text("Save Changes"),),
          ],
        ),
      ),
    );
  }
}
