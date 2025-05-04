import 'package:flutter/material.dart';
import 'category_products_screen.dart';

class CategoriesScreen extends StatelessWidget {
  final List<String> categories = ["Electronics", "Clothing", "Books", "Furniture"];

   CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Categories")),
      body: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(categories[index], style: TextStyle(fontSize: 18)),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CategoryProductsScreen(category: categories[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
