import 'package:flutter/material.dart';
import 'package:go_india_stocks_task/models/weather_model.dart';
import 'package:go_india_stocks_task/repo/weather_repo.dart';

class WeatherProvider extends ChangeNotifier {
  WeatherModel? _weather;
  bool _loading = false;
  String? _error;

  WeatherModel? get weather => _weather;
  bool get loading => _loading;
  String? get error => _error;

  final Repo _repo = Repo();

  Future<void> fetchWeather(String city) async {
    _loading = true;
    _error = null;
    notifyListeners();

    try {
      _weather = await _repo.getWeather(city);
      if (_weather == null) {
        _error = 'Failed to fetch weather data';
      }
    } catch (e) {
      _error = e.toString();
    } finally {
      _loading = false;
      notifyListeners();
    }
  }
}
