import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherService {
  static const String apiKey = '3b644c1171b14edeb50164501242606';
  static const String baseUrl = 'http://api.weatherapi.com/v1';

  Future<Map<String, dynamic>> getCurrentWeather(String city) async {
    final response =
        await http.get(Uri.parse('$baseUrl/current.json?key=$apiKey&q=$city'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load weather data');
    }
  }

  Future<Map<String, dynamic>> getForecast(String city) async {
    final response = await http
        .get(Uri.parse('$baseUrl/forecast.json?key=$apiKey&q=$city&days=3'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load forecast data');
    }
  }
}
