import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rebuy_v1/presentation/services/auth_service.dart'; // Update with actual package name

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService _authService = AuthService();

  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      try {
        final response = await _authService.login(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );

        setState(() => _isLoading = false);

        if (response.containsKey('error') && response['error'] == true) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(response['message'] ?? 'Login failed')),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Login successful')),
          );
          Navigator.of(context).pushReplacementNamed('/home');
        }
      } catch (e) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${e.toString()}')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Back Button
            IconButton(
              icon: const Icon(Icons.arrow_back, size: 30),
              onPressed: () => Navigator.pop(context),
            ),

            const SizedBox(height: 10),

            // App Logo or Title
            const Center(
              child: Text(
                "ReBuy",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Title
            const Text(
              "Log in",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 8),
            const SizedBox(height: 16),
            const SizedBox(height: 20),
            const SizedBox(height: 20),

            // Form
            Form(
              key: _formKey,
              child: Column(
                children: [
                  _buildTextField("Email", _emailController, false),
                  const SizedBox(height: 12),
                  _buildTextField("Password", _passwordController, true),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Login Button
            _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _buildLoginButton(),

            const SizedBox(height: 20),

            // Sign up link
            Center(
              child: GestureDetector(
                onTap: () => Navigator.pushNamed(context, '/signup'),
                child: const Text.rich(
                  TextSpan(
                    text: "Don’t have an account? ",
                    style: TextStyle(color: Colors.grey),
                    children: [
                      TextSpan(
                        text: "Sign up",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Social Media Login Buttons
  Widget _buildSocialButton(String assetPath) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        shape: BoxShape.circle,
      ),
      child: SvgPicture.asset(assetPath, width: 30),
    );
  }

  // Reusable Text Field
  Widget _buildTextField(
      String hint, TextEditingController controller, bool isPassword) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.grey.shade200,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your $hint';
        }
        return null;
      },
    );
  }

  // Gradient Login Button
  Widget _buildLoginButton() {
    return GestureDetector(
      onTap: _login,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Colors.red, Colors.pink],
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Center(
          child: Text(
            "Log in",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
      ),
    );
  }
}
