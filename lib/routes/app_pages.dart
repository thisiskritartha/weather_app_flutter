import 'package:get/get.dart';
import 'package:weather_app_flutter/routes/getx_routes.dart';
import 'package:weather_app_flutter/view/home/home_screen.dart';
import 'package:weather_app_flutter/view/splash_screen.dart';

const String initial = Routes.initialRoute;

class AppPages {
  static List<GetPage<dynamic>> appRoutes = [
  GetPage(name: Routes.initialRoute, page: () => const SplashScreen()),
  GetPage(name: Routes.homescreenRoute, page: () => const HomeScreen()),
];
}
