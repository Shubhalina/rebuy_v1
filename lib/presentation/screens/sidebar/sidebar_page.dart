import 'package:flutter/material.dart';
import 'package:rebuy_v1/presentation/screens/sidebar/myaccount_page.dart';
import 'package:rebuy_v1/presentation/screens/sidebar/mylistings_page.dart';
import 'package:rebuy_v1/presentation/screens/sidebar/myorder_page.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "ReBuy",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
            SizedBox(height: 40),
            MenuItem(
              icon: Icons.person_outline,
              title: "My Account",
              subtitle: "Edit your details, account settings",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyAccountPage()),
                );
              },
            ),
            MenuItem(
              icon: Icons.shopping_bag_outlined,
              title: "My Orders",
              subtitle: "View all your orders",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyOrderPage()),
                );
              },
            ),
            MenuItem(
              icon: Icons.list,
              title: "My Listings",
              subtitle: "View your product listing for sale",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyListingsPage()),
                );
              },
            ),
            MenuItem(
              icon: Icons.favorite_border,
              title: "Liked Items",
              subtitle: "See the products you have wishlisted",
              onTap: () {
                // Assuming you'll create a LikedItemsPage later
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => LikedItemsPage()),
                // );
                // For now, you can show a snackbar
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Liked Items page coming soon')),
                );
              },
            ),
            Spacer(),
            // Rest of your code remains the same
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  ),
                  child: Text("Feedback", style: TextStyle(fontSize: 16)),
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    backgroundColor: Colors.black,
                  ),
                  child: Text(
                    "Sign out",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Center(
              child: Text(
                "ReBuy Inc. Version 1.0",
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;  // Add this callback

  const MenuItem({super.key, 
    required this.icon, 
    required this.title, 
    required this.subtitle,
    required this.onTap,  // Make it required
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(  // Wrap with GestureDetector
      onTap: onTap,  // Call the callback when tapped
      child: Container(
        margin: EdgeInsets.only(bottom: 15),
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Icon(icon, size: 28, color: Colors.black54),
            SizedBox(width: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  subtitle,
                  style: TextStyle(fontSize: 14, color: Colors.black54),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}