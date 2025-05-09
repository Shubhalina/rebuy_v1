import 'package:flutter/material.dart';
import 'package:rebuy_v1/presentation/screens/likedscreen/liked_items_screen.dart';
import 'package:rebuy_v1/presentation/auth/auth_service.dart';
import 'presentation/screens/auth/signup_page.dart';
import 'presentation/screens/auth/login_page.dart';
import 'presentation/screens/homescreen/home_screen.dart';
import 'presentation/screens/product_detail/product_detail_page.dart';
import 'presentation/screens/explore/explore_screen.dart';
import 'presentation/screens/chatscreen/chatscreen_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AuthService.initialize();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ReBuy App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.red,
          primary: Colors.red,
        ),
      ),
      initialRoute: '/login',
      routes: {
        '/': (context) => const SplashScreen(),
         '/login': (context) => const LoginPage(),
         '/signup': (context) => const SignupPage(),
        '/home': (context) => const HomeScreen(),
        '/product-detail': (context) => const ProductDetailPage(),
        '/explore': (context) => ExplorePage(),
        '/liked': (context) => LikedItemsScreen(),
        '/chat': (context) => ChatscreenPage(),
      },
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    checkAuth();
  }

  Future<void> checkAuth() async {
    final AuthService authService = AuthService();

    // Add a small delay for splash screen
    await Future.delayed(const Duration(seconds: 2));

    if (await authService.isLoggedIn()) {
      Navigator.of(context).pushReplacementNamed('/home');
    } else {
      Navigator.of(context).pushReplacementNamed('/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "ReBuy",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
            const SizedBox(height: 20),
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}