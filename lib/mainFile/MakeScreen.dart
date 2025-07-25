import 'package:flutter/material.dart';

class Makescreen extends StatelessWidget  {
  Makescreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar:   AppBar(
      backgroundColor: Colors.white10,
      elevation: 2,
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CircleAvatar(
            backgroundImage: AssetImage("",) // Your logo
        ),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: const [
          Text(
            'Make',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple,
            ),
          ),
          Text(
            'Card',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.pinkAccent,
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.menu, color: Colors.black87),
          onPressed: () {
            Scaffold.of(context).openEndDrawer(); // Optional drawer trigger
          },
        ),
      ],
    ),

      body: Padding(
        padding:  EdgeInsets.all(15.0),
        child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.5),
              border: Border.all(
                color: Colors.black12.withOpacity(0.5), // Change to your preferred border color
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(25),
            ),
            child: Center(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                decoration: InputDecoration(
                    labelText: 'Location',
                    labelStyle: TextStyle(
                    color: Colors.black,
                        fontStyle: FontStyle.italic
                ),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10),
              ),

                        ),
              
                      ),

            ),

          )

        ),
      ));

  }
}

