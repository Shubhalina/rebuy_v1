import 'package:flutter/material.dart';
import 'package:rebuy_v1/presentation/widgets/app_navigation.dart';

class LikedItemsScreen extends StatelessWidget {
  final List<Map<String, dynamic>> likedItems = [
    {
      "image": "assets/images/airpods.jpg",
      "title": "Apple AirPods Pro",
      "date": "21 Jan 2021",
      "price": "₹ 8,999",
    },
    {
      "image": "assets/images/jbl_speaker.jpg",
      "title": "JBL Charge 2 Speaker",
      "date": "20 Dec 2020",
      "price": "₹ 6,499",
    },
    {
      "image": "assets/images/controller.jpg",
      "title": "PlayStation Controller",
      "date": "14 Nov 2020",
      "price": "₹ 1,299",
    },
    {
      "image": "assets/images/bike.jpg",
      "title": "Nexus Mountain Bike",
      "date": "05 Oct 2020",
      "price": "₹ 9,100",
    },
    {
      "image": "assets/images/tent.jpg",
      "title": "Wildcraft Ranger Tent",
      "date": "30 Sep 2020",
      "price": "₹ 999",
    },
  ];

   LikedItemsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Since this is a Liked Items screen, we'll set the current index to 3 (favorite icon)
    final int currentIndex = 3;

    // Define the onTabTapped callback
    void onTabTapped(int index) {
      // This would typically navigate to different tabs
      // You might want to implement this based on your app's navigation logic
    }

    // Get the text scale factor from MediaQuery
    final double textScaleFactor = MediaQuery.of(context).textScaler.scale(1.0);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text("Liked items"),
        actions: [IconButton(icon: Icon(Icons.menu), onPressed: () {})],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: likedItems.length,
              itemBuilder: (context, index) {
                final item = likedItems[index];
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        item["image"],
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                    ),
                    title: Text(
                      item["title"],
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text("${item["date"]}\n${item["price"]}"),
                    trailing: Icon(Icons.favorite, color: Colors.red),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(icon: Icon(Icons.arrow_back_ios), onPressed: () {}),
                Text("1  2"),
                IconButton(
                  icon: Icon(Icons.arrow_forward_ios),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: AppNavigation(
        currentIndex: currentIndex,
        onTabTapped: onTabTapped,
        textScaleFactor: textScaleFactor,
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(home: LikedItemsScreen()));
}
