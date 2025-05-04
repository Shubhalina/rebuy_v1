import 'package:flutter/material.dart';

class MyAccountPage extends StatelessWidget {
  const MyAccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Account"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage("assets/profile.jpg"),
                ),
                // Removed the close button since we have the back button in the AppBar
              ],
            ),
            SizedBox(height: 10),
            Text("Alice Eve", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.redAccent)),
            Text("alice.eve@gmail.com", style: TextStyle(color: Colors.grey)),
            SizedBox(height: 20),
            Text("My account", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            buildEditableField("Name", "Alice Eve"),
            buildEditableField("Email", "alice.eve@gmail.com"),
            buildEditableField("Phone", "+1 561-230-0033"),
            buildEditableField("Address", "Alice Eve\n2074, Half and Half Drive\nHialeah, Florida - 33012\nPh: +1 561-230-0033", multiLine: true),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  backgroundColor: Colors.white,
                  side: BorderSide(color: Colors.black),
                ),
                onPressed: () {},
                icon: Icon(Icons.settings, color: Colors.black),
                label: Text("Settings", style: TextStyle(color: Colors.black)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildEditableField(String label, String value, {bool multiLine = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 5),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: multiLine ? 10 : 5),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(value, style: TextStyle(fontSize: 16)),
                ),
                Icon(Icons.edit, color: Colors.grey),
              ],
            ),
          ),
        ],
      ),
    );
  }
}