import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'weather_model.dart';

class WeatherProvider with ChangeNotifier {
  Weather? _weather;
  bool _isLoading = false;
  String _lastCity = '';


  Weather? get weather => _weather;
  bool get isLoading => _isLoading;
  String get lastCity => _lastCity;


  Future<void> fetchWeather(String city) async {
    _isLoading = true;
    notifyListeners();

    final url = 'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=YOUR_API_KEY&units=metric';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      _weather = Weather.fromJson(data);
      _lastCity = city;
    } else {
      _weather = null;
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> refreshWeather() async {
    if (_lastCity.isNotEmpty) {
      await fetchWeather(_lastCity);
    }
  }
}
