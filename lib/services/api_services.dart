import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:weather_app_flutter/model/weather_data.dart';
//import 'package:dotenv/dotenv.dart';

getCurrentWeatherUsingLatLon(double lat, double lon) async { 

  var link =
      "https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=f575532a6ba332d9317b49e4325b5a2b&units=metric";

  var res = await http.get(Uri.parse(link));
  if (res.statusCode == 200) {
    var data = WeatherData.fromJson(json.decode(res.body));
    return data;
  }
}

getCurrentWeatherUsingLocation(String location) async {
  var link =
      "https://api.openweathermap.org/data/2.5/weather?q=$location&appid=f575532a6ba332d9317b49e4325b5a2b&units=metric";

  try {
    var res = await http.get(Uri.parse(link));
    if (res.statusCode == 200) {
      var data = WeatherData.fromJson(json.decode(res.body));
      return data;
    } else {
      throw Exception('Failed to load weather data: ${res.statusCode}');
    }
  } catch (e) {
    print('Error fetching weather data: $e');
    return null;
  }
}
