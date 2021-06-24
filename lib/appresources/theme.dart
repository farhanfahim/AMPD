import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_colors.dart';
import 'app_colors.dart';

ThemeData light = ThemeData(
    visualDensity: VisualDensity.adaptivePlatformDensity,
    brightness: Brightness.light,
    primarySwatch: Colors.orange,
    focusColor: AppColors.ACCENT_COLOR,
    appBarTheme: AppBarTheme(
      color: Colors.white,
      elevation: 1.0,
      iconTheme: IconThemeData(color: Colors.black),
      brightness: Brightness.light,
      textTheme: TextTheme(
        headline1: TextStyle(color: Colors.black),
      ),
    ),
    accentColor: AppColors.ACCENT_COLOR,
    scaffoldBackgroundColor: Colors.white,
    textTheme: TextTheme(
      headline1: TextStyle(color: Colors.black),
      headline2: TextStyle(color: Colors.white),
      headline3: TextStyle(color: Colors.black),
      headline4: TextStyle(color: AppColors.STORE_DIVIDER),
      headline5: TextStyle(color: AppColors.APP_TEXT_COLOR_DARK),
      headline6: TextStyle(color: AppColors.LIGHT_FILTER_CROSS_BG),
      bodyText2: TextStyle(color: Colors.white),
      subtitle1: TextStyle(color: AppColors.LIGHT_SUBHEADING_COLOR),
      subtitle2: TextStyle(color: AppColors.APP_TEXT_COLOR_DARK)
    ),
    timePickerTheme: TimePickerThemeData(
        backgroundColor: AppColors.APP_COLOR_LIGHT_GREY,
    ),
    iconTheme: IconThemeData(color: AppColors.APP_BOTTOM_BAR_LIGHT_THEME_COLOR),
    backgroundColor: AppColors.APP_COLOR_LIGHT_GREY,
    accentIconTheme: IconThemeData(color: AppColors.LIGHT_TEETIME_ICON_COLOR),
    cardTheme: CardTheme(
      color: Colors.white
    ),
    primaryColor: Colors.black,
    canvasColor: AppColors.BUSINESS_INFO_BACKGROUND_COLOR,
    cardColor: AppColors.BUSINESS_INFO_BACKGROUND_COLOR,
    dividerColor: Colors.orangeAccent);

ThemeData dark = ThemeData(
    visualDensity: VisualDensity.adaptivePlatformDensity,
    primaryColor: Colors.black,
    focusColor: AppColors.ACCENT_COLOR,
    brightness: Brightness.dark,
    appBarTheme: AppBarTheme(
      iconTheme: IconThemeData(color: AppColors.ACCENT_COLOR),
      color: Colors.black,
      elevation: 2.0,
      brightness: Brightness.dark,
      textTheme: TextTheme(
        headline1: TextStyle(color: Colors.white),
        headline2: TextStyle(color: Colors.black),

      ),
    ),
    accentIconTheme: IconThemeData(color: AppColors.ACCENT_COLOR),
    timePickerTheme: TimePickerThemeData(
     backgroundColor: AppColors.APP_APP_BAR_DARK_COLOR
    ),
    primarySwatch: Colors.orange,
    accentColor: AppColors.ACCENT_COLOR,
    scaffoldBackgroundColor: Colors.black,
    textTheme: TextTheme(
      headline1: TextStyle(color: Colors.white),
      headline3: TextStyle(color: AppColors.APP_COLOR_LIGHT_GREY),
      headline4: TextStyle(color: Colors.white.withOpacity(0.6)),
      headline5: TextStyle(color: Colors.white),
      headline6: TextStyle(color: AppColors.DARK_FILTER_CROSS_BG),
      bodyText2: TextStyle(color: Colors.black),
        subtitle1: TextStyle(color: AppColors.DARK_SUBHEADING_COLOR),
        subtitle2: TextStyle(color: AppColors.DARK_SUBHEADING_COLOR)
    ),
    cardTheme: CardTheme(
        color: AppColors.APP_APP_BAR_DARK_COLOR,
    ),
    iconTheme: IconThemeData(color: AppColors.APP_BOTTOM_BAR_DARK_THEME_COLOR),
    backgroundColor: AppColors.APP_APP_BAR_DARK_COLOR,
    cardColor: Colors.black,
    dividerColor: AppColors.ACCENT_COLOR);

class ThemeNotifier extends ChangeNotifier {
  final String key = "theme";
  SharedPreferences _prefs;
  bool _darkTheme;

  bool get darkTheme => _darkTheme;

  ThemeNotifier() {
    _darkTheme = false;
    _loadFromPrefs();
  }

  toggleTheme() {
    _darkTheme = !_darkTheme;

    print("_darkTheme ---- $_darkTheme");
    _saveToPrefs();
    notifyListeners();
  }

  _initPrefs() async {
    if (_prefs == null) _prefs = await SharedPreferences.getInstance();
  }

  _loadFromPrefs() async {
    await _initPrefs();
    _darkTheme = _prefs.getBool(key) ?? false;
    notifyListeners();
  }

  _saveToPrefs() async {
    await _initPrefs();
    _prefs.setBool(key, _darkTheme);
  }
}

//  static ThemeData themeData(bool isDarkTheme, BuildContext context) {
//    return ThemeData(
//      primarySwatch: Colors.red,
//      primaryColor: isDarkTheme ? Colors.black : Colors.white,
//
//      backgroundColor: isDarkTheme ? Colors.black :Colors.white,
//
//      indicatorColor: isDarkTheme ? Color(0xff0E1D36) : Color(0xffCBDCF8),
//      buttonColor: isDarkTheme ? Color(0xff3B3B3B) : Color(0xffF1F5FB),
//
//      hintColor: isDarkTheme ? Color(0xff280C0B) : Color(0xffEECED3),
//
//      highlightColor: isDarkTheme ? Color(0xff372901) : Color(0xffFCE192),
//      hoverColor: isDarkTheme ? Color(0xff3A3A3B) : Color(0xff4285F4),
//
//      focusColor: isDarkTheme ? Color(0xff0B2512) : Color(0xffA8DAB5),
//      disabledColor: Colors.grey,
//      textSelectionColor: isDarkTheme ? Colors.white : Colors.black,
//      cardColor: isDarkTheme ? Color(0xFF151515) : Colors.white,
//      canvasColor: isDarkTheme ? Colors.black : Colors.grey[50],
//      brightness: isDarkTheme ? Brightness.dark : Brightness.light,
//      buttonTheme: Theme.of(context).buttonTheme.copyWith(
//          colorScheme: isDarkTheme ? ColorScheme.dark() : ColorScheme.light()),
//      appBarTheme: AppBarTheme(
//        elevation: 0.0,
//      ),
//    );
//
//  }
