import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init(); // Initialize storage
  runApp(MyApp());
}

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

// ================= CardData Model =================
class CardData {
  final String Name;
  final String Number;
  final String location;
  final String duration;
  final String people;
  final String description;
  final String imageUrl;
  final String serviceOption;

  CardData({
    required this.Name,
    required this.Number,
    required this.location,
    required this.duration,
    required this.people,
    required this.description,
    required this.imageUrl,
    required this.serviceOption,
  });

  Map<String, dynamic> toMap() {
    return {
      'Name': Name,
      'Number': Number,
      'location': location,
      'duration': duration,
      'people': people,
      'description': description,
      'imageUrl': imageUrl,
      'serviceOption': serviceOption,
    };
  }

  factory CardData.fromMap(Map<String, dynamic> map) {
    return CardData(
      Name: map['Name'],
      Number: map['Number'],
      location: map['location'],
      duration: map['duration'],
      people: map['people'],
      description: map['description'],
      imageUrl: map['imageUrl'],
      serviceOption: map['serviceOption'],
    );
  }
}

// ================= Make Screen =================
class Makescreen extends StatefulWidget {
  @override
  _MakescreenState createState() => _MakescreenState();
}

class _MakescreenState extends State<Makescreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController NameController = TextEditingController();
  final TextEditingController NumberController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController durationController = TextEditingController();
  final TextEditingController peopleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  List<CardData> savedCards = [];
  final box = GetStorage();

  String imageUrl =
      "https://t3.ftcdn.net/jpg/05/92/76/32/360_F_592763239_V1Bj5YHCIRHreEfYRFwIcVaRBEqcCt1i.jpg";

  bool _wantTaxi = false;
  bool _wantHotel = false;
  bool _wantLunchDinner = false;

  @override
  void initState() {
    super.initState();
    loadCardsFromStorage();
  }

  void saveCardsToStorage() {
    List<Map<String, dynamic>> cardList =
    savedCards.map((card) => card.toMap()).toList();
    box.write('savedCards', cardList);
  }

  void loadCardsFromStorage() {
    List<dynamic>? cardList = box.read('savedCards');
    if (cardList != null) {
      setState(() {
        savedCards = cardList
            .map((map) => CardData.fromMap(Map<String, dynamic>.from(map)))
            .toList();
      });
    }
  }

  void clearForm() {
    if (_formKey.currentState!.validate()) {
      String selectedServices = '';
      if (_wantTaxi) selectedServices += 'Taxi ';
      if (_wantHotel) selectedServices += 'Hotel ';
      if (_wantLunchDinner) selectedServices += 'Lunch/Dinner';

      final newCard = CardData(
        Name: NameController.text,
        Number: NumberController.text,
        location: locationController.text,
        duration: durationController.text,
        people: peopleController.text,
        description: descriptionController.text,
        imageUrl: imageUrl,
        serviceOption: selectedServices.trim(),
      );

      savedCards.add(newCard);
      saveCardsToStorage();

      // Clear input fields
      NameController.clear();
      NumberController.clear();
      locationController.clear();
      durationController.clear();
      peopleController.clear();
      descriptionController.clear();

      setState(() {
        _wantHotel = false;
        _wantTaxi = false;
        _wantLunchDinner = false;
      });

      showDialog(
        context: context,
        builder: (BuildContext Context) {
          return AlertDialog(
            backgroundColor: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            title: Text("Success", style: TextStyle(color: Colors.white)),
            content: Text("Form submitted successfully",
                style: TextStyle(color: Colors.white)),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => HomeScreen(cards: savedCards)),
                  );
                },
                child: Text("OK"),
              )
            ],
          );
        },
      );
    }
  }

  Widget _buildField(String label, TextEditingController controller,
      {int maxLines = 1}) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
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
      appBar: AppBar(
        backgroundColor: Colors.white10,
        elevation: 5,
        leadingWidth: 80,
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
                  backgroundImage: NetworkImage(
                      "https://previews.123rf.com/images/kotangens/kotangens1109/kotangens110900008/10486923-woman-on-top-of-the-mountain-reaches-for-the-sun.jpg"),
                ),
              ),
            ],
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('Make',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple)),
            Text('Card',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.pinkAccent)),
          ],
        ),
      ),
      drawer: Drawer(
        backgroundColor: Colors.black,
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.deepPurple, Colors.pinkAccent],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 35,
                    backgroundImage: NetworkImage(
                        "https://previews.123rf.com/images/kotangens/kotangens1109/kotangens110900008/10486923-woman-on-top-of-the-mountain-reaches-for-the-sun.jpg"),
                    backgroundColor: Colors.white,
                  ),
                  SizedBox(height: 12),
                  Text(
                    NameController.text.isEmpty
                        ? 'Guest User '
                        : NameController.text,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.2,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.person, color: Colors.white),
              title: Text("Profile", style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Profiles()));
              },
            ),
            ListTile(
              leading: Icon(Icons.home, color: Colors.white),
              title: Text('Home', style: TextStyle(color: Colors.white)),
            ),
            ListTile(
              leading: Icon(Icons.card_membership, color: Colors.white),
              title: Text('View card ', style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HomeScreen(cards: savedCards)),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.view_agenda, color: Colors.white),
              title: Text("Save info", style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Viewcards(cards: savedCards)));
              },
            ),
          ],
        ),
      ),
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
                    Expanded(child: _buildField("Enter Name", NameController)),
                    SizedBox(width: 5),
                    Expanded(
                        child: _buildField('Gmail/Number', NumberController)),
                  ],
                ),
                SizedBox(height: 16),
                _buildField('Location', locationController),
                SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(child: _buildField('Duration', durationController)),
                    SizedBox(width: 5),
                    Expanded(child: _buildField('People', peopleController)),
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

