/*import 'package:flutter/material.dart';
import 'package:card_x/view/LoginScreen.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class CardScreen extends StatefulWidget {
  final String? username;
  final String? full;
  final String? date;
  final String? father;
  final String? mother;
  final String? mobile;
  final String? email;

  const CardScreen({
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
  State<CardScreen> createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {
  void _goToBlankPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BlankPage(
          username: widget.username,
          full: widget.full,
          date: widget.date,
          mobile: widget.mobile,
          email: widget.email,
        ),
      ),
    );
  }
  String imgUrl = "";
  int? memeNO;
  bool isLoading = true;

  int number = 1;


  @override
  void initState() {
    // TODO : implement initState

    super.initState();


    UpdateImg();
  }
  void UpdateImg() async{
    String getImgUrl =  await FetchMeme.fetchNewMemes();
    setState(() {
      imgUrl = getImgUrl ;
      isLoading = false;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Center(
        child:Text(
            number.toString(),
            style:  TextStyle(fontSize:20, fontWeight: FontWeight.w400)),
          SizedBox(
            height: 10,
          ),

          Text(
            "Keep watching until you get a smile on your face",
            style: TextStyle(decoration: TextDecoration.underline ,decorationStyle: TextDecorationStyle.solid,
                fontSize: 14,fontWeight:FontWeight.w500),),
          SizedBox(
            height: 20,
          ),

          SizedBox(
            height: 500,
            child:
            isLoading ?
            Container(
              height: 400, width: MediaQuery.of(context).size.width,
              child: const Center(
                child: SizedBox(
                    height: 50,
                    width: 50,
                    child: CircularProgressIndicator()),
              ),
            ):
            Image.network(
                height: 600, width: MediaQuery.of(context).size.width,
                imgUrl
            ),
          ),
          const SizedBox(
            height: 10,
          ),

          ElevatedButton(
              onPressed: ()async{
                setState(() {
                  number++;
                });
                UpdateImg();
              } ,

              child: const SizedBox(
                  height: 20,
                  width: 200,
                  child: Center(child: Text("More funny")))),
        child: Padding(
          padding: EdgeInsets.only(top:0),
           child: FloatingActionButton(
             onPressed: _goToBlankPage,
           child: Icon(Icons.person_2),
             backgroundColor: Colors.black,
           foregroundColor: Colors.white,
             shape:  RoundedRectangleBorder(
               borderRadius: BorderRadius.circular(25)
             ),
           ),
        ),
      ),
    );
  }
}*/
import 'package:card_x/mainFile/FetchMemes.dart';
import 'package:flutter/material.dart';
import 'package:card_x/view/LoginScreen.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class CardScreen extends StatefulWidget {
  final String? username;
  final String? full;
  final String? date;
  final String? father;
  final String? mother;
  final String? mobile;
  final String? email;

  const CardScreen({
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
  State<CardScreen> createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {
  void _goToBlankPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BlankPage(
          username: widget.username,
          full: widget.full,
          date: widget.date,
          mobile: widget.mobile,
          email: widget.email,
        ),
      ),
    );
  }

  String imgUrl = "";
  int number = 1;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    UpdateImg();
  }

  void UpdateImg() async {
    String getImgUrl = await FetchMemes.fetchNewMemes();
    setState(() {
      imgUrl = getImgUrl;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFf0f2f5),
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text("Funny Memes"),
        centerTitle: true,
        elevation: 4,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              number.toString(),
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
            ),
            const SizedBox(height: 10),
            const Text(
              "Keep watching until you get a smile on your face",
              textAlign: TextAlign.center,
              style: TextStyle(
                decoration: TextDecoration.underline,
                decorationStyle: TextDecorationStyle.solid,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 400,
              child: isLoading
                  ? const Center(
                child: CircularProgressIndicator(),
              )
                  : Image.network(
                imgUrl,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                setState(() {
                  number++;
                });
                UpdateImg();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: const Text("More Funny"),
            ),
          ],
        ),
      ),

      // ✅ Floating Button
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(top: 20, right: 10),
        child: FloatingActionButton(
          onPressed: _goToBlankPage,
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          child: const Icon(Icons.person_2),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
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

  Widget infoCard(String label, String? value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 3)),
          ],
        ),
        child: ListTile(
          leading: Icon(icon, color: Colors.teal, size: 28),
          title: Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.w500,fontStyle: FontStyle.italic),
          ),
          subtitle: Text(
            value ?? 'Not provided',
            style: const TextStyle(color: Colors.black87, fontSize: 16),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text("My Profile"),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: ListView(
        children: [
          const SizedBox(height: 30),
          const CircleAvatar(
            radius: 50,
            backgroundColor: Colors.teal,
            child: Icon(Icons.person, size: 50, color: Colors.white),
          ),
          const SizedBox(height: 30),
          infoCard("Username", widget.username, Icons.person),
          infoCard("Full Name", widget.full, FeatherIcons.userCheck),
          infoCard("Email", widget.email, Icons.email_outlined),
          infoCard("Date of Birth", widget.date, Icons.cake),
          infoCard("Mobile Number", widget.mobile, Icons.phone_android),
          const SizedBox(height: 40),
          Center(
            child: ElevatedButton.icon(
              onPressed: mainPage,
              icon: const Icon(Icons.logout),
              label: const Text("Log Out"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}
