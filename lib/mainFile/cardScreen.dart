import 'package:card_x/view/LoginScreen.dart';
import 'package:flutter/material.dart';

class cardScreen extends StatefulWidget {
  final String? username;
  final String? date;
  final String? father;
  final String? mother;
  final String? mobile;
  final String? email;

  const cardScreen({
    Key? key,
    this.username,
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
        child: ElevatedButton(
          onPressed: _goToBlankPage,
          child: Icon(Icons.person,size: 20,),
        ),
      ),
    );
  }
}

class BlankPage extends StatefulWidget {

  final String? username;
  final String? date;
  final String? mobile;
  final String? email;

  const BlankPage({
    Key? key,
    this.username,
    this.date,
    this.mobile,
    this.email,
  }) : super(key: key);

  @override
  State<BlankPage> createState() => _BlankPageState();
}

class _BlankPageState extends State<BlankPage>{
    void mainPage(){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (BuildContext context) =>LoginScreen()),
    );
  }

  Widget infoTile(String label, String? value, IconData icon){
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 30, vertical: 5),
      child: ListTile(
        leading: Icon(icon, color: Colors.black),
        title: Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Colors.black, width: 2.0),
            ),
          ),
          child: Center(
            child: Text(
              value ?? "$label",
              style: const TextStyle(
                fontStyle: FontStyle.italic,
                color: Colors.black,
                fontSize: 20,
              ),
            ),
          ),
        ),
      ),
    );
  }
  Widget infoText(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Text(
        "",
        style: const TextStyle(
          color: Colors.white70,
          fontSize: 16,
          fontStyle: FontStyle.italic,
        ),
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
            const Icon(Icons.person, size: 80),
            const SizedBox(height: 50),
            infoTile("Username", widget.username, Icons.person),
            infoTile("Email", widget.email, Icons.email),
            infoTile("Date of Birth", widget.date, Icons.date_range),
            infoTile("Mobile Number", widget.mobile, Icons.numbers),
            const SizedBox(height: 100),
            ElevatedButton(
              onPressed: mainPage,
              child: const Text("Log Out"),
            ),
          ],
        ),
      ),
    );
  }
}

