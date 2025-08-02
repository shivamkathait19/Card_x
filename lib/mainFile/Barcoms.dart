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
   Cardmaker(){
    Navigator.push(context, MaterialPageRoute(builder: (BuildContext Context)=>Card()));
   }
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.brown.shade50,
      body: Container(
        child: Center(
          child:Column(
            mainAxisSize: MainAxisSize.min,
           children: [
             ElevatedButton(
            onPressed: Bartext,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black.withOpacity(0.7),
              foregroundColor: Colors.black,
              padding:  EdgeInsets.symmetric(horizontal: 30, vertical: 16),
              elevation: 10,
              shadowColor: Colors.black45,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
               
              ),
            ),
            child: Text(
              "TAP TO SEE MEMES",
              style: TextStyle(
                fontSize: 16,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w200,
                letterSpacing:1,
                color: Colors.white,
              ),
            ),
          ),
             SizedBox(height: 20,),
          ElevatedButton(onPressed: Cardmaker,  style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black.withOpacity(0.7),
            foregroundColor: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 30,vertical: 16),
            elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)
          )
          ),

              child: Text("TAP TO CREATE OWN CARD",style: TextStyle(
            fontSize: 16,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.w100
          ),)) ],
          ),),
      ),
    );
  }
}
