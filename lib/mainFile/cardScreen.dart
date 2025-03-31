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
  State<cardScreen> createState() => _CardScreenState();
}

class _CardScreenState extends State<cardScreen> {
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
  Widget build(BuildContext context) {
    return Scaffold( backgroundColor: Colors.grey,
      body: Center(
        child: Text("Card Screen"),
      ),
        floatingActionButton: Padding(
          padding:  EdgeInsets.only(top: 20,right: 10),
          child: FloatingActionButton(
          onPressed: _goToBlankPage,
          child: Icon(Icons.person),

          backgroundColor: Colors.grey,
                ),
        ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
    );
  }
}

class BlankPage extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Scaffold( backgroundColor: Colors.grey,
      appBar: AppBar(title: Text(" PROFILE ")),
      body:
      ListView(
        padding: EdgeInsets.only(top: 20),
        children: [
          ListTile(
            leading: Icon(Icons.person),
            title: Text(username ?? 'No Name'),
            titleTextStyle: TextStyle(
              fontStyle: FontStyle.italic
            ),
          ),
          ListTile(
            leading: Icon(Icons.calendar_today),
            
            title: Text(date ?? 'No Date'),
            titleTextStyle: TextStyle(
                fontStyle: FontStyle.italic
            ),
          ),
          ListTile(
            leading: Icon(Icons.person_2),
            title: Text(father ?? 'No Father Name'),
            titleTextStyle: TextStyle(
                fontStyle: FontStyle.italic
            ),
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text(mother ?? 'No Mother Name'),
            titleTextStyle: TextStyle(
                fontStyle: FontStyle.italic
            ),
          ),
          ListTile(
            leading: Icon(Icons.phone),
            title: Text(mobile ?? 'No Mobile'),
            titleTextStyle: TextStyle(
                fontStyle: FontStyle.italic
            ),
          ),
          ListTile(
            leading: Icon(Icons.email),
            title: Text(email ?? 'No Email'),
            titleTextStyle: TextStyle(
                fontStyle: FontStyle.italic
            ),
          ),
        ],
      ),
    );
  }
}
