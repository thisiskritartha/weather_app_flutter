import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:weather_app_flutter/model/weather_data.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:weather_app_flutter/resources/app_color.dart';

getCurrentWeatherUsingLatLon(double lat, double lon) async {
  var link =
      "https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=${dotenv.env["API_KEY"]}&units=metric";

  var res = await http.get(Uri.parse(link));
  if (res.statusCode == 200) {
    var data = WeatherData.fromJson(json.decode(res.body));
    return data;
  }
}

getCurrentWeatherUsingLocation(String location) async {
  var link =
      "https://api.openweathermap.org/data/2.5/weather?q=$location&appid=${dotenv.env["API_KEY"]}&units=metric";

  try {
    var res = await http.get(Uri.parse(link));
    if (res.statusCode == 200) {
      var data = WeatherData.fromJson(json.decode(res.body));
      return data;
    } else {
      throw Exception('Failed to load weather data: ${res.statusCode}');
    }
  } catch (e) {
    Get.snackbar(
      'Error',
      'Error fetching weather data. Please input the valid location.',
      backgroundColor: errorColor,
      colorText: whiteColor,
      duration: const Duration(seconds: 3),
      snackPosition: SnackPosition.TOP,
    );
    print('Error fetching weather data: $e');
    return null;
  }
}
