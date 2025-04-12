import 'package:flutter/material.dart';
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
  }
  );


  @override
  State<cardScreen> createState() => _cardScreenState();
}

class _cardScreenState extends State<cardScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
          padding:  EdgeInsets.only(bottom:200),
          child: Image.asset('asset/solated-on-black.jpg',
            height: 200,
            width: 150,
          ),
        ),


              ListTile(
                leading: Icon(Icons.person),
                title: Text( widget.username ?? 'username',),
              ),


          ],
        ),
      ),
    );
  }
}
