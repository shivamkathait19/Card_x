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
  final String text;
  final String location;
  final String duration;
  final String people;
  final String description;
  final String imageUrl;
  final String serviceOption;

  CardData({
    required this.text,
    required this.location,
    required this.duration,
    required this.people,
    required this.description,
    required this.imageUrl,
    required this.serviceOption,
  });
}

// Enum for service options
enum TravelOption { none, taxi, hotel }

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
  bool _wantTaxi = false;
  bool _wantHotel = false;

  TravelOption _selectedOption = TravelOption.none;

  void clearForm() {
    textController.clear();
    locationController.clear();
    durationController.clear();
    peopleController.clear();
    descriptionController.clear();
    setState(() {
      _wantHotel =false;
      _wantTaxi = false;
    });
  String selectedServices ='';
  if (_wantTaxi) selectedServices+='Taxi';
  if (_wantHotel) selectedServices +='Hotel';
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Card Submitted with option: ${_selectedOption.name}")),
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
                    colors: [Colors.deepPurple, Colors.pinkAccent]),
              ),
              child: Text('Menu',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic)),
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
                  Row(
                    children: [
                      Expanded(child:
                  _buildField('Duration', durationController)),
                  SizedBox(width: 5,),
                  Expanded(child:
                  _buildField('People', peopleController),)],),
                  SizedBox(height: 10,),
                  _buildField('Description', descriptionController,
                      maxLines: 2),
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
                    title: Text("Want a taxi for travelling", style: TextStyle(color: Colors.white)),
                    value: _wantTaxi,
                    activeColor: Colors.pinkAccent,
                    onChanged: (bool? value) {
                      setState(() {
                        _wantTaxi = value!;
                      });
                    },
                    tileColor: Colors.white10,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
                   SizedBox(height: 10,),
                  CheckboxListTile(
                    title: Text("Want a hotel", style: TextStyle(color: Colors.white)),
                    value: _wantHotel,
                    activeColor: Colors.pinkAccent,
                    onChanged: (bool? value) {
                      setState(() {
                        _wantHotel = value!;
                      });
                    },
                    tileColor: Colors.white10,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    controlAffinity: ListTileControlAffinity.leading,
                  ),


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
            color: Colors.white, fontStyle: FontStyle.italic, fontSize: 15),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        filled: true,
        fillColor: Colors.white10,
      ),
      style: TextStyle(color: Colors.white),
    );
  }
}

// Basic placeholder HomeScreen
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: Text("Home")),
      body: Center(
        child: Text("No saved cards (storage removed)",
            style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
