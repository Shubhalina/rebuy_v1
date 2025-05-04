import 'package:flutter/material.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePage()), // Make sure this matches the class name exactly
            );
          },
          child: Text('Open Chat'),
        ),
      ),
    );
  }
}


class ChatscreenPage extends StatelessWidget {
  final List<Map<String, dynamic>> messages = [
    {
      "image": "assets/user1.jpg",
      "title": "DJI Mavic Mini 2 | Paul Molive",
      "message": "You: Does it come with an additional battery?",
      "time": "9:03 AM",
      "online": true,
    },
    {
      "image": "assets/user2.jpg",
      "title": "DJI Mavic Mini 2 | Petey Cruiser",
      "message": "Petey: Sorry, I’m unlisting it",
      "time": "Yesterday 4:12 PM",
      "online": false,
    },
    {
      "image": "assets/user3.jpg",
      "title": "DJI Mavic Air 2 | Anna Sthesia",
      "message": "Anna: I think you should go with Mavic Mini",
      "time": "15 Feb 21, 9:30 PM",
      "online": true,
    },
    {
      "image": "assets/user4.jpg",
      "title": "Apple AirPods Pro | Bob Frapples",
      "message": "Bob: You’re welcome",
      "time": "25 Jan 21, 10:30 AM",
      "online": false,
    },
    {
      "image": "assets/user5.jpg",
      "title": "JBL Charge 2 Speaker | Greta Life",
      "message": "Greta: Alright",
      "time": "20 Dec 20, 9:23 AM",
      "online": true,
      "unread": 1,
    },
    {
      "image": "assets/user6.jpg",
      "title": "PlayStation Controller | Ira Membrik",
      "message": "You: 👍",
      "time": "16 Nov 20, 7:53 AM",
      "online": true,
    },
  ];

  ChatscreenPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Messages", style: TextStyle(fontWeight: FontWeight.bold)),
        leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: () {}),
        actions: [IconButton(icon: Icon(Icons.menu), onPressed: () {})],
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(10.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search in messages",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final msg = messages[index];
                return ListTile(
                  leading: Stack(
                    children: [
                      CircleAvatar(
                        radius: 24,
                        backgroundImage: AssetImage(msg['image']),
                      ),
                      if (msg['online'])
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: CircleAvatar(
                            radius: 6,
                            backgroundColor: Colors.green,
                          ),
                        ),
                    ],
                  ),
                  title: Text(msg['title'],
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                  subtitle: Text(msg['message'],
                      style: TextStyle(color: Colors.black54, fontSize: 13)),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(msg['time'], style: TextStyle(fontSize: 12)),
                      if (msg.containsKey('unread'))
                        CircleAvatar(
                          radius: 10,
                          backgroundColor: Colors.red,
                          child: Text("${msg['unread']}",
                              style: TextStyle(color: Colors.white, fontSize: 12)),
                        ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
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
            IconButton(icon: Icon(Icons.chat_bubble_outline, color: Colors.blue), onPressed: () {}),
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
