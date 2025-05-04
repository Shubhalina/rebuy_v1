import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ProductDetailPage extends StatefulWidget {
  const ProductDetailPage({super.key});

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

  void _searchGoogleShopping() async {
    final Uri url = Uri.parse('https://www.google.com/search?q=iPad&tbm=shop');
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      debugPrint("Could not launch $url");
    }
  }

  // Responsive scaling functions
  double getScaleFactor(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return width / 375.0;
  }

  double getResponsiveFontSize(BuildContext context, double baseSize) {
    double scaleFactor = getScaleFactor(context);
    scaleFactor = scaleFactor.clamp(0.8, 1.5);
    return baseSize * scaleFactor;
  }

  double getResponsivePadding(BuildContext context, double basePadding) {
    return basePadding * getScaleFactor(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Container(
          margin: EdgeInsets.all(getResponsivePadding(context, 8)),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade400),
            borderRadius: BorderRadius.circular(8),
          ),
          child: IconButton(
            icon: const Icon(Icons.chevron_left, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        title: Text(
          'ReBuy',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: getResponsiveFontSize(context, 24),
          ),
        ),
        centerTitle: true,
      ),
      body: OrientationBuilder(
        builder: (context, orientation) {
          if (orientation == Orientation.landscape) {
            return Row(
              children: [
                Expanded(
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      PageView.builder(
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
                          );
                        },
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: getResponsivePadding(context, 10)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            _productImages.length,
                                (index) => Container(
                              width: 8,
                              height: 8,
                              margin: EdgeInsets.symmetric(horizontal: 2),
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
                ),
                Expanded(
                  child: _buildProductDetails(context),
                ),
              ],
            );
          } else {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.3,
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
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: getResponsivePadding(context, 10)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          _productImages.length,
                              (index) => Container(
                            width: 8,
                            height: 8,
                            margin: EdgeInsets.symmetric(horizontal: 2),
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
                Expanded(
                  child: _buildProductDetails(context),
                ),
              ],
            );
          }
        },
      ),
      bottomNavigationBar: SizedBox(
        height: getResponsivePadding(context, 60),
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
                      fontSize: getResponsiveFontSize(context, 18),
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
                      fontSize: getResponsiveFontSize(context, 18),
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

  Widget _buildProductDetails(BuildContext context) {
    double cardWidth = MediaQuery.of(context).size.width * 0.3;
    double cardHeight = cardWidth * (100 / 140); // Maintain original aspect ratio

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(getResponsivePadding(context, 16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    'iPad (10th Generation)',
                    style: TextStyle(
                      fontSize: getResponsiveFontSize(context, 24),
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
                  ),
                ),
              ],
            ),
            SizedBox(height: getResponsivePadding(context, 8)),
            Text(
              '₹ 42,999',
              style: TextStyle(
                fontSize: getResponsiveFontSize(context, 22),
                fontWeight: FontWeight.bold,
                color: Colors.teal.shade700,
              ),
            ),
            SizedBox(height: getResponsivePadding(context, 16)),
            Text(
              'The redesigned iPad features an all-screen design with a 10.9-inch Liquid Retina display, A14 Bionic chip delivers powerful performance, USB-C connectivity, 12MP front and back cameras, and support for Apple Pencil...',
              style: TextStyle(
                fontSize: getResponsiveFontSize(context, 16),
                color: Colors.grey.shade700,
              ),
            ),
            SizedBox(height: getResponsivePadding(context, 16)),
            Row(
              children: [
                Text(
                  'Make: ',
                  style: TextStyle(
                    fontSize: getResponsiveFontSize(context, 16),
                    color: Colors.grey.shade700,
                  ),
                ),
                Text(
                  'Apple',
                  style: TextStyle(
                    fontSize: getResponsiveFontSize(context, 16),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: getResponsivePadding(context, 8)),
                Text(
                  '|',
                  style: TextStyle(
                    fontSize: getResponsiveFontSize(context, 16),
                    color: Colors.grey.shade700,
                  ),
                ),
                SizedBox(width: getResponsivePadding(context, 8)),
                Text(
                  'Year: ',
                  style: TextStyle(
                    fontSize: getResponsiveFontSize(context, 16),
                    color: Colors.grey.shade700,
                  ),
                ),
                Text(
                  '2022',
                  style: TextStyle(
                    fontSize: getResponsiveFontSize(context, 16),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: getResponsivePadding(context, 12)),
            Row(
              children: [
                Text(
                  'Storage: ',
                  style: TextStyle(
                    fontSize: getResponsiveFontSize(context, 16),
                    color: Colors.grey.shade700,
                  ),
                ),
                Text(
                  '64GB',
                  style: TextStyle(
                    fontSize: getResponsiveFontSize(context, 16),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: getResponsivePadding(context, 8)),
                Text(
                  '|',
                  style: TextStyle(
                    fontSize: getResponsiveFontSize(context, 16),
                    color: Colors.grey.shade700,
                  ),
                ),
                SizedBox(width: getResponsivePadding(context, 8)),
                Text(
                  'Color: ',
                  style: TextStyle(
                    fontSize: getResponsiveFontSize(context, 16),
                    color: Colors.grey.shade700,
                  ),
                ),
                Text(
                  'Blue',
                  style: TextStyle(
                    fontSize: getResponsiveFontSize(context, 16),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: getResponsivePadding(context, 12)),
            Row(
              children: [
                Text(
                  'Within Warranty ',
                  style: TextStyle(
                    fontSize: getResponsiveFontSize(context, 16),
                    color: Colors.grey.shade700,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check,
                    size: 14,
                    color: Colors.white,
                  ),
                ),
                SizedBox(width: getResponsivePadding(context, 16)),
                Text(
                  'Original Packing ',
                  style: TextStyle(
                    fontSize: getResponsiveFontSize(context, 16),
                    color: Colors.grey.shade700,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check,
                    size: 14,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            SizedBox(height: getResponsivePadding(context, 20)),
            OutlinedButton.icon(
              onPressed: _searchGoogleShopping,
              icon: Image.network(
                'https://www.google.com/images/branding/googlelogo/2x/googlelogo_color_92x30dp.png',
                height: getResponsiveFontSize(context, 24),
              ),
              label: Text(
                'Search Details',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: getResponsiveFontSize(context, 16),
                ),
              ),
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: Colors.grey.shade400),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
            SizedBox(height: getResponsivePadding(context, 20)),
            Text(
              'Similar products',
              style: TextStyle(
                fontSize: getResponsiveFontSize(context, 20),
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: getResponsivePadding(context, 16)),
            SizedBox(
              height: cardHeight,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _buildSimilarProductCard(
                    imageUrl: 'https://images.unsplash.com/photo-1557825835-70d97c4aa567?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                    width: cardWidth,
                    height: cardHeight,
                  ),
                  SizedBox(width: getResponsivePadding(context, 12)),
                  _buildSimilarProductCard(
                    imageUrl: 'https://store.storeimages.cdn-apple.com/4668/as-images.apple.com/is/ipad-pro-finish-select-202212-11inch-space-gray-wifi?wid=5120&hei=2880&fmt=jpeg&qlt=95&.v=1670865051385',
                    width: cardWidth,
                    height: cardHeight,
                  ),
                  SizedBox(width: getResponsivePadding(context, 12)),
                  _buildSimilarProductCard(
                    imageUrl: 'https://images.unsplash.com/photo-1587033411391-5d9e51cce126?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                    width: cardWidth,
                    height: cardHeight,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSimilarProductCard({
    required String imageUrl,
    required double width,
    required double height,
  }) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(9),
        child: Image.network(
          imageUrl,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}