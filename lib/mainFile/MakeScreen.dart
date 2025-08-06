import 'package:flutter/material.dart';

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
}

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

  String imageUrl =
      "https://t3.ftcdn.net/jpg/05/92/76/32/360_F_592763239_V1Bj5YHCIRHreEfYRFwIcVaRBEqcCt1i.jpg";
  bool _wantTaxi = false;
  bool _wantHotel = false;
  bool _wantiunch$dinner = false;

  void clearForm() {
    if (_formKey.currentState!.validate()) {
      String selectedServices = '';
      if (_wantTaxi) selectedServices += 'Taxi ';
      if (_wantHotel) selectedServices += 'Hotel ';
      if (_wantiunch$dinner) selectedServices += 'Lunch/Dinner';

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

      NameController.clear();
      NumberController.clear();
      locationController.clear();
      durationController.clear();
      peopleController.clear();
      descriptionController.clear();

      setState(() {
        _wantHotel = false;
        _wantTaxi = false;
        _wantiunch$dinner = false;
      });

      showDialog(context: context, builder: (BuildContext Context){
        return AlertDialog(
          backgroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ) ,
          title: Text("Succes"),
          content: Text("Form submitted successfully "),
          actions: [
            TextButton(onPressed: (){
              Navigator.of(context).pop();
              Navigator.push(context, MaterialPageRoute(builder: (context)=> HomeScreen(cards: savedCards)) )
            }, child: Text("okk"))
          ],
        )
      })

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen(cards: savedCards)),
      );
    }
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
                    backgroundImage: NetworkImage("https://previews.123rf.com/images/kotangens/kotangens1109/kotangens110900008/10486923-woman-on-top-of-the-mountain-reaches-for-the-sun.jpg"),
                      backgroundColor: Colors.white,
                  ),
                  SizedBox(height: 12),
                  Text(
                    NameController.text.isEmpty ? 'Guest User ' : NameController.text,
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
             leading: Icon(Icons.home,color: Colors.white,),title:
             Text('Home',style: TextStyle(color: Colors.white),),


           ),
            ListTile(
              leading: Icon(Icons.details ,color: Colors.white),
              title: Text('Save details', style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HomeScreen(cards: savedCards)),
                );
              },
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
                  Row(
                    children: [
                      Expanded(
                          child: _buildField("Enter Name", NameController)),
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
                      Expanded(
                          child: _buildField('Duration', durationController)),
                      SizedBox(width: 5),
                      Expanded(child: _buildField('People', peopleController)),
                    ],
                  ),
                  SizedBox(height: 10),
                  _buildField('Description', descriptionController, maxLines: 2),
                  SizedBox(height: 24),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Select Extra Services:',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 8),
                  CheckboxListTile(
                    title: Text("Want a taxi for travelling",
                        style: TextStyle(
                            color: Colors.white,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w500)),
                    value: _wantTaxi,
                    activeColor: Colors.blue,
                    onChanged: (bool? value) {
                      setState(() {
                        _wantTaxi = value!;
                      });
                    },
                    tileColor: Colors.pink,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
                  SizedBox(height: 10),
                  Row(children: [
                    Expanded(
                      child: CheckboxListTile(
                        title: Text("Want a hotel",
                            style: TextStyle(
                                color: Colors.white,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w500)),
                        value: _wantHotel,
                        activeColor: Colors.blue,
                        onChanged: (bool? value) {
                          setState(() {
                            _wantHotel = value!;
                          });
                        },
                        tileColor: Colors.brown,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        controlAffinity: ListTileControlAffinity.leading,
                      ),
                    ),
                    SizedBox(width: 5),
                    Expanded(
                      child: CheckboxListTile(
                        title: Text("Lunch/dinner",
                            style: TextStyle(
                                color: Colors.white,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w500)),
                        value: _wantiunch$dinner,
                        activeColor: Colors.cyan,
                        onChanged: (bool? value) {
                          setState(() {
                            _wantiunch$dinner = value!;
                          });
                        },
                        tileColor: Colors.blueAccent,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        controlAffinity: ListTileControlAffinity.leading,
                      ),
                    ),
                  ]),
                  SizedBox(height: 24),
                  ElevatedButton.icon(
                    onPressed: clearForm,
                    icon: Icon(Icons.check, color: Colors.black),
                    label: Text("SUBMIT CARD",
                        style: TextStyle(color: Colors.black)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.withOpacity(0.6),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      padding:
                      EdgeInsets.symmetric(horizontal: 30, vertical: 14),
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

  Widget _buildField(String label, TextEditingController controller,
      {int maxLines = 1}) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
            color: Colors.white,
            fontStyle: FontStyle.italic,
            fontSize: 15),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10) ,borderSide: BorderSide(color: Colors.blue)),
        filled: true,
        fillColor: Colors.white.withOpacity(0.10),
      ),
      style: TextStyle(color: Colors.white),
      validator: (value) =>
      value == null || value.isEmpty ? 'Required field' : null,
    );
  }
}

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
            margin: EdgeInsets.all(12),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16)),
            child: ListTile(
              leading: CircleAvatar(
                  backgroundImage: NetworkImage(card.imageUrl)),
              title: Text(card.Name,
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold)),
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
