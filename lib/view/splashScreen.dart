import 'package:flutter/material.dart';
class splashScreen extends StatelessWidget {
  const splashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: Center(
        child: Column(
          children:[
            SizedBox(
              height: 200,
            ),
            Image.network("https://bsmedia.business-standard.com/_media/bs/img/article/2024-03/12/full/1710223554-0545.jpg",),
SizedBox(
  height: 100,
),
            Text("MAKE YOUR CARD ",style: TextStyle(fontSize: 20,fontWeight:FontWeight.w200),),
          ],
        ),
      ),

    );
  }
}
