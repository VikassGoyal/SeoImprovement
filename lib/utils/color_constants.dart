

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class ColorConstants{
  ColorConstants._();
  static final ColorConstants _instance = ColorConstants._();
   factory ColorConstants() => _instance;

  Color lightBackGroundColor= Colors.white;
  Color splashScreenBackgroundColor= HexColor("#dfe3f8");
  Color loginButton= Colors.blue;
  Color blackColor = Colors.black;
  Color whiteColor= Colors.white;


}