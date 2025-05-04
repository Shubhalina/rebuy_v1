import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final SupabaseClient _supabase = Supabase.instance.client;
  // Initialize Supabase
 static Future<void> initialize() async {
    await Supabase.initialize(
      url: 'https://rjqavgdehdvrrjxovlqt.supabase.co',
      anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InJqcWF2Z2RlaGR2cnJqeG92bHF0Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDYxODQ2MjUsImV4cCI6MjA2MTc2MDYyNX0.NHRzW-ubHkacGvbQnp4hbxdSi5ZA2VdgUa-i-6GX1Z4',
    );
  }

  // Sign Up User
  Future<Map<String, dynamic>> signup({
    required String name,
    required String contact,
    required String address,
    required String email,
    required String password,
    required String passwordConfirmation,
  }) async {
    try {
      // Validate input
      if (password != passwordConfirmation) {
        return {
          'error': true,
          'message': 'Passwords do not match',
        };
      }

      // Register user with Supabase Auth
      final response = await _supabase.auth.signUp(
        email: email,
        password: password,
      );

      if (response.user == null) {
        return {
          'error': true,
          'message': 'Failed to create account',
        };
      }

      // Store additional user data in Supabase
      await _supabase.from('users').insert({
        'id': response.user!.id,
        'name': name,
        'contact': contact,
        'address': address,
        'email': email,
        'created_at': DateTime.now().toIso8601String(),
      });

      return {
        'error': false,
        'message': 'Account created successfully!',
        'user': response.user,
      };
    } catch (e) {
      if (e is AuthException) {
        return {
          'error': true,
          'message': e.message,
        };
      }
      return {
        'error': true,
        'message': 'An unexpected error occurred: ${e.toString()}',
      };
    }
  }

  // Sign In User
  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (response.user == null) {
        return {
          'error': true,
          'message': 'Invalid credentials',
        };
      }

      return {
        'error': false,
        'message': 'Login successful',
        'user': response.user,
      };
    } catch (e) {
      if (e is AuthException) {
        return {
          'error': true,
          'message': e.message,
        };
      }
      return {
        'error': true,
        'message': 'An unexpected error occurred: ${e.toString()}',
      };
    }
  }

  // Sign Out User
  Future<void> signOut() async {
    await _supabase.auth.signOut();
  }

  // Get current user
  User? getCurrentUser() {
    return _supabase.auth.currentUser;
  }

  // Check if user is logged in
  bool isLoggedIn() {
    return _supabase.auth.currentUser != null;
  }

  // Password Reset
  Future<Map<String, dynamic>> resetPassword(String email) async {
    try {
      await _supabase.auth.resetPasswordForEmail(email);
      return {
        'error': false,
        'message': 'Password reset email sent',
      };
    } catch (e) {
      return {
        'error': true,
        'message': 'Failed to send password reset email: ${e.toString()}',
      };
    }
  }
}