import 'package:flutter/material.dart';
// import 'package:orbit/presentation/services/auth_service.dart';
import 'auth_service.dart';

class AuthGuard extends StatefulWidget {
  final Widget child;
  const AuthGuard({super.key, required this.child});

  @override
  State<AuthGuard> createState() => _AuthGuardState();
}

class _AuthGuardState extends State<AuthGuard> {
  final AuthService _authService = AuthService();
  bool _isAuthenticated = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _checkAuth();
  }

  Future<void> _checkAuth() async {
    final isLoggedIn = _authService.isLoggedIn();

    setState(() {
      _isAuthenticated = isLoggedIn;
      _isLoading = false;
    });

    if (!_isAuthenticated) {
      if (mounted) {
        Navigator.of(context).pushReplacementNamed('/login');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (_isAuthenticated) {
      return widget.child;
    } else {
      // This should not be visible as we're redirecting in checkAuth()
      return const Scaffold(
        body: Center(
          child: Text('You need to be logged in to view this page'),
        ),
      );
    }
  }
}