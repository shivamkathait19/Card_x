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
 /*NextScreen() {
    if (_formKey.currentState!.validate()) {}
    setState(() {
      isLoadingsingup = true;
    });
    Future.delayed(Duration(seconds: 5),() {
    setState(() {
      isLoadingsingup= false;
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => MainForm())
      );
    });
    });
  }*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: ElevatedButton(onPressed: Bartext, child: Text("TAP TO SEE MEMES"))
        ),
      ),
    );
  }
}
