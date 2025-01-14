import 'package:flutter/material.dart';
class splashScreen extends StatelessWidget {
  const splashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.white70,

      body:
      Center(
        child: Column(
          children:[
           SizedBox(
              height: 120,
            ),
            Row(
              children: [
                Padding(
                  padding:  EdgeInsets.only(left: 10),
                  child: Image.network("https://www.usatoday.com/gcdn/authoring/authoring-images/2024/08/28/USAT/74988734007-debitcredit.jpg?crop=699,393,x0,y0&width=660&height=371&format=pjpg&auto=webp",width: 350, height: 300,),
                ),
              ],
            ),
            Text("MAKE YOUR CARD ",style: TextStyle(fontSize: 19,          // Font size
              // fontWeight: FontWeight.bold,  // Font weight
              fontStyle: FontStyle.italic,  // Italic style
              color: Colors.black,    // Text color
              letterSpacing: 3.0,    // Space between letters
              wordSpacing: 5.0,
              decoration: TextDecoration.underline,
              decorationColor: Colors.black38,
              decorationStyle: TextDecorationStyle.double,

            ),),
            SizedBox(
              height: 35,
            ),
            Padding(
              padding:  EdgeInsets.only(left:110,bottom: 50),
              child: Container(
                child: Row(
                  children: [
                    Image.network("https://bsmedia.business-standard.com/_media/bs/img/article/2024-03/12/full/1710223554-0545.jpg", width: 330, height: 250,),
                  ],
                ),
              ),
            ),
SizedBox(
  height: 50,
),
            Spacer(),
            Text("App Create by",style: TextStyle(fontStyle: FontStyle.italic,fontSize: 12,wordSpacing: 5.0,decoration: TextDecoration.underline,decorationStyle: TextDecorationStyle.solid,),),
            Text("Shubham",style: TextStyle(fontStyle: FontStyle.italic,fontSize: 10,wordSpacing: 5.0,decoration: TextDecoration.underline,decorationStyle: TextDecorationStyle.solid,)),
          SizedBox(
            height: 20,
          )
          ],


        ),
      ),

    );
  }
}
