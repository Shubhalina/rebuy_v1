import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  // Replace with your Laravel API URL
  // final String _baseUrl = 'http://127.0.0.1:8000/api';  // 10.0.2.2 points to localhost when using Android emulator
  final String _baseUrl = 'http://localhost:8000/api';
  // For iOS simulator, use:
  // final String _baseUrl = 'http://127.0.0.1:8000/api';

  // Signup method
  Future<Map<String, dynamic>> signup({
    required String name,
    required String contact,
    required String address,
    required String email,
    required String password,
    required String passwordConfirmation,
  }) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/signup'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'name': name,
        'contact': contact,
        'address': address,
        'email': email,
        'password': password,
        'password_confirmation': passwordConfirmation,
      }),
    );

    return _handleResponse(response);
  }

  // Login method
  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
      }),
    );

    final responseData = _handleResponse(response);

    // If login successful, save token
    if (response.statusCode == 200 && responseData.containsKey('access_token')) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('auth_token', responseData['access_token']);
    }

    return responseData;
  }

  // Logout method
  Future<Map<String, dynamic>> logout() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');

    if (token == null) {
      return {'message': 'Not logged in'};
    }

    final response = await http.post(
      Uri.parse('$_baseUrl/logout'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );

    // Clear token regardless of response
    await prefs.remove('auth_token');

    return _handleResponse(response);
  }

  // Helper method to handle HTTP responses
  Map<String, dynamic> _handleResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return jsonDecode(response.body);
    } else {
      // For error responses, try to extract error messages
      try {
        final errorData = jsonDecode(response.body);
        return {
          'error': true,
          'message': errorData['message'] ?? 'Unknown error occurred',
          'errors': errorData['errors'] ?? {},
          'status': response.statusCode,
        };
      } catch (e) {
        return {
          'error': true,
          'message': 'Failed to connect to server',
          'status': response.statusCode,
        };
      }
    }
  }

  // Check if user is logged in
  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey('auth_token');
  }

  // Get the auth token
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

}