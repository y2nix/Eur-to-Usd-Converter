import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String apiKey = 'fca_live_K2eLn7xoY0Ka6CcE1jAleRAO5Yb8husvznNVciyb';
  static const String apiUrl = 'https://api.freecurrencyapi.com/v1/latest?apikey=fca_live_K2eLn7xoY0Ka6CcE1jAleRAO5Yb8husvznNVciyb';

  Future<Map<String, dynamic>> fetchExchangeRates() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load exchange rates: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to connect to the server: $e');
    }
  }
}