// ================= Home Screen =================
class HomeScreen extends StatelessWidget {
  final List<CardData> cards;
  HomeScreen({required this.cards});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: Text("Saved Cards")),
      body: cards.isEmpty
          ? Center(
          child:
          Text("No saved cards", style: TextStyle(color: Colors.white)))
          : ListView.builder(
        itemCount: cards.length,
        itemBuilder: (context, index) {
          final card = cards[index];
          return Card(
            color: Colors.white10,
            child: ListTile(
              leading:
              CircleAvatar(backgroundImage: NetworkImage(card.imageUrl)),
              title:
              Text(card.Name, style: TextStyle(color: Colors.white)),
              subtitle: Text(
                "  ${card.Number}\n${card.location} | ${card.duration} days\nPeople: ${card.people}\nService: ${card.serviceOption}",
                style: TextStyle(color: Colors.grey),
              ),
              isThreeLine: true,
            ),
          );
        },
      ),
    );
  }
}

// ================= View Cards =================
class Viewcards extends StatefulWidget {
  final List<CardData> cards;
  Viewcards({required this.cards});

  @override
  State<Viewcards> createState() => _ViewcardsState();
}

class _ViewcardsState extends State<Viewcards> {
  final box = GetStorage();
  List<CardData> savedCards = [];

  @override
  void initState() {
    super.initState();
    loadCardsFromStorage();
  }

  void loadCardsFromStorage() {
    List<dynamic>? cardList = box.read('savedCards');
    if (cardList != null) {
      setState(() {
        savedCards = cardList
            .map((map) => CardData.fromMap(Map<String, dynamic>.from(map)))
            .toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: Text("View Saved Cards")),
      body: savedCards.isEmpty
          ? Center(
          child:
          Text("No Card saved", style: TextStyle(color: Colors.white)))
          : ListView.builder(
        itemCount: savedCards.length,
        itemBuilder: (context, index) {
          final card = savedCards[index];
          return Card(
            color: Colors.white10,
            child: ListTile(
              leading:
              CircleAvatar(backgroundImage: NetworkImage(card.imageUrl)),
              title:
              Text(card.Name, style: TextStyle(color: Colors.white)),
              subtitle: Text(
                "  ${card.Number}\n${card.location} | ${card.duration} days\nPeople: ${card.people}\nService: ${card.serviceOption}",
                style: TextStyle(color: Colors.grey),
              ),
              isThreeLine: true,
            ),
          );
        },
      ),
    );
  }
}

// ================= Profile Screen =================
class Profiles extends StatefulWidget {
  const Profiles({super.key});

  @override
  State<Profiles> createState() => _ProfilesState();
}

class _ProfilesState extends State<Profiles> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: Center(
        child: Text("Profile Screen", style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
