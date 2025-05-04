class ApiConstants {
  // Base URL - update with your Laravel API URL
  static const String baseUrl = 'http://10.0.2.2:8000/api'; // For Android emulator
  // static const String baseUrl = 'http://localhost:8000/api'; // For iOS simulator

  // Auth endpoints
  static const String login = '$baseUrl/login';
  static const String signup = '$baseUrl/signup';
  static const String logout = '$baseUrl/logout';
  static const String user = '$baseUrl/user';
}