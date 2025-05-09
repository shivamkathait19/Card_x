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

class _cardScreenState extends State<cardScreen> {
  void _goToBlankPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BlankPage(
          username: widget.username,
          date: widget.date,
          father: widget.father,
          mother: widget.mother,
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
  final String? father;
  final String? mother;
  final String? mobile;
  final String? email;

  const BlankPage({
    Key? key,
    this.username,
    this.date,
    this.father,
    this.mother,
    this.mobile,
    this.email,
  }) : super(key: key);

  @override
  State<BlankPage> createState() => _BlankPageState();
}

class _BlankPageState extends State<BlankPage>{
  Widget infoTile(String label, String? value, IconData icon){
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 30, vertical: 5),
      child: ListTile(
        leading: Icon(icon, color: Colors.white70),
        title: Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Colors.white, width: 2.0),
            ),
          ),
          child: Center(
            child: Text(
              value ?? "$label",
              style: const TextStyle(
                fontStyle: FontStyle.italic,
                color: Colors.white24,
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
      //appBar: AppBar(title: const Text("Blank Page")),
      backgroundColor: Colors.black,
      body: Center(
         child: Container(
           decoration: BoxDecoration(
             gradient: LinearGradient(
               begin: Alignment.centerLeft,
               end:Alignment.centerRight,
               colors: [Colors.red, Colors.cyan],
             ),
               borderRadius: BorderRadius.circular(20),
               boxShadow:[
                BoxShadow(
               color: Colors.cyan.withOpacity(0.6),
               blurRadius: 30,
               spreadRadius: 5,
             ),
           ],
         ),

           child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:[
            Image.asset('asset/solated-on-black.jpg',
              height: 300,
              width: 150,
            ),
            infoTile("Username", widget.username, Icons.person),
            infoTile("Father Name", widget.father, Icons.person_2),
            infoTile("Mother Name", widget.mother, Icons.person_2_outlined),
            infoTile("Mobile Number", widget.mobile, Icons.numbers),
            infoTile("Date of Birth", widget.date, Icons.date_range),
            infoTile("Email", widget.email, Icons.email),
            SizedBox(height: 100,)
          ],
        ),
      ),
      ),
    );
  }
}