import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(WeatherApp());
}

class WeatherApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      home: WeatherHomePage(),
    );
  }
}

class WeatherHomePage extends StatefulWidget {
  @override
  _WeatherHomePageState createState() => _WeatherHomePageState();
}

class _WeatherHomePageState extends State<WeatherHomePage> {
  final String apiKey = '562d69fe4d0c46fe9fb141702231409';
  final String location = 'Karachi';
  String weatherData = 'Loading...';

  Future<void> _fetchWeatherData() async {
    final apiUrl =
        'https://api.weatherapi.com/v1/current.json?key=$apiKey&q=$location';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          weatherData = 'Temperature: ${data['current']['temp_c']}°C';
        });
      } else {
        setState(() {
          weatherData = 'Failed to fetch data';
        });
      }
    } catch (e) {
      setState(() {
        weatherData = 'Error: $e';
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchWeatherData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather Forecast'),
      ),
      body: Center(
        child: Text(weatherData),
      ),
    );
  }
}
