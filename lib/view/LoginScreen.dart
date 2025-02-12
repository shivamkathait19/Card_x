import 'package:flutter/material.dart';
class LoginScreen extends StatelessWidget {
     LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: SafeArea(
           child:Column(
               mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTR90LRqys3ItqiLIzthGpWk-mK_RaKXLHQJddJzObzeFXAhfEFDh1NvshrFGSyLYSNM-o&usqp=CAU",height: 150,

                )
              ],
           ) ),
    );
  }
}
