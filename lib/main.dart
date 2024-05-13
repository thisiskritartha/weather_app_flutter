import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:weather_app_flutter/app.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async{
  await dotenv.load(fileName: ".env");
  initializeStartupDependenciesAndRun();
}

Future<void> initializeStartupDependenciesAndRun() async {
  setPortraitDeviceOrientation();
    runApp(const App());

}

void setPortraitDeviceOrientation() {
  if (!kDebugMode) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }
}
