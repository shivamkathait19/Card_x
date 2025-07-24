import 'package:flutter/material.dart';

class Cardlogo extends StatelessWidget {
  const Cardlogo({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Card(
        child: ListTile(
          leading: Icon(Icons.location_city),
          title: Text("Shivam  "),
        ),
      ),
    );
  }
}
