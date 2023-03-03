// ignore_for_file: non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeServices extends GetxController{
  final box = GetStorage();
  final key = 'isDarkMode';

  saveThemeToBox(bool isDarkMode) => box.write(key, isDarkMode);

  bool loadThemeFromBox() => box.read(key) ?? false;

  ThemeMode get theme => loadThemeFromBox() ? ThemeMode.dark : ThemeMode.light;

  void swichTheme() {
    Get.changeThemeMode(loadThemeFromBox() ? ThemeMode.light : ThemeMode.dark);
    saveThemeToBox(
      !loadThemeFromBox(),
    );
  }
}

class GetStorageKey {
  static final IS_DARK_MODE = "sms_is_dark_mode";
}