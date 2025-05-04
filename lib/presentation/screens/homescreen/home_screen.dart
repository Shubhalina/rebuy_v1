import 'package:flutter/material.dart';
import 'package:rebuy_v1/presentation/screens/sidebar/sidebar_page.dart';
import 'package:rebuy_v1/presentation/widgets/app_navigation.dart'; // Import the new navigation file

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onTabTapped(int index) {
    if (index == _currentIndex) return;

    setState(() {
      _currentIndex = index;
    });

    switch (index) {
      case 1:
        navigateToExplore(context);
        break;
      case 3:
        navigateToLiked(context);
        break;
      case 4:
        // Navigate to chat screen when implemented
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions to calculate responsive sizes
    final screenSize = MediaQuery.of(context).size;
    final textScaleFactor =
        MediaQuery.of(context).textScaleFactor; // Base on iPhone X width

    return Scaffold(
      body: SafeArea(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.white, Colors.grey.shade50],
                stops: const [0.7, 1.0],
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: screenSize.width * 0.04,
              ),
              child: ListView(
                children: [
                  const SizedBox(height: 16),

                  // Enhanced user profile and menu section
                  _buildUserProfileSection(textScaleFactor, context),

                  SizedBox(height: 24 * textScaleFactor),

                  // Enhanced search bar
                  _buildSearchBar(textScaleFactor),

                  SizedBox(height: 28 * textScaleFactor),

                  // New arrivals section with animation
                  _buildSectionHeader('New arrivals', textScaleFactor),

                  SizedBox(height: 12 * textScaleFactor),

                  // New arrivals horizontal list with enhanced cards
                  _buildNewArrivalsSection(
                    screenSize,
                    textScaleFactor,
                    context,
                  ),

                  SizedBox(height: 28 * textScaleFactor),

                  // Recently viewed section
                  _buildSectionHeader('Recently viewed', textScaleFactor),

                  SizedBox(height: 12 * textScaleFactor),

                  // Recently viewed horizontal list
                  _buildRecentlyViewedSection(
                    screenSize,
                    textScaleFactor,
                    context,
                  ),

                  // Add padding at the bottom for better UX
                  SizedBox(height: 24 * textScaleFactor),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: AppNavigation(
        currentIndex: _currentIndex,
        onTabTapped: _onTabTapped,
        textScaleFactor: textScaleFactor,
      ),
    );
  }

  Widget _buildUserProfileSection(
    double textScaleFactor,
    BuildContext context,
  ) {
    return Container(
      padding: EdgeInsets.all(16 * textScaleFactor),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16 * textScaleFactor),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 0,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.teal.shade300, width: 2),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.teal.withOpacity(0.2),
                      blurRadius: 8,
                      spreadRadius: 0,
                    ),
                  ],
                ),
                child: CircleAvatar(
                  radius: 26 * textScaleFactor,
                  backgroundImage: const NetworkImage(
                    'https://i.pravatar.cc/150?img=32',
                  ),
                ),
              ),
              SizedBox(width: 16 * textScaleFactor),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hey User',
                    style: TextStyle(
                      fontSize: 20 * textScaleFactor,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                  ),
                  SizedBox(height: 4 * textScaleFactor),
                  Text(
                    'Welcome back!',
                    style: TextStyle(
                      fontSize: 16 * textScaleFactor,
                      color: Colors.red[400],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MenuScreen()),
                );
              },
              borderRadius: BorderRadius.circular(12 * textScaleFactor),
              child: Container(
                padding: EdgeInsets.all(8 * textScaleFactor),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(12 * textScaleFactor),
                ),
                child: Icon(
                  Icons.menu,
                  color: Colors.grey[800],
                  size: 24 * textScaleFactor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar(double textScaleFactor) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16 * textScaleFactor),
      height: 55 * textScaleFactor,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25 * textScaleFactor),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.15),
            blurRadius: 10,
            spreadRadius: 0,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(Icons.search, color: Colors.teal, size: 22 * textScaleFactor),
          SizedBox(width: 12 * textScaleFactor),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search for books, guitar and more...',
                border: InputBorder.none,
                hintStyle: TextStyle(
                  color: Colors.grey[500],
                  fontSize: 15 * textScaleFactor,
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(6 * textScaleFactor),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(12 * textScaleFactor),
            ),
            child: Icon(
              Icons.tune,
              color: Colors.grey[700],
              size: 18 * textScaleFactor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, double textScaleFactor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              width: 4 * textScaleFactor,
              height: 20 * textScaleFactor,
              decoration: BoxDecoration(
                color: Colors.teal,
                borderRadius: BorderRadius.circular(4 * textScaleFactor),
              ),
            ),
            SizedBox(width: 8 * textScaleFactor),
            Text(
              title,
              style: TextStyle(
                fontSize: 19 * textScaleFactor,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
            ),
          ],
        ),
        TextButton(
          onPressed: () {},
          style: TextButton.styleFrom(
            backgroundColor: Colors.grey[100],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12 * textScaleFactor),
            ),
            padding: EdgeInsets.symmetric(
              horizontal: 12 * textScaleFactor,
              vertical: 6 * textScaleFactor,
            ),
          ),
          child: Text(
            'View more',
            style: TextStyle(
              color: Colors.teal,
              fontSize: 14 * textScaleFactor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNewArrivalsSection(
    Size screenSize,
    double textScaleFactor,
    BuildContext context,
  ) {
    return SizedBox(
      height: screenSize.height * 0.42,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/product-detail');
            },
            child: ProductCard(
              imageUrl:
                  'https://store.storeimages.cdn-apple.com/4668/as-images.apple.com/is/ipad-10th-gen-finish-select-202212-blue-wifi?wid=2560&hei=1440&fmt=jpeg&qlt=95&.v=1670855855056',
              title: 'iPad (10th Gen)',
              year: '2022',
              brand: 'Apple',
              price: '₹ 42,999',
              isFavorite: true,
              textScaleFactor: textScaleFactor,
            ),
          ),
          SizedBox(width: 16 * textScaleFactor),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/product-detail');
            },
            child: ProductCard(
              imageUrl:
                  'https://store.storeimages.cdn-apple.com/4668/as-images.apple.com/is/iphone-15-finish-select-202309-6-1inch-blue?wid=5120&hei=2880&fmt=p-jpg&qlt=80&.v=1692923777465',
              title: 'iPhone 15',
              year: '2023',
              brand: 'Apple',
              price: '₹ 79,900',
              isFavorite: false,
              textScaleFactor: textScaleFactor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentlyViewedSection(
    Size screenSize,
    double textScaleFactor,
    BuildContext context,
  ) {
    return SizedBox(
      height: screenSize.height * 0.2,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/ipad-detail');
            },
            child: RecentlyViewedCard(
              imageUrl:
                  'https://store.storeimages.cdn-apple.com/4668/as-images.apple.com/is/ipad-10th-gen-finish-select-202212-blue-wifi?wid=2560&hei=1440&fmt=jpeg&qlt=95&.v=1670855855056',
              title: 'iPad',
              isFavorite: true,
              textScaleFactor: textScaleFactor,
            ),
          ),
          SizedBox(width: 16 * textScaleFactor),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/product-detail');
            },
            child: RecentlyViewedCard(
              imageUrl:
                  'https://m.media-amazon.com/images/I/71EHw68EScL._AC_UF1000,1000_QL80_.jpg',
              title: 'Shure Microphone',
              isFavorite: false,
              textScaleFactor: textScaleFactor,
            ),
          ),
          SizedBox(width: 16 * textScaleFactor),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/product-detail');
            },
            child: RecentlyViewedCard(
              imageUrl:
                  'https://images.squarespace-cdn.com/content/5636c45ce4b04be29607ab8a/1598633568621-PJSS2CIDG3326BMDRM6K/DJI+Product+Release+History+Timeline.jpg?format=1500w&content-type=image%2Fjpeg',
              title: 'DJI Drone',
              isFavorite: true,
              textScaleFactor: textScaleFactor,
            ),
          ),
        ],
      ),
    );
  }
}

