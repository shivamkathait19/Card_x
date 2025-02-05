import 'package:flutter/material.dart';
class splashScreen extends StatelessWidget {
  const splashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.white70,

      body:
      Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.yellow], // Add your colors
            begin: Alignment.topLeft,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children:[
           SizedBox(
              height: 120,
            ),
            Row(
              children: [
                Padding(
                  padding:  EdgeInsets.only(left: 10),
                  child: Container(
                    height: 200,
                    decoration: BoxDecoration(
                      // Container color
                      //borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black54.withOpacity(0.8), // Glow color
                          spreadRadius:5, // How far the glow extends
                          blurRadius:5,  // How blurred the glow is
                          offset: Offset(0, 0), // Position of the glow
                        ),
                      ],
                    ),
                   child: Image.network("https://www.usatoday.com/gcdn/authoring/authoring-images/2024/08/28/USAT/74988734007-debitcredit.jpg?crop=699,393,x0,y0&width=660&height=371&format=pjpg&auto=webp",width: 350, height: 300,)),
                ),
              ],
            ),
            SizedBox(
              height: 100,
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
              height: 100,
            ),

               Padding(
                 padding: EdgeInsets.only(left: 90),
                 child: Container(
                  height: 200,
                  width: 350,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black54.withOpacity(0.8), // Glow color
                        spreadRadius:5, // How far the glow extends
                        blurRadius:2,  // How blurred the glow is
                        offset: Offset(0, 0), // Position of the glow
                      ),
                    ],
                  ),
                  child: Row(
                    children: [Image.network("https://bsmedia.business-standard.com/_media/bs/img/article/2023-03/26/full/1679835161-6589.jpg?im=FeatureCrop,size=(826,465)", width: 347, height: 265,),
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
