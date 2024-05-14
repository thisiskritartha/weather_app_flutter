import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:weather_app_flutter/resources/app_color.dart';
import 'package:weather_app_flutter/routes/app_pages.dart';
import 'resources/app_theme.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    precacheImage(const AssetImage("assets/error.png"), context);
    precacheImage(const AssetImage("assets/bg_img.png"), context);
    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 3000)
      ..indicatorType = EasyLoadingIndicatorType.wanderingCubes
      ..loadingStyle = EasyLoadingStyle.values.last
      ..indicatorSize = 45.0
      ..radius = 10.0
      ..progressColor = whiteColor
      ..backgroundColor = buttonColor
      ..indicatorColor = whiteColor
      ..textColor = whiteColor
      ..userInteractions = true
      ..dismissOnTap = true;
    return Builder(
      builder: (BuildContext context) {
        return ScreenUtilInit(
          designSize: const Size(430, 982),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (_, child) {
            return GetMaterialApp(
              debugShowCheckedModeBanner: false,
              getPages: AppPages.appRoutes,
              initialRoute: initial,
              theme: customAppTheme(),
              builder: EasyLoading.init(),
            );
          },
        );
      },
    );
  }
}
