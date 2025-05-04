import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ProductDetailPage extends StatefulWidget {
  const ProductDetailPage({Key? key}) : super(key: key);

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  int _currentImageIndex = 0;
  final List<String> _productImages = [
    'https://store.storeimages.cdn-apple.com/4668/as-images.apple.com/is/ipad-10th-gen-finish-select-202212-blue-wifi?wid=2560&hei=1440&fmt=jpeg&qlt=95&.v=1670855855056',
    'https://store.storeimages.cdn-apple.com/4668/as-images.apple.com/is/ipad-10th-gen-storage-select-202212-blue-wifi?wid=4272&hei=2300&fmt=jpeg&qlt=95&.v=1670855850408',
    'https://store.storeimages.cdn-apple.com/4668/as-images.apple.com/is/ipad-10th-gen-storage-select-202212-blue-wifi?wid=4272&hei=2300&fmt=jpeg&qlt=95&.v=1670855850408',
  ];

  // Function to open Google Shopping search for iPad
  void _searchGoogleShopping() async {
    final Uri url = Uri.parse('https://www.google.com/search?q=iPad&tbm=shop');
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      debugPrint("Could not launch $url");
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions for responsive layout
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    
    // Determine if device is small based on screen width
    final isSmallDevice = screenWidth < 360;
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Container(
          margin: EdgeInsets.all(isSmallDevice ? 4 : 8),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade400),
            borderRadius: BorderRadius.circular(8),
          ),
          child: IconButton(
            icon: const Icon(Icons.chevron_left, color: Colors.black),
            onPressed: () => Navigator.pop(context),
            padding: EdgeInsets.zero,
            iconSize: isSmallDevice ? 18 : 24,
          ),
        ),
        title: Text(
          'ReBuy',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: isSmallDevice ? 20 : 24,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image Slider
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                SizedBox(
                  height: screenHeight * 0.28, // Responsive height
                  width: double.infinity,
                  child: PageView.builder(
                    itemCount: _productImages.length,
                    onPageChanged: (index) {
                      setState(() {
                        _currentImageIndex = index;
                      });
                    },
                    itemBuilder: (context, index) {
                      return Image.network(
                        _productImages[index],
                        fit: BoxFit.contain,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                  : null,
                            ),
                          );
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return Center(
                            child: Icon(Icons.image_not_supported, 
                              size: 50, color: Colors.grey),
                          );
                        },
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      _productImages.length,
                      (index) => Container(
                        width: 8,
                        height: 8,
                        margin: const EdgeInsets.symmetric(horizontal: 2),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _currentImageIndex == index
                              ? Colors.blue
                              : Colors.grey.withOpacity(0.5),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // Product Details
            Padding(
              padding: EdgeInsets.all(isSmallDevice ? 12.0 : 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title and Chat Button
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          'iPad (10th Generation)',
                          style: TextStyle(
                            fontSize: isSmallDevice ? 20 : 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.redAccent,
                        ),
                        child: IconButton(
                          icon: const Icon(
                            Icons.chat_bubble_outline,
                            color: Colors.white,
                          ),
                          onPressed: () {},
                          iconSize: isSmallDevice ? 18 : 24,
                          padding: EdgeInsets.all(isSmallDevice ? 8 : 12),
                          constraints: BoxConstraints(),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: isSmallDevice ? 4 : 8),

                  // Price
                  Text(
                    '₹ 42,999',
                    style: TextStyle(
                      fontSize: isSmallDevice ? 18 : 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal.shade700,
                    ),
                  ),

                  SizedBox(height: isSmallDevice ? 12 : 16),

                  // Description
                  Text(
                    'The redesigned iPad features an all-screen design with a 10.9-inch Liquid Retina display, A14 Bionic chip delivers powerful performance, USB-C connectivity, 12MP front and back cameras, and support for Apple Pencil...',
                    style: TextStyle(
                      fontSize: isSmallDevice ? 14 : 16,
                      color: Colors.grey.shade700,
                    ),
                  ),

                  SizedBox(height: isSmallDevice ? 12 : 16),

                  // Product Specifications - Made responsive for smaller screens
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      _buildSpecItem('Make:', 'Apple', isSmallDevice),
                      if (!isSmallDevice) Text('|', style: TextStyle(color: Colors.grey.shade700)),
                      _buildSpecItem('Year:', '2022', isSmallDevice),
                    ],
                  ),

                  SizedBox(height: isSmallDevice ? 8 : 12),

                  // Storage and Color Info
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      _buildSpecItem('Storage:', '64GB', isSmallDevice),
                      if (!isSmallDevice) Text('|', style: TextStyle(color: Colors.grey.shade700)),
                      _buildSpecItem('Color:', 'Blue', isSmallDevice),
                    ],
                  ),

                  SizedBox(height: isSmallDevice ? 8 : 12),

                  // Warranty and Packaging Info
                  Wrap(
                    spacing: 16,
                    runSpacing: 8,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Within Warranty ',
                            style: TextStyle(
                              fontSize: isSmallDevice ? 14 : 16,
                              color: Colors.grey.shade700,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              color: Colors.green,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.check,
                              size: isSmallDevice ? 12 : 14,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Original Packing ',
                            style: TextStyle(
                              fontSize: isSmallDevice ? 14 : 16,
                              color: Colors.grey.shade700,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              color: Colors.green,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.check,
                              size: isSmallDevice ? 12 : 14,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  SizedBox(height: isSmallDevice ? 16 : 20),

                  // Google Search Button
                  Center(
                    child: OutlinedButton.icon(
                      onPressed: _searchGoogleShopping,
                      icon: Image.network(
                        'https://www.google.com/images/branding/googlelogo/2x/googlelogo_color_92x30dp.png',
                        height: isSmallDevice ? 18 : 24,
                        errorBuilder: (context, error, stackTrace) {
                          return Icon(Icons.search, size: isSmallDevice ? 18 : 24);
                        },
                      ),
                      label: Text(
                        'Search Details',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: isSmallDevice ? 14 : 16,
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: Colors.grey.shade400),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: isSmallDevice ? 12 : 16,
                          vertical: isSmallDevice ? 8 : 12,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: isSmallDevice ? 16 : 20),

                  // Similar Products Label
                  Text(
                    'Similar products',
                    style: TextStyle(
                      fontSize: isSmallDevice ? 18 : 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: isSmallDevice ? 12 : 16),

                  // Similar Products Horizontal List
                  SizedBox(
                    height: screenWidth * 0.25, // Responsive height
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        _buildSimilarProductCard(
                          imageUrl: 'https://images.unsplash.com/photo-1557825835-70d97c4aa567?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                          isSmallDevice: isSmallDevice,
                        ),
                        SizedBox(width: isSmallDevice ? 8 : 12),
                        _buildSimilarProductCard(
                          imageUrl: 'https://store.storeimages.cdn-apple.com/4668/as-images.apple.com/is/ipad-pro-finish-select-202212-11inch-space-gray-wifi?wid=5120&hei=2880&fmt=jpeg&qlt=95&.v=1670865051385',
                          isSmallDevice: isSmallDevice,
                        ),
                        SizedBox(width: isSmallDevice ? 8 : 12),
                        _buildSimilarProductCard(
                          imageUrl: 'https://images.unsplash.com/photo-1587033411391-5d9e51cce126?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                          isSmallDevice: isSmallDevice,
                        ),
                      ],
                    ),
                  ),

                  // Add spacing at the bottom to avoid content being hidden by bottom bar
                  SizedBox(height: 80),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: isSmallDevice ? 50 : 60,
        child: Row(
          children: [
            Expanded(
              child: Container(
                color: Colors.grey.shade700,
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    'Save item',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: isSmallDevice ? 16 : 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.redAccent,
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    'Buy Now',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: isSmallDevice ? 16 : 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }