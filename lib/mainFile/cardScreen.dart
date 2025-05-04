

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

class _BlankPageState extends State<BlankPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Blank Page")),
      body: Center(
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
                        onPressed: _goToBlankPage,
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
}*/
import 'package:flutter/material.dart';

class CardScreen extends StatefulWidget {
  @override
  State<CardScreen> createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {
  void _goToBlankPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BlankPage(
          username: "John Doe",
          father: "Mr. Smith",
          mother: "Mrs. Smith",
          mobile: "1234567890",
          email: "john@example.com",
          date: "01-01-2025",
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
  State<BlankPage> createState() => _BlankPageState();
}

class _BlankPageState extends State<BlankPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Blank Page"),
        backgroundColor: Colors.grey[900],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(16),
              child: Image.asset(
                'asset/solated-on-black.jpg',
                height: 300,
                width: 200,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 8),
              child: _buildInfoTile(Icons.person, widget.username ?? "Username"),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 8),
              child: _buildInfoTile(Icons.person_2, widget.father ?? "Father's Name"),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 8),
              child: _buildInfoTile(Icons.person_2, widget.mother ?? "Mother's Name"),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 8),
              child: _buildInfoTile(Icons.phone, widget.mobile ?? "Mobile Number"),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 8),
              child: _buildInfoTile(Icons.date_range, widget.date ?? "Date"),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 8),
              child: _buildInfoTile(Icons.email, widget.email ?? "Email"),
            ),
            SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: () => Navigator.pop(context),
              icon: Icon(Icons.arrow_back),
              label: Text("Go Back"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[800],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoTile(IconData icon, String value) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.white24,
              width: 1.5,
            ),
          ),
        ),
        child: Center(
          child: Text(
            value,
            style: TextStyle(
              fontStyle: FontStyle.italic,
              color: Colors.white70,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }
}
