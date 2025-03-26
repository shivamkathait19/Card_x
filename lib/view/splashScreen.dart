import 'package:flutter/material.dart';


class splashScreen extends StatefulWidget {
  const splashScreen({super.key});


  @override
  State<splashScreen> createState() => _splashScreenState();
}
int _colorIndex = 0;

class _splashScreenState extends State<splashScreen> {
  final List<Color> _backgroundColors = [
    Colors.grey,
   // Colors.green,
    // Colors.orange,
    Colors.black12
  ];

  @override
  void initState() {
    super.initState();
    // Set a timer to change the background color every 2 seconds
    Future.delayed(Duration(seconds:1), _changeBackgroundColor);
  }
  void _changeBackgroundColor() {
    setState(() {
      _colorIndex = (_colorIndex + 1) % _backgroundColors.length;
    });
    Future.delayed(Duration(seconds: 1), _changeBackgroundColor); // Repeat the process
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColors[_colorIndex],
      body:
      Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              _backgroundColors[_colorIndex], // Start color
              _backgroundColors[(_colorIndex + 1) % _backgroundColors.length], // End color
            ],
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
