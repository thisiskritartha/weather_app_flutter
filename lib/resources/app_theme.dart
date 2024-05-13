import 'package:flutter/material.dart';
import 'package:weather_app_flutter/resources/app_color.dart';

ThemeData customAppTheme() => ThemeData(
      buttonTheme: const ButtonThemeData(buttonColor: whiteColor),
      cardColor: whiteColor,
      useMaterial3: true,
      iconTheme: const IconThemeData(color: whiteColor),
      primaryColor: primaryColor,
      scaffoldBackgroundColor: primaryColor,
      colorScheme: ColorScheme.fromSeed(
        secondary: whiteColor,
        seedColor: primaryColor,
        onPrimary: whiteColor,
      ),
      textTheme: AppTextTheme._textTheme,
    );

class AppTextTheme {
  AppTextTheme._();

  static const TextTheme _textTheme = TextTheme(
    bodyLarge: _defaultFont,
  );

  static const TextStyle _defaultFont = TextStyle(
    fontWeight: FontWeight.normal,
    fontStyle: FontStyle.normal,
    color: textColor,
    fontSize: 14,
  );
}
