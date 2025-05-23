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
final List<Color> bgColors = [
Color(0xFFF0F2F5),
Color(0xFFE8F5E9),
Color(0xFFFFF3E0),
Color(0xFFFFEBEE),
Color(0xFFE3F2FD),
];
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
   int number = 0;
   int target = 10  ;
   bool isLoading = true;
   Color currentBgColor = Color(0xFFF0F2F5);


  @override
  void initState() {
    super.initState();
    UpdateImg();
  }

  Future<void> UpdateImg() async {
    String getImgUrl = await FetchMemes.fetchNewMemes();
    setState(() {
      imgUrl = getImgUrl;
      currentBgColor = (bgColors.toList()..shuffle()).first;

     if(number == target){
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _showTargetDialog();
        });
          target +=50;
      }
      isLoading = false;
    });
  }

  void  _showTargetDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("🎉 Target Achieved!"),
          content: Text(
              "You have seen $number memes!\nNext target: $target memes."),
          actions: [
            TextButton(child: Text("Ok"), onPressed: () {
              Navigator.of(context).pop();
            }
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  Color(0xFFf0f2f5),
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
            Row(
              children: [
                Padding(
                  padding:  EdgeInsets.only(left: 150),
                  child: Text(
                    "Target#$target/",
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      decorationStyle: TextDecorationStyle.solid,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
                Text(
                  number.toString(),
                  style: TextStyle(fontSize: 20,fontWeight: FontWeight.w400,decoration: TextDecoration.underline,fontStyle: FontStyle.italic,),
                ),
              ],
            ),

             SizedBox(height: 20),
            SizedBox(
              height: 300,
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
              onPressed:()async{
                setState((){
                  isLoading =true;
                });
                 await UpdateImg();
                 setState(() {
                   number++;
                 });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                foregroundColor: Colors.white,
                padding : EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: Text("Next"),
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




