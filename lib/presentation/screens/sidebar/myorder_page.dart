import 'package:flutter/material.dart';

class MyOrderPage extends StatelessWidget {
  final List<Map<String, dynamic>> orders = [
    {
      "image": "assets/airpods_pro.jpg",
      "title": "Apple AirPods Pro",
      "date": "21 Jan 2021",
      "price": "₹ 8,999",
      "rateNow": true,
    },
    {
      "image": "assets/jbl_speaker.jpg",
      "title": "JBL Charge 2 Speaker",
      "date": "20 Dec 2020",
      "price": "₹ 6,499",
      "rated": 5,
    },
    {
      "image": "assets/ps_controller.jpg",
      "title": "PlayStation Controller",
      "date": "14 Nov 2020",
      "price": "₹ 1,299",
      "rateNow": true,
    },
    {
      "image": "assets/nexus_bike.jpg",
      "title": "Nexus Mountain Bike",
      "date": "05 Oct 2020",
      "price": "₹ 9,100",
      "rateNow": true,
    },
    {
      "image": "assets/wildcraft_tent.jpg",
      "title": "Wildcraft Ranger Tent",
      "date": "30 Sep 2020",
      "price": "₹ 999",
      "rateNow": true,
    },
  ];

  MyOrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Orders", style: TextStyle(fontWeight: FontWeight.bold)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back), 
          onPressed: () {
            Navigator.pop(context);
          }
        ),
        actions: [IconButton(icon: Icon(Icons.menu), onPressed: () {})],
      ),
      body: ListView.builder(
        itemCount: orders.length,
        itemBuilder: (context, index) {
          final order = orders[index];
          return Card(
            color: Colors.blue[100],
            child: ListTile(
              leading: _buildOrderImage(order['image']),
              title: Text(order['title'], style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text("${order['date']}\n${order['price']}",
                  style: TextStyle(color: Colors.black54)),
              trailing: order.containsKey('rated')
                  ? Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("You rated ${order['rated']}", style: TextStyle(fontSize: 12)),
                        Icon(Icons.star, color: Colors.yellow, size: 16),
                      ],
                    )
                  : ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
                      onPressed: () {},
                      child: Text("Rate now", style: TextStyle(color: Colors.white)),
                    ),
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
            SizedBox(width: 40),
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
  
  Widget _buildOrderImage(String imagePath) {
    try {
      return Image.asset(
        imagePath, 
        width: 50, 
        height: 50, 
        fit: BoxFit.cover
      );
    } catch (e) {
      // Fallback if image not found
      return Container(
        width: 50,
        height: 50,
        color: Colors.grey[300],
        child: Icon(Icons.image_not_supported, color: Colors.grey[700]),
      );
    }
  }
}