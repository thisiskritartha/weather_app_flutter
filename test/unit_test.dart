import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app_flutter/services/api_services.dart';
import 'package:weather_app_flutter/model/weather_data.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() {
  setUp(() async {
    await dotenv.load(fileName: ".env");
  });
  group('Weather App Unit Tests', () {
    test('Test getCurrentWeatherUsingLocation', () async {
      // Test for a valid location
      final WeatherData? weatherData =
          await getCurrentWeatherUsingLocation('New York');
      expect(weatherData, isNotNull);
      expect(weatherData!.name, 'New York');

      // Test for an invalid location
      final WeatherData? weatherDataInvalid =
          await getCurrentWeatherUsingLocation('InvalidLocationName');
      expect(weatherDataInvalid, isNull);
    });

    test('Test getCurrentWeatherUsingLatLon', () async {
      // Test for valid latitude and longitude
      final WeatherData? weatherData = await getCurrentWeatherUsingLatLon(
          40.7128, -74.0060); // New York's latitude and longitude
      expect(weatherData, isNotNull);
      expect(weatherData!.name,
          'New York'); // Assuming 'name' is the city name in WeatherData

      // Test for invalid latitude and longitude
      final WeatherData? weatherDataInvalid =
          await getCurrentWeatherUsingLatLon(
              1000.0, 2000.0); // Invalid latitude and longitude
      expect(weatherDataInvalid, isNull);
    });
  });
}
