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
    return Scaffold(
      body: Center(
        child: Text("Card Screen"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _goToBlankPage,
        child: Icon(Icons.person),
        backgroundColor: Colors.grey,
      ),
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
    return Scaffold(
      appBar: AppBar(title: Text("Blank Page")),
      body: ListView(
        padding: EdgeInsets.all(10),
        children: [
          ListTile(
            leading: Icon(Icons.person),
            title: Text(username ?? 'No Name'),
          ),
          ListTile(
            leading: Icon(Icons.calendar_today),
            title: Text(date ?? 'No Date'),
          ),
          ListTile(
            leading: Icon(Icons.person_2),
            title: Text(father ?? 'No Father Name'),
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text(mother ?? 'No Mother Name'),
          ),
          ListTile(
            leading: Icon(Icons.phone),
            title: Text(mobile ?? 'No Mobile'),
          ),
          ListTile(
            leading: Icon(Icons.email),
            title: Text(email ?? 'No Email'),
          ),
        ],
      ),
    );
  }
}
