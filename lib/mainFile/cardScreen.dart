import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';


class cardScreen extends StatefulWidget {
  final String? username;
  final String? date;
  final String? father;
  final String? mother;
  final String? mobile;
  final String? email;

   cardScreen({
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
    return Scaffold( backgroundColor: Colors.white,
      body:ListView(
        children: [
          Center(
            child: ListTile(
              leading: Icon(Icons.person),
              title: Text(  'No Name'),
              titleTextStyle: TextStyle(
                  fontStyle: FontStyle.italic
              ),
            ),
          ),

          ListTile(
            leading: Icon(Icons.calendar_today),
            title: Text( 'No Date'),
            titleTextStyle: TextStyle(
                fontStyle: FontStyle.italic
            ),
          ),

          ListTile(
            leading: Icon(Icons.person_2),
            title: Text( 'No Father Name'),
            titleTextStyle: TextStyle(
                fontStyle: FontStyle.italic
            ),
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text( 'No Mother Name'),
            titleTextStyle: TextStyle(
                fontStyle: FontStyle.italic
            ),
          ),
          ListTile(
            leading: Icon(Icons.phone),
            title: Text( 'No Mobile'),
            titleTextStyle: TextStyle(
                fontStyle: FontStyle.italic
            ),
          ),
          ListTile(
            leading: Icon(Icons.email),
            title: Text( 'No Email'),
            titleTextStyle: TextStyle(
                fontStyle: FontStyle.italic
            ),
          ),
        ],
      ),
      /*Center(

        child: Text("Card Screen"),
      ),
        floatingActionButton:Center(
          child: SpeedDial(
              animatedIcon: AnimatedIcons.menu_arrow,
              backgroundColor: Colors.blue,
              overlayColor: Colors.black54,
              overlayOpacity: 0.5,
              children: [
          SpeedDialChild(
            child: ElevatedButton.icon(onPressed: _goToBlankPage,
              icon: Icon(Icons.person_2),
               label:Text("PROFILE"),style: ElevatedButton.styleFrom(

          ),
          ),

              ]
              ),
        ),*/

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

   BlankPage({
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
    return Scaffold( backgroundColor: Colors.white,
      //appBar: AppBar(title: Text(" PROFILE ")),
      body: ListView(
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
