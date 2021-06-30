import 'dart:ui';

import 'package:ampd/appresources/app_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_colors.dart';
import 'app_colors.dart';

ThemeData light = ThemeData(
    fontFamily: 'Poppins',
    visualDensity: VisualDensity.adaptivePlatformDensity,
    brightness: Brightness.light,
    primarySwatch: Colors.blue,
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

