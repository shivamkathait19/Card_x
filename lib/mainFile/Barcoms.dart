import 'package:card_x/mainFile/cardScreen.dart';
import 'package:flutter/material.dart';
class Barcoms extends StatefulWidget {
   Barcoms({super.key});

  @override
  State<Barcoms> createState() => _BarcomsState();
}

class _BarcomsState extends State<Barcoms> {

  Bartext(){

    setState(() {

    });
    Navigator.push(
        context,
        MaterialPageRoute
          (builder: (BuildContext Context)=> CardScreen()));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
        gradient: LinearGradient(
        colors: [Color(0xFF1f1c2c), Color(0xFF928DAB)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    ),),
        child: Center(
          child:
          ElevatedButton(onPressed: Bartext, child:
          Text("TAP TO SEE MEMES,",
            style: TextStyle(fontStyle: FontStyle.italic,fontSize: 15,color: Colors.black),))
        ),
      ),
    );
  }
}
