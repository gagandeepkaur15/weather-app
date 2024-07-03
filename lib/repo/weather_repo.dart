import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_india_stocks_task/models/weather_model.dart';
import 'package:http/http.dart' as http;

class Repo {
  getWeather(String city) async {
    //API key and url (can add api key to .env for safety)
    const apiKey = 'ed828aa8d15dd39855cc3dc015c1bde9';
    var url =
        'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric';

    try {
      //Making the get request
      final response = await http.get(Uri.parse(url));
      var resBody = response.body;
      if (response.statusCode == 200) {
        //Casting data to the weather model
        return WeatherModel.fromJson(json.decode(resBody));
      } else {
        debugPrint(
            'Failed to load weather data. Status code: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }
}
