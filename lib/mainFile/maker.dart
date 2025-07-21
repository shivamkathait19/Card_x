

import 'package:flutter/material.dart';
class Cardlogo extends StatefulWidget {
  const Cardlogo({super.key});

  @override
  State<Cardlogo> createState() => _CardlogoState();
}

class _CardlogoState extends State<Cardlogo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Card(
        child:
        ListTile(
          leading: Icon(Icons.location_city),
          title: TextField(

          ),
        )
      ),
    );
  }
}

