import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

/// 🎨 الألوان
const Color bluishClr = Color(0xFF4e5ae8);
const Color yellowClr = Color(0xFFFFB746);
const Color pinkClr = Color(0xFFFF4667);
const Color white = Colors.white;
const Color darkGreyClr = Color(0xFF121212);
const Color darkHeaderClr = Color(0xFF424242);

/// 🎯 ألوان رئيسية
const Color primaryClr = bluishClr;

/// 🖋️ Text Styles
final TextStyle headingStyle = TextStyle(
  fontSize: 24,
  fontWeight: FontWeight.bold,
  color: Get.isDarkMode ? Colors.white : Colors.black,
);

final TextStyle subHeadingStyle = TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.bold,
  color: Get.isDarkMode ? Colors.grey[300] : Colors.grey,
);

final TextStyle titleStyle = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.w600,
  color: Get.isDarkMode ? Colors.white : Colors.black,
);

final TextStyle subTitleStyle = TextStyle(
  fontSize: 14,
  color: Get.isDarkMode ? Colors.grey[400] : Colors.grey[700],
);

/// 🌗 الثيمات
class Themes {
  static final light = ThemeData(
    brightness: Brightness.light,
    primaryColor: primaryClr,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      elevation: 0,
      foregroundColor: Colors.black,
    ),
  );

  static final dark = ThemeData(
    brightness: Brightness.dark,
    primaryColor: darkGreyClr,
    scaffoldBackgroundColor: darkGreyClr,
    appBarTheme: const AppBarTheme(
      backgroundColor: darkGreyClr,
      elevation: 0,
      foregroundColor: Colors.white,
    ),
  );
}

/// 🌙 Theme Service
class ThemeService {
  final _box = GetStorage();
  final _key = 'isDarkMode';

  ThemeMode get theme =>
      _box.read(_key) == true ? ThemeMode.dark : ThemeMode.light;

  void switchTheme() {
    Get.changeThemeMode(
      Get.isDarkMode ? ThemeMode.light : ThemeMode.dark,
    );
    _box.write(_key, !Get.isDarkMode);
  }
}
