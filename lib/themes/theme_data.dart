import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_shopping_app/utils/color_constants.dart';


class ThemeConfig {
  static ThemeData get lightTheme => createTheme(
      brightness: Brightness.light,
      background: ColorConstants().lightBackGroundColor);
  static ThemeData createTheme(
      {required Brightness brightness, required Color background}) {
    return ThemeData(
        brightness: brightness,
        canvasColor: background,
        appBarTheme: const AppBarTheme(
            systemOverlayStyle:
                SystemUiOverlayStyle(statusBarBrightness: Brightness.light)),
        textTheme: const TextTheme(
          headlineLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
        ));
  }
}
