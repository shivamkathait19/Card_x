import 'package:flutter/material.dart';

class Makescreen extends StatelessWidget implements PreferredSizeWidget {
  Makescreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 2,
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CircleAvatar(
          backgroundImage: AssetImage("assets/logo.png",) // Your logo
        ),
      ),
      title: RichText(
        text:  TextSpan(
          children: [
            TextSpan(
              text: 'shivam',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
            TextSpan(
              text: 'Trip',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.pinkAccent,
              ),
            ),
          ],
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.menu, color: Colors.black87),
          onPressed: () {
            Scaffold.of(context).openEndDrawer(); // Optional drawer trigger
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

