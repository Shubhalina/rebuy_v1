import 'package:flutter/material.dart';

class ProductDetailScreen extends StatelessWidget {
  final Map<String, String> product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(product["title"]!)),
      body: Column(
        children: [
          Image.network(product["image"]!, height: 200, fit: BoxFit.cover),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(product["title"]!, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                SizedBox(height: 10),
                Text(product["price"]!, style: TextStyle(fontSize: 22, color: Colors.green)),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(minimumSize: Size(double.infinity, 50)),
                  child: Text("Buy Now"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
