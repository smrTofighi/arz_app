import 'package:arz_app/constant.dart';
import 'package:flutter/material.dart';

class MyThemes{
  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: kDarkGreyColor,
    colorScheme: const ColorScheme.dark(),
  );

  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: kBackGroundColor,
    colorScheme: const ColorScheme.light()
  );
}