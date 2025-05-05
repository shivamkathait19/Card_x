/*import 'package:card_x/view/splashScreen.dart';
import 'package:flutter/material.dart';

class cardScreen extends StatefulWidget {

  @override
  State<cardScreen> createState() => _cardScreenState();
}

class _cardScreenState extends State<cardScreen> {

  void _goToBlankPage(){
    Navigator.push(
        context, MaterialPageRoute(builder: (context)=> BlankPage())
    );
  }


  @override
  Widget build(BuildContext context){
    return Scaffold(backgroundColor: Colors.black,
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

  cardScreen({
     Key? key,
    this.username,
    this.date,
    this.father,
    this.mother,
    this.mobile,
    this.email,
  }): super(key: key);

  @override
  State<BlankPage> createState() => _BlankPageState();
}

 class _BlankPageState  extends  State<BlankPage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Blank Page")),
      body: Center(
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:[
            Padding(
              padding:  EdgeInsets.only(),
              child: Image.asset('asset/solated-on-black.jpg',
                height: 300,
                width: 200,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 100),
              child: Column(
                children: [ Padding(
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
                      child:Center(
                        child: Text(
                          widget.username ?? "Username", style: TextStyle(
                            fontStyle: FontStyle.italic,color: Colors.white24, fontSize: 20
                        ),
                        ),
                      ),
                    ),
                  ),
                ),
                  Padding(
                    padding: EdgeInsets.only(left: 30,right: 30),
                    child: ListTile(
                      leading: Icon(Icons.person_2),
                      title:Container(
                        decoration: BoxDecoration(
                          border: Border( bottom:
                          BorderSide(
                            color: Colors.white,
                            width: 2.0,
                          ),
                          ),
                        ),
                        child: Center(
                          child: Text(widget.father ??' Father name',
                            style: TextStyle(
                                fontStyle: FontStyle.italic,color: Colors.white24,fontSize: 20
                            ),),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 30,right: 30),
                    child: ListTile(
                      leading: Icon(Icons.person_2),
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
                          child: Text(widget.mother ?? " Mother name ",style: TextStyle(
                            fontStyle: FontStyle.italic,color: Colors.white24,fontSize: 20,

                          ),),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 30,right: 30),
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
                          child: Text(widget.mother ?? " Mobile number ",style: TextStyle(
                              fontStyle: FontStyle.italic,color: Colors.white24
                          ),),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 30,right: 30),
                    child: ListTile(
                      leading: Icon(Icons.date_range ,),
                      title: Container(
                        decoration: BoxDecoration(
                            border: Border( bottom:
                            BorderSide(
                              color: Colors.white,
                              width: 2.0,
                            ),
                            )
                        ),
                        child: Center(
                          child:Text(widget.date ??'Date',style: TextStyle(
                              fontStyle: FontStyle.italic,color: Colors.white24,fontSize: 20
                          ),),
                        ),

                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 30,right: 30),
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
                          child:  Center(
                            child: Text(widget.mother ?? " Email  ",style: TextStyle(
                                fontStyle: FontStyle.italic,color: Colors.white24,fontSize: 20
                            ),),
                          )
                      ),
                    ),
                  ),
                  Padding(
                    padding:  EdgeInsets.only(left: 30,top: 40),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: FloatingActionButton(
                        onPressed: (){},
                        child: Icon(Icons.person),
                        // backgroundColor: Colors.blue,
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
*/

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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: ElevatedButton(
          onPressed: _goToBlankPage,
          child: Text("Go to Blank Page"),
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

class _BlankPageState extends State<BlankPage> {
  Widget infoTile(String label, String? value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
      child: ListTile(
        leading: Icon(icon, color: Colors.white70),
        title: Container(
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Colors.white, width: 2.0),
            ),
          ),
          child: Center(
            child: Text(
              value ?? "$label not provided",
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
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        "$label: ${value ?? 'N/A'}",
        style: const TextStyle(
          color: Colors.white70,
          fontSize: 16,
          fontStyle: FontStyle.italic,
        ),
      ),
    );
  }
  void showInfoDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.black87,
          title: const Text("User Details", style: TextStyle(color: Colors.white)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              infoText("Username", widget.username),
              infoText("Father", widget.father),
              infoText("Mother", widget.mother),
              infoText("Mobile", widget.mobile),
              infoText("DOB", widget.date),
              infoText("Email", widget.email),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Close", style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Blank Page")),
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'asset/solated-on-black.jpg',
              height: 300,
              width: 200,
            ),
            const SizedBox(height: 40),
            infoTile("Username", widget.username, Icons.person),
            infoTile("Father Name", widget.father, Icons.person_2),
            infoTile("Mother Name", widget.mother, Icons.person_2_outlined),
            infoTile("Mobile Number", widget.mobile, Icons.numbers),
            infoTile("Date of Birth", widget.date, Icons.date_range),
            infoTile("Email", widget.email, Icons.email),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: showInfoDialog,
        child: const Icon(Icons.info),
      ),
    );
  }
}
