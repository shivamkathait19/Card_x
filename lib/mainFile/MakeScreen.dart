import 'package:card_x/mainFile/cardScreen.dart';
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
        padding: const EdgeInsets.all(15.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.5),
            border: Border.all(
              color: Colors.black12.withOpacity(0.5),
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(25),
          ),
          padding:  EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image.network("https://t3.ftcdn.net/jpg/05/92/76/32/360_F_592763239_V1Bj5YHCIRHreEfYRFwIcVaRBEqcCt1i.jpg",
               fit: BoxFit.cover,
                ),
                SizedBox(height: 19,),
                _buildField('Text'),
                const SizedBox(height: 16),
                _buildField('Location'),
                const SizedBox(height: 16),
                _buildField('Duration'),
                const SizedBox(height: 16),
                _buildField('People'),
                const SizedBox(height: 16),
                _buildField('Description', maxLines:1),
                const SizedBox(height: 24),
                ElevatedButton.icon(
                  onPressed: () {
                    // Submit action or Firebase logic
                  },
                  icon: const Icon(Icons.save_alt),
                  label:  Text("Submit"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black12,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 14),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
   Widget _buildField(String label, {int maxLines = 1}) {
    return TextFormField(
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(
          color: Colors.black,
          fontStyle: FontStyle.italic,
          fontSize: 15
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}

