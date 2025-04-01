import 'package:flutter/material.dart';
import 'package:teachers_app/utility/theme/button_theme.dart';
import 'package:teachers_app/utility/constants/colors.dart';
import 'package:teachers_app/utility/constants/text_theme.dart';
import 'package:teachers_app/utility/theme/card_theme.dart';
import 'package:teachers_app/utility/theme/header_theme.dart';

class IKAppTheme {
  IKAppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: IKColors.primary,
    scaffoldBackgroundColor: IKColors.card,
    textTheme: IKTextTheme.lightTheme,
    elevatedButtonTheme: IKButtonTheme.lightButtonTheme,
    appBarTheme: IKHeaderTheme.lightHeaderTheme,
    cardTheme: IKCardTheme.lightCardTheme,
    dividerColor: IKColors.border,
    cardColor: IKColors.card,
    canvasColor: IKColors.light,
  );
}
