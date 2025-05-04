import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyListingsPage(),
    );
  }
}

class MyListingsPage extends StatelessWidget {
  final List<Map<String, dynamic>> listings = [
    {
      "image": "assets/jabra_earbuds.jpg",
      "title": "Jabra Wireless Earbuds",
      "views": "1K",
      "messages": 3,
      "price": "₹ 8,999",
      "date": "03 May 2021",
      "status": "active",
    },
    {
      "image": "assets/macbook_air.jpg",
      "title": "MacBook Air",
      "views": "1.8K",
      "messages": 1,
      "price": "₹ 45,499",
      "date": "20 Apr 2021",
      "status": "active",
    },
    {
      "image": "assets/amazon_alexa.jpg",
      "title": "Amazon Alexa",
      "views": "2.2K",
      "messages": 0,
      "price": "₹ 999",
      "date": "14 Apr 2021",
      "status": "active",
    },
    {
      "image": "assets/lg_monitor.jpg",
      "title": "LG Monitor",
      "views": "2.6K",
      "messages": 0,
      "price": "₹ 9,100",
      "date": "13 Apr 2021",
      "status": "hidden",
    },
    {
      "image": "assets/google_home_mini.jpg",
      "title": "Google Home Mini",
      "views": "3.5K",
      "messages": 0,
      "price": "₹ 1,299",
      "date": "12 Apr 2021",
      "status": "sold",
    },
  ];

  MyListingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Listings", style: TextStyle(fontWeight: FontWeight.bold)),
        leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: () {}),
        actions: [IconButton(icon: Icon(Icons.menu), onPressed: () {})],
      ),
      body: ListView.builder(
        itemCount: listings.length,
        itemBuilder: (context, index) {
          final item = listings[index];
          return Card(
            color: item['status'] == 'hidden'
                ? Colors.grey[300]
                : item['status'] == 'sold'
                ? Colors.green[100]
                : Colors.blue[100],
            child: ListTile(
              leading: Image.asset(item['image'], width: 50, height: 50, fit: BoxFit.cover),
              title: Text(item['title'], style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text("Views: ${item['views']}\n${item['price']}    ${item['date']}",
                  style: TextStyle(color: Colors.black54)),
              trailing: item['status'] == 'sold'
                  ? Icon(Icons.check_circle, color: Colors.green)
                  : item['status'] == 'hidden'
                  ? Icon(Icons.remove_red_eye, color: Colors.grey)
                  : Icon(Icons.visibility_off, color: Colors.grey),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 10.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(icon: Icon(Icons.home), onPressed: () {}),
            IconButton(icon: Icon(Icons.favorite_border), onPressed: () {}),
            SizedBox(width: 40), // For the floating action button space
            IconButton(icon: Icon(Icons.chat_bubble_outline), onPressed: () {}),
            IconButton(icon: Icon(Icons.person_outline), onPressed: () {}),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.camera_alt),
        onPressed: () {},
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
