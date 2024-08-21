import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/theme/custom_themes/appbar_theme.dart';
import 'package:flutter_application_1/utils/theme/custom_themes/bottom_sheet_theme.dart';
import 'package:flutter_application_1/utils/theme/custom_themes/elevated_button_theme.dart';
import 'package:flutter_application_1/utils/theme/custom_themes/text_theme.dart';
import 'package:flutter_application_1/utils/theme/custom_themes/outlined_button_theme.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SrkayAppTheme {
  SrkayAppTheme._();

  static ThemeData lightTheme = ThemeData(
    // extensions: const [
    //       SkeletonizerConfigData(),
    //     ],
    useMaterial3: true,
    fontFamily: "Poppins",
    brightness: Brightness.light,
    primaryColor: Colors.blue,
    scaffoldBackgroundColor: Colors.white,
    textTheme: SrkayTextTheme.lightTextTheme,
    appBarTheme: SrkayAppBarTheme.lightAppBarTheme,
    bottomSheetTheme: SrkayBottomSheetTheme.lightBottomSheetTheme,
    outlinedButtonTheme: SrkayoutlinedButtonTheme.lightOutlinedButtonTheme,
    elevatedButtonTheme: SrkayElevatedButtonTheme.lightElevatedButtonTheme,

  );
  static ThemeData darkTheme = ThemeData(
    // extensions: const [
    //       SkeletonizerConfigData(),
    //     ],
    useMaterial3: true,
    fontFamily: "Poppins",
    brightness: Brightness.dark,
    primaryColor: Colors.blue,
    scaffoldBackgroundColor: Colors.black,
    textTheme: SrkayTextTheme.darkTextTheme,
    appBarTheme: SrkayAppBarTheme.darkAppBarTheme,
    bottomSheetTheme: SrkayBottomSheetTheme.darkBottomSheetTheme,
    outlinedButtonTheme: SrkayoutlinedButtonTheme.darkOutlinedButtonTheme,
    elevatedButtonTheme: SrkayElevatedButtonTheme.darkElevatedButtonTheme,
  );
}