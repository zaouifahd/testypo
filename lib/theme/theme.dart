import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Themes {
  static final light = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor:Colors.white,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.white,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
      ),
    ),
  );

  static final dark = ThemeData(
    cardColor: Color(0xff0E1213),
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Color(0xff0E1213),
    appBarTheme: AppBarTheme(
      backgroundColor: Color(0xff0E1213),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.black,
        statusBarIconBrightness: Brightness.light,
      ),
    ),
  );
}
