import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherService {
  final String apiKey;
  final String apiUrl = 'https://api.weatherapi.com/v1/forecast.json';

  WeatherService(this.apiKey);

  Future<Map<String, dynamic>> getWeather(String location) async {
    final response = await http.get('$apiUrl?key=$apiKey&q=$location&days=7' as Uri);
    
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return data;
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}
