import 'package:flutter/material.dart';
import 'package:LNP_Guru/utility/theme/button_theme.dart';
import 'package:LNP_Guru/utility/constants/colors.dart';
import 'package:LNP_Guru/utility/constants/text_theme.dart';
import 'package:LNP_Guru/utility/theme/card_theme.dart';
import 'package:LNP_Guru/utility/theme/header_theme.dart';

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
