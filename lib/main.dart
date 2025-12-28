import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'package:todo_sqflite/db/db_helper.dart';
import 'package:todo_sqflite/utils/theme.dart';
import 'package:todo_sqflite/utils/language_service.dart';
import 'package:todo_sqflite/translations/app_translations.dart';
import 'package:todo_sqflite/views/splash_screen.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // تهيئة قاعدة البيانات
  await DBHelper.instance;

  // تهيئة التخزين المحلي
  await GetStorage.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Hive Todo App',
      debugShowCheckedModeBanner: false,

      // 🌍 دعم اللغات
      translations: AppTranslations(),
      locale: LanguageService().locale,
      fallbackLocale: const Locale('en'),

      // 🎨 الثيمات
      theme: Themes.light,
      darkTheme: Themes.dark,
      themeMode: ThemeService().theme,

      // 🚀 شاشة البداية
      home: const SplashScreen(),
    );
  }
}
