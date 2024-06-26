import 'package:flutter/material.dart';

import '../models/weather.dart';
import '../services/weather_service.dart';


class WeatherProvider with ChangeNotifier {
  final WeatherService _weatherService = WeatherService();
  Weather? _weather;
  Forecast? _forecast;

  Weather? get weather => _weather;
  Forecast? get forecast => _forecast;

  Future<void> fetchWeather(String city) async {
    _weather = Weather.fromJson(await _weatherService.getCurrentWeather(city));
    _forecast = Forecast.fromJson(await _weatherService.getForecast(city));
    notifyListeners();
  }
}