// ProductCard Widget - Enhanced version
class ProductCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String year;
  final String brand;
  final String price;
  final bool isFavorite;
  final double textScaleFactor;

  const ProductCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.year,
    required this.brand,
    required this.price,
    required this.isFavorite,
    required this.textScaleFactor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.6,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16 * textScaleFactor),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.15),
            blurRadius: 10,
            spreadRadius: 0,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product image with favorites icon
          Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16 * textScaleFactor),
                    topRight: Radius.circular(16 * textScaleFactor),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16 * textScaleFactor),
                    topRight: Radius.circular(16 * textScaleFactor),
                  ),
                  child: Image.network(
                    imageUrl,
                    height: 160 * textScaleFactor,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder:
                        (context, error, stackTrace) => Container(
                          height: 160 * textScaleFactor,
                          color: Colors.grey[200],
                          child: Icon(Icons.error, size: 40 * textScaleFactor),
                        ),
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Container(
                        height: 160 * textScaleFactor,
                        color: Colors.grey[200],
                        child: Center(child: CircularProgressIndicator()),
                      );
                    },
                  ),
                ),
              ),
              Positioned(
                top: 12 * textScaleFactor,
                right: 12 * textScaleFactor,
                child: Container(
                  padding: EdgeInsets.all(8 * textScaleFactor),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 4,
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                  child: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: isFavorite ? Colors.red : Colors.grey,
                    size: 18 * textScaleFactor,
                  ),
                ),
              ),
            ],
          ),

          // Product details
          Padding(
            padding: EdgeInsets.all(16 * textScaleFactor),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 17 * textScaleFactor,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 6 * textScaleFactor),
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today_outlined,
                      size: 14 * textScaleFactor,
                      color: Colors.grey[600],
                    ),
                    SizedBox(width: 6 * textScaleFactor),
                    Text(
                      year,
                      style: TextStyle(
                        fontSize: 14 * textScaleFactor,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 6 * textScaleFactor),
                Row(
                  children: [
                    Icon(
                      Icons.business,
                      size: 14 * textScaleFactor,
                      color: Colors.grey[600],
                    ),
                    SizedBox(width: 6 * textScaleFactor),
                    Text(
                      brand,
                      style: TextStyle(
                        fontSize: 14 * textScaleFactor,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12 * textScaleFactor),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      price,
                      style: TextStyle(
                        fontSize: 17 * textScaleFactor,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10 * textScaleFactor,
                        vertical: 6 * textScaleFactor,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.teal.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(
                          20 * textScaleFactor,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.shopping_cart_outlined,
                            size: 16 * textScaleFactor,
                            color: Colors.teal,
                          ),
                          SizedBox(width: 4 * textScaleFactor),
                          Text(
                            'Add',
                            style: TextStyle(
                              fontSize: 12 * textScaleFactor,
                              fontWeight: FontWeight.bold,
                              color: Colors.teal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// RecentlyViewedCard Widget - Enhanced version
class RecentlyViewedCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final bool isFavorite;
  final double textScaleFactor;

  const RecentlyViewedCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.isFavorite,
    required this.textScaleFactor,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: screenWidth * 0.4,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16 * textScaleFactor),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.15),
            blurRadius: 10,
            spreadRadius: 0,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product image with favorites icon
          Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16 * textScaleFactor),
                    topRight: Radius.circular(16 * textScaleFactor),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16 * textScaleFactor),
                    topRight: Radius.circular(16 * textScaleFactor),
                  ),
                  child: Image.network(
                    imageUrl,
                    height: 90 * textScaleFactor,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder:
                        (context, error, stackTrace) => Container(
                          height: 90 * textScaleFactor,
                          color: Colors.grey[200],
                          child: Icon(Icons.error, size: 30 * textScaleFactor),
                        ),
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Container(
                        height: 90 * textScaleFactor,
                        color: Colors.grey[200],
                        child: Center(child: CircularProgressIndicator()),
                      );
                    },
                  ),
                ),
              ),
              Positioned(
                top: 8 * textScaleFactor,
                right: 8 * textScaleFactor,
                child: Container(
                  padding: EdgeInsets.all(6 * textScaleFactor),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 4,
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                  child: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: isFavorite ? Colors.red : Colors.grey,
                    size: 14 * textScaleFactor,
                  ),
                ),
              ),
            ],
          ),

          // Product title
          Padding(
            padding: EdgeInsets.all(12 * textScaleFactor),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 15 * textScaleFactor,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 14 * textScaleFactor,
                  color: Colors.grey[500],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
