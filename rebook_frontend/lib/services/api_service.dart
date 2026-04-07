import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "http://10.0.2.2:8000"; // For Android emulator

  // Fetch available books
  static Future<List<dynamic>> getBooks() async {
    final response = await http.get(Uri.parse('$baseUrl/books'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load books');
    }
  }

  // Fetch user profile (User1)
  static Future<Map<String, dynamic>> getProfile() async {
    final response = await http.get(Uri.parse('$baseUrl/profile'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load profile');
    }
  }

  // Send an exchange request
  static Future<void> sendExchangeRequest(String name) async {
    final response = await http.post(Uri.parse('$baseUrl/exchange/request?name=$name'));
    if (response.statusCode != 200) {
      throw Exception('Failed to send exchange request');
    }
  }

  // Accept an exchange request
  static Future<void> acceptExchange() async {
    final response = await http.post(Uri.parse('$baseUrl/exchange/accept'));
    if (response.statusCode != 200) {
      throw Exception('Failed to accept exchange request');
    }
  }
}
