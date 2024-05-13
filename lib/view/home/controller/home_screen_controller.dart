import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app_flutter/model/weather_data.dart';
import 'package:weather_app_flutter/resources/app_color.dart';
import 'package:weather_app_flutter/services/api_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomescreenController extends GetxController {
  @override
  void onInit() async {
    await getUserLocation();
    prefs = await SharedPreferences.getInstance();
    isLocationBlank.value = prefs.getBool("isLocationBlank") ?? true;
    super.onInit();
  }

  RxBool isLocationBlank = true.obs;
  RxBool isError = false.obs;
  RxDouble lat = 0.0.obs; //Latitude_value
  RxDouble lon = 0.0.obs; //Longitude_value
  RxBool isLoaded = false.obs; //Initially the value isn't loaded
  Future<dynamic>? currentWeatherData;
  RxString searchLocation = ''.obs;
  RxDouble maxTemp = 0.0.obs;
  RxDouble minTemp = 0.0.obs;
  RxDouble feelsLike = 0.0.obs;
  RxString searchText = "".obs;
  late SharedPreferences prefs;

  void onSearchTextChanged(String value) {
    searchText.value = value;
  }

  void search() async {
    isLocationBlank.value = false;
    isLoaded.value = false;
    isError.value = false;
    searchLocation.value = searchText.value;
    FocusScope.of(Get.context!).unfocus();
    if (searchLocation.value != "") {
      saveLocation(searchLocation.value.toLowerCase());
      await getWeatherUsingLocation();
    }
  }

  void saveLocation(String location) {
    prefs.setString("location", location);
    prefs.setBool("isLocationBlank", false);
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

//Getting the current weather using user's latitude and longiture value
  Future<dynamic>? getWeatherUsingLatLon() async {
    final WeatherData result =
        await getCurrentWeatherUsingLatLon(lat.value, lon.value);

    isLoaded.value = true;

    minTemp.value = result.main!.tempMin!;
    maxTemp.value = result.main!.tempMax!;
    feelsLike.value = result.main!.feelsLike!;

    return result;
  }

//Getting the current weather using user's search location value
  Future<dynamic>? getWeatherUsingLocation() async {
    try {
      final savedLocation = prefs.getString("location");

      if (savedLocation != null && savedLocation.isNotEmpty) {
        searchLocation.value = savedLocation;
        isLocationBlank.value = prefs.getBool("isLocationBlank") ?? true;
      }

      final WeatherData result =
          await getCurrentWeatherUsingLocation(searchLocation.toLowerCase());

      isLoaded.value = true;

      minTemp.value = result.main!.tempMin!;
      maxTemp.value = result.main!.tempMax!;
      feelsLike.value = result.main!.feelsLike!;

      return result;
    } catch (e) {
      print('Error fetching weather data: $e');
      isError.value = true;
      Get.snackbar(
        'Error',
        'Failed to fetch weather data. Please try again later.',
        backgroundColor: errorColor,
        colorText: whiteColor,
        duration: const Duration(seconds: 3),
        snackPosition: SnackPosition.TOP,
      );
      return null;
    }
  }
}
