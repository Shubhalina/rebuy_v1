import 'package:flutter/material.dart';
import 'package:rebuy_v1/presentation/screens/explore/explore_screen.dart';
import 'package:rebuy_v1/presentation/screens/likedscreen/liked_items_screen.dart';
import 'package:image_picker/image_picker.dart';  // Add this import

class AppNavigation extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTabTapped;
  final double textScaleFactor;
  
  const AppNavigation({
    super.key,
    required this.currentIndex,
    required this.onTabTapped,
    required this.textScaleFactor,
  });
  
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70 * textScaleFactor,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20 * textScaleFactor),
          topRight: Radius.circular(20 * textScaleFactor),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 10,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(Icons.home, 'Home', 0),
          _buildNavItem(Icons.alternate_email, 'Explore', 1),
          _buildCameraButton(context),
          _buildNavItem(Icons.favorite_border, 'Favorites', 3),
          _buildNavItem(Icons.chat_bubble_outline, 'Chat', 4),
        ],
      ),
    );
  }
  
  Widget _buildNavItem(IconData icon, String label, int index) {
    final bool isSelected = currentIndex == index;
    return InkWell(
      onTap: () => onTabTapped(index),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: isSelected ? Colors.teal : Colors.grey,
            size: 24 * textScaleFactor,
          ),
          SizedBox(height: 4 * textScaleFactor),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.teal : Colors.grey,
              fontSize: 12 * textScaleFactor,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildCameraButton(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
      ),
      child: Padding(
        padding: EdgeInsets.all(8.0 * textScaleFactor),
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.teal.shade300, Colors.teal.shade700],
            ),
          ),
          child: IconButton(
            icon: Icon(
              Icons.camera_alt,
              color: Colors.white,
              size: 24 * textScaleFactor,
            ),
            onPressed: () => _openCamera(context),
          ),
        ),
      ),
    );
  }
  
  // New method to handle camera functionality
  Future<void> _openCamera(BuildContext context) async {
    final ImagePicker picker = ImagePicker();
    
    try {
      final XFile? photo = await picker.pickImage(source: ImageSource.camera);
      if (photo != null) {
        // Handle the captured image
        // You can navigate to a new screen with the image or process it
        _handleCapturedImage(context, photo);
      }
    } catch (e) {
      // Show error dialog if camera access fails
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Camera Error'),
            content: Text('Unable to access camera. Please check permissions.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }
  
  // Method to handle the captured image
  void _handleCapturedImage(BuildContext context, XFile image) {
    // You could navigate to an image preview/edit screen here
    // For example:
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ImagePreviewScreen(imageFile: image),
      ),
    );
    
    // Or you could also still call the tab navigation if needed
    // onTabTapped(2);
  }
}

// Example of a simple image preview screen
class ImagePreviewScreen extends StatelessWidget {
  final XFile imageFile;
  
  const ImagePreviewScreen({super.key, required this.imageFile});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Preview'),
        actions: [
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () {
              // Handle image confirmation/saving
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Center(
        child: Image.network(imageFile.path),
      ),
    );
  }
}

// Helper methods for navigation
void navigateToExplore(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => ExplorePage()),
  );
}

void navigateToLiked(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => LikedItemsScreen()),
  );
}