import 'package:flutter/material.dart';

class Makescreen extends StatelessWidget {
  Makescreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown,
      appBar: AppBar(
        backgroundColor: Colors.white10,
        elevation: 5,
        leadingWidth: 100,
        leading: Builder(
          builder: (context) => Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(
                icon: Icon(Icons.menu, color: Colors.white),
                onPressed: () => Scaffold.of(context).openDrawer(),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 0),
                child: CircleAvatar(
                  radius: 16,
                  backgroundImage: AssetImage("assets/avatar-png.jpg"), // Check path
                ),
              ),
            ],
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
      ),

      drawer: Drawer(
        backgroundColor: Colors.black,
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.deepPurple, Colors.pinkAccent]),
              ),
              child: Text(
                'Menu',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home, color: Colors.white),
              title: Text('Home', style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.settings, color: Colors.white),
              title: Text('Settings', style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.info, color: Colors.white),
              title: Text('About', style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
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
          padding: EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image.network(
                  "https://t3.ftcdn.net/jpg/05/92/76/32/360_F_592763239_V1Bj5YHCIRHreEfYRFwIcVaRBEqcCt1i.jpg",
                  fit: BoxFit.cover,
                ),
                SizedBox(height: 19),
                _buildField('Text'),
                SizedBox(height: 16),
                _buildField('Location'),
                SizedBox(height: 16),
                _buildField('Duration'),
                SizedBox(height: 16),
                _buildField('People',),
                SizedBox(height: 16),
                _buildField('Description', maxLines: 1),
                SizedBox(height: 24),
                ElevatedButton.icon(
                  onPressed: () {
                    // Submit action or Firebase logic
                  },
                  icon: Icon(Icons.add, color: Colors.black),
                  label: Text(
                    " JUST 8999 BOOK NOW ",
                    style: TextStyle(color: Colors.black),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.withOpacity(0.6),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 14),
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
      keyboardType: TextInputType.number,
      // inputFormatters: [
      //   FilteringTextInputFormatter.digitsOnly
      // ],
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
            color: Colors.black, fontStyle: FontStyle.italic, fontSize: 15),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
