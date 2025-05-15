import 'package:card_x/view/LoginScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class cardScreen extends StatefulWidget {
  final String? username;
  final String? full;
  final String? date;
  final String? father;
  final String? mother;
  final String? mobile;
  final String? email;

  const cardScreen({
    Key? key,
    this.username,
    this.full,
    this.date,
    this.father,
    this.mother,
    this.mobile,
    this.email,
  }) : super(key: key);

  @override
  State<cardScreen> createState() => _cardScreenState();
}

class _cardScreenState extends State<cardScreen>{
  void _goToBlankPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BlankPage(
          username: widget.username,
          full :widget.full,
          date: widget.date,
          mobile: widget.mobile,
          email: widget.email,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: _goToBlankPage,
            child: Icon(Icons.person,size: 20,),
          ),
        ),
      ),
    );
  }
}

class BlankPage extends StatefulWidget {

  final String? username;
  final String? full;
  final String? date;
  final String? mobile;
  final String? email;

  const BlankPage({
    Key? key,
    this.username,
    this.full,
    this.date,
    this.mobile,
    this.email,
  }) : super(key: key);

  @override
  State<BlankPage> createState() => _BlankPageState();
}

class _BlankPageState extends State<BlankPage> {

  void mainPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (BuildContext context) => LoginScreen()),
    );
  }


  Widget infoTile (String label, String? value, IconData icon){
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: Colors.black),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              "$label: ${value ?? 'N/A'}",
              style: TextStyle(
                fontStyle: FontStyle.italic,
                fontSize: 16,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             Icon(Icons.person, size: 80),
             SizedBox(height: 50),
            Row(
              children: [
                infoTile("Username", widget.username, Icons.person),
                infoTile("full name ", widget.full, Icons.person),
              ],
            ),
            infoTile("Email", widget.email, Icons.email),
            infoTile("Date of Birth", widget.date, Icons.date_range),
            infoTile("Mobile Number", widget.mobile, Icons.numbers),
            const SizedBox(height: 100),
            ElevatedButton(
              onPressed: mainPage,
              child: const Text("Log Out"),
            ),
            ElevatedButton(onPressed:(){}, child: Icon(FeatherIcons.camera))
          ],
        ),
      ),
    );
  }
}

