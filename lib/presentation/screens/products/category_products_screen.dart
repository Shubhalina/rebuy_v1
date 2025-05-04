import 'package:flutter/material.dart';
import 'product_detail_screen.dart';

class CategoryProductsScreen extends StatelessWidget {
  final String category;

  CategoryProductsScreen({super.key, required this.category});

  final List<Map<String, String>> allProducts = [
    {"title": "iPhone 13", "price": "\$800", "image": "https://via.placeholder.com/150", "category": "Electronics"},
    {"title": "MacBook Pro", "price": "\$1200", "image": "https://via.placeholder.com/150", "category": "Electronics"},
    {"title": "T-Shirt", "price": "\$20", "image": "https://via.placeholder.com/150", "category": "Clothing"},
    {"title": "Java Programming", "price": "\$15", "image": "https://via.placeholder.com/150", "category": "Books"},
    {"title": "Dining Table", "price": "\$300", "image": "https://via.placeholder.com/150", "category": "Furniture"},
  ];

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> filteredProducts =
    allProducts.where((product) => product["category"] == category).toList();

    return Scaffold(
      appBar: AppBar(title: Text(category)),
      body: filteredProducts.isEmpty
          ? Center(child: Text("No products found in this category"))
          : GridView.builder(
        padding: EdgeInsets.all(10),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.8,
        ),
        itemCount: filteredProducts.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDetailScreen(product: filteredProducts[index]),
                ),
              );
            },
            child: Card(
              child: Column(
                children: [
                  Image.network(filteredProducts[index]["image"]!, height: 100, fit: BoxFit.cover),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(filteredProducts[index]["title"]!,
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                  Text(filteredProducts[index]["price"]!,
                      style: TextStyle(fontSize: 16, color: Colors.green)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
