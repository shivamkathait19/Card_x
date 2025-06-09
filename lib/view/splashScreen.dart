import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
   SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}


class _SplashScreenState extends State<SplashScreen>{




  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.white,
      body:
      Container(
        child: Column(
          children:[
            SizedBox(
              height: 100,
            ),

            Row(
              children: [
                Padding(
                  padding:  EdgeInsets.only(left: 10,top: 20),
                  child: Container(
                    height: 200,
                    decoration: BoxDecoration(
                       border: Border.all(
                         color: Colors.black54,
                    )
                    ),
                   child: Image.network("https://www.usatoday.com/gcdn/authoring/authoring-images/2024/08/28/USAT/74988734007-debitcredit.jpg?crop=699,393,x0,y0&width=660&height=371&format=pjpg&auto=webp",width: 350, height: 300,)),
                ),
              ],
            ),




            SizedBox(
              height: 80,
            ),

            Padding(
                 padding: EdgeInsets.only(left: 90),
                 child: Container(
                  height: 200,
                  width: 350,
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.black54
                      )
                  ),

                  child: Row(
                    children: [Image.network("https://bsmedia.business-standard.com/_media/bs/img/article/2023-03/26/full/1679835161-6589.jpg?im=FeatureCrop,size=(826,465)", width: 347, height: 265,),
                    ],
                  ),
                 ),
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




