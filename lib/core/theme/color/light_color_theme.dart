import 'package:flutter/material.dart';

import 'color_theme.dart';

class LightColors implements IColors {
  @override
  Color? appBarColor;

  @override
  Brightness? brightness;

  @override
  ColorScheme? colorScheme;

  @override
  Color? scaffoldBackgroundColor;

  @override
  Color? tabBarColor;

  @override
  Color? tabbarNormalColor;

  @override
  Color? tabbarSelectedColor;

  @override
  Color? buttonGoogleColor;

  @override
  Color? buttonNormalColor;

  @override
  Color? textButtonColor;

  @override
  final AppColors colors = AppColors();

  LightColors() {
    appBarColor = colors.white;
    scaffoldBackgroundColor = colors.white;
    tabBarColor = colors.red;
    tabbarNormalColor = colors.darkerGrey;
    textButtonColor = colors.nightblue;
    tabbarSelectedColor = colors.red;
    buttonNormalColor = colors.green;
    buttonGoogleColor = colors.nightblue;
    colorScheme = const ColorScheme.light().copyWith(
      onPrimary: colors.red,
      onSecondary: colors.white,
      onSurface: colors.mediumGreyBold,
    );
  }
}
