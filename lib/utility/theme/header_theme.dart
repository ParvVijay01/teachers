
import 'package:flutter/material.dart';
import 'package:teachers_app/utility/constants/colors.dart';
import 'package:teachers_app/utility/constants/sizes.dart';

class IKHeaderTheme {
  IKHeaderTheme._();

  // light mode Header theme
  static const lightHeaderTheme = AppBarTheme(
    elevation: 0,
    centerTitle: false,
    scrolledUnderElevation: 0,
    toolbarHeight: IKSizes.headerHeight,
    backgroundColor: IKColors.background,
    surfaceTintColor: Colors.transparent,
    iconTheme: IconThemeData(color: IKColors.title, size: 24),
    actionsIconTheme: IconThemeData(color: IKColors.title, size: 24),
    titleTextStyle: TextStyle(
        fontSize: 20.0,
        fontFamily: 'Jost',
        fontWeight: FontWeight.w500,
        color: IKColors.title),
  );

  
}
