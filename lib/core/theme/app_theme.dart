import 'package:flutter/material.dart';
import 'package:places_to_visit/core/theme/text/dark_text_theme.dart';
import 'package:places_to_visit/core/theme/text/light_text_theme.dart';
import 'package:places_to_visit/core/theme/text/text_theme.dart';

import 'color/color_theme.dart';
import 'color/dark_color_theme.dart';
import 'color/light_color_theme.dart';

abstract class ITheme {
  ITextTheme get textTheme;
  IColors get colors;
}

abstract class ThemeManager {
  static ThemeData createTheme(ITheme theme) => ThemeData(
        fontFamily: theme.textTheme.fontFamily,
        textTheme: theme.textTheme.data,
        cardColor: theme.colors.colorScheme?.onSecondary,
        bottomAppBarColor: theme.colors.scaffoldBackgroundColor,
        tabBarTheme: TabBarTheme(
          indicator: const BoxDecoration(),
          labelColor: theme.colors.tabbarSelectedColor,
          unselectedLabelColor: theme.colors.tabbarNormalColor,
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            // This is a custom color variable
            primary: theme.colors.textButtonColor,
          ),
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: theme.colors.appBarColor,
          elevation: 0,
        ),
        scaffoldBackgroundColor: theme.colors.scaffoldBackgroundColor,
        colorScheme: theme.colors.colorScheme,
      );
}

class AppThemeDark extends ITheme {
  @override
  late final ITextTheme textTheme;
  AppThemeDark() {
    textTheme = TextThemeDark(colors.colors.white);
  }

  @override
  IColors get colors => DarkColors();
}

class AppThemeLight extends ITheme {
  @override
  late final ITextTheme textTheme;
  AppThemeLight() {
    textTheme = TextThemeLight(colors.colors.black);
  }

  @override
  IColors get colors => LightColors();
}
