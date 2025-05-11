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

  Widget infoTile(String label, String? value, IconData icon) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
      child: ListTile(
        leading: Icon(icon, color: Colors.black),
        title: Container(
          decoration: BoxDecoration(
            border: Border(  
              bottom: BorderSide(color: Colors.black, width: 2.0),
            ),
          ),
          child: Center(
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: ListTile(
                leading: Icon(Icons.person,),
                title: Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.white,
                        width: 2.0,
                      ),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      widget.username ?? "Username", style: TextStyle(
                        fontStyle: FontStyle.italic,
                        color: Colors.white24,
                        fontSize: 20
                    ),
                    ),
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: ListTile(
                leading: Icon(Icons.numbers),
                title: Container(
                  decoration: BoxDecoration(
                      border: Border(bottom:
                      BorderSide(
                        color: Colors.white,
                        width: 2.0,
                      )
                      )
                  ),
                  child: Center(
                    child: Text(widget.mobile ?? " Mobile number ",
                      style: TextStyle(
                          fontStyle: FontStyle.italic,
                          color: Colors.white24
                      ),),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 30, right: 30),
              child: ListTile(
                leading: Icon(Icons.date_range,),
                title: Container(
                  decoration: BoxDecoration(
                      border: Border(bottom:
                      BorderSide(
                        color: Colors.white,
                        width: 2.0,
                      ),
                      )
                  ),
                  child: Center(
                    child: Text(
                      widget.date ?? 'Date', style: TextStyle(
                        fontStyle: FontStyle.italic,
                        color: Colors.white24,
                        fontSize: 20
                    ),),
                  ),

                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 30, right: 30),
              child: ListTile(
                leading: Icon(Icons.email),
                title: Container(
                    decoration: BoxDecoration(
                        border: Border(bottom:
                        BorderSide(
                          color: Colors.white,
                          width: 2.0,
                        )
                        )
                    ),
                    child: Center(
                      child: Text(
                        widget.email ?? " Email  ", style: TextStyle(
                          fontStyle: FontStyle.italic,
                          color: Colors.white24,
                          fontSize: 20
                      ),
                      ),
                    )
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}


  /*Widget infoText(String label, String? value) {
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
            infoTile("full name ", widget.full, Icons.person),
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
*/
