import 'package:flutter/material.dart';
import 'package:rebuy_v1/presentation/screens/homescreen/home_screen.dart';
import 'package:rebuy_v1/presentation/screens/sidebar/sidebar_page.dart';
import 'package:rebuy_v1/presentation/screens/likedscreen/liked_items_screen.dart';
import 'package:rebuy_v1/presentation/widgets/app_navigation.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  int _currentIndex = 1; // Set to 1 since this is the Explore/Search page

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });

    // Handle navigation based on the selected tab
    if (index == 0) {
      Navigator.of(
        context,
      ).push(MaterialPageRoute(builder: (context) => const HomeScreen()));
    } else if (index == 3) {
      Navigator.of(
        context,
      ).push(MaterialPageRoute(builder: (context) => LikedItemsScreen()));
    }
    // Add other navigation options as needed
  }

  @override
  Widget build(BuildContext context) {
    final textScaleFactor = MediaQuery.of(context).textScaleFactor;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Top navigation bar
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 12.0,
              ),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade400),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.chevron_left),
                      onPressed: () {},
                      constraints: const BoxConstraints.tightFor(
                        width: 40,
                        height: 40,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  const Text(
                    'Explore',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF333333),
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.menu),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MenuScreen()),
                      );
                    },
                  ),
                ],
              ),
            ),

            // Search bar
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(24),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    const Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Search for books, guitar and more...',
                          border: InputBorder.none,
                          hintStyle: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.search, color: Colors.grey),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ),

            // Category buttons
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    const SizedBox(width: 16),
                    _buildCategoryButton('Books', true),
                    const SizedBox(width: 8),
                    _buildCategoryButton('Game', false),
                    const SizedBox(width: 8),
                    _buildCategoryButton('Music', false),
                    const SizedBox(width: 8),
                    _buildCategoryButton('Camera', false),
                    const SizedBox(width: 16),
                  ],
                ),
              ),
            ),

            // Product listings
            Expanded(
              child: ListView(
                padding: const EdgeInsets.only(top: 8.0),
                children: [
                  _buildProductCard(
                    'Cordoba Mini Guitar',
                    'Make: Cordoba | Year: 2020',
                    '₹ 25,000',
                    'assets/images/guitar.jpg',
                    'Cliff Hanger',
                    'El Dorado',
                  ),
                  _buildProductCard(
                    'Nikon DSLR Camera',
                    'Make: Nikon | Year: 2022',
                    '₹ 45,000',
                    'assets/images/camera.jpg',
                    'Frank N. Stein',
                    'Shangri La',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: AppNavigation(
        currentIndex: _currentIndex,
        onTabTapped: _onTabTapped,
        textScaleFactor: textScaleFactor,
      ),
    );
  }

  Widget _buildCategoryButton(String label, bool isSelected) {
    return Container(
      decoration: BoxDecoration(
        color: isSelected ? Colors.black : Colors.grey.shade800,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildProductCard(
    String title,
    String subtitle,
    String price,
    String imageAsset,
    String sellerName,
    String sellerLocation,
  ) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Seller info
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 16,
                  backgroundColor: Colors.grey.shade300,
                  child: Text(
                    sellerName.substring(0, 1),
                    style: const TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      sellerName,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      sellerLocation,
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                const Icon(Icons.more_vert),
              ],
            ),
          ),

          // Product image
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(color: Colors.grey.shade200),
                child: Image.asset(
                  imageAsset,
                  fit: BoxFit.contain,
                  errorBuilder:
                      (context, error, stackTrace) => Container(
                        color:
                            title.contains('Guitar')
                                ? const Color(0xFFE6D7DE)
                                : Colors.grey.shade300,
                        child: Center(
                          child:
                              title.contains('Guitar')
                                  ? Image.network(
                                    'https://images.unsplash.com/photo-1558098329-a11cff621064?q=80&w=2790&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                                    fit: BoxFit.contain,
                                  )
                                  : const Icon(
                                    Icons.camera_alt,
                                    size: 50,
                                    color: Colors.grey,
                                  ),
                        ),
                      ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: Icon(
                      Icons.favorite_border,
                      color: Colors.red.shade400,
                    ),
                    onPressed: () {},
                  ),
                ),
              ),
            ],
          ),

          // Product info
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  price,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
