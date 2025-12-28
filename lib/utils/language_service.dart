import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter/material.dart';

class LanguageService {
  final _box = GetStorage();
  final _key = 'lang';

  Locale get locale {
    String code = _box.read(_key) ?? 'en';
    return Locale(code);
  }

  void changeLanguage(String code) {
    Get.updateLocale(Locale(code));
    _box.write(_key, code);
  }
}
