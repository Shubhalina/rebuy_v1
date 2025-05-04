import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Profile & Settings")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            CircleAvatar(radius: 50, backgroundImage: NetworkImage("https://via.placeholder.com/150")),
            SizedBox(height: 10),
            Text("John Doe", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            ListTile(
              leading: Icon(Icons.email),
              title: Text("john.doe@example.com"),
            ),
            ListTile(
              leading: Icon(Icons.phone),
              title: Text("+1234567890"),
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text("Account Settings"),
              onTap: () {
                // Navigate to settings
              },
            ),
            Spacer(),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: Text("Logout"),
            ),
          ],
        ),
      ),
    );
  }
}
