import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app_flutter/model/weather_data.dart';
import 'package:weather_app_flutter/services/api_services.dart';

class HomescreenController extends GetxController {
  @override
  void onInit() async {
    //await getUserLocation();
    super.onInit();
  }

  RxDouble lat = 0.0.obs; //Latitude_value
  RxDouble lon = 0.0.obs; //Longitude_value
  RxBool isLoaded = false.obs; //Initially the value isn't loaded
  Future<dynamic>? currentWeatherData;
  RxString searchText = ''.obs;

  void onSearchTextChanged(String value) {
    searchText.value = value;
    print('Search text changed: $value');
  }

//Getting the Current Location of the user.
  dynamic getUserLocation() async {
    bool isLocationEnabled;
    LocationPermission userPermission;

    isLocationEnabled = await Geolocator.isLocationServiceEnabled();
    if (!isLocationEnabled) {
      return Future.error("Location is not enabled");
    }

    userPermission = await Geolocator.checkPermission();
    if (userPermission == LocationPermission.deniedForever) {
      return Future.error("Permission is denied forever");
    } else if (userPermission == LocationPermission.denied) {
      userPermission = await Geolocator.requestPermission();
      if (userPermission == LocationPermission.denied) {
        return Future.error("Permission is denied");
      }
    }

    return await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high)
        .then((value) {
      lat.value = value.latitude;
      lon.value = value.longitude;
      isLoaded.value = true;
    });
  }

  Future<dynamic>? getWeather(double lat, double lon) async {
    final WeatherData result = await getCurrentWeather(lat, lon);
    isLoaded.value = true;
    print("Temperature: ${result.main!.temp!}");
    return result;
  }
}
