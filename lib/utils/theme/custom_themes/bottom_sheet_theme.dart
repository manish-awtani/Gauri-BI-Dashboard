import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/constants/colors.dart';
 
class SrkayBottomSheetTheme {
  SrkayBottomSheetTheme._();

    static BottomSheetThemeData lightBottomSheetTheme = BottomSheetThemeData(
        showDragHandle: true,
        backgroundColor: SrkayColors.borderSecondary,
        modalBackgroundColor: Colors.white,
        constraints: const BoxConstraints(minWidth: double.infinity),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    );

    static BottomSheetThemeData darkBottomSheetTheme = BottomSheetThemeData(
        showDragHandle: true,
        backgroundColor: Colors.black,
        modalBackgroundColor: Color.fromARGB(255, 33, 32, 32),
        constraints: const BoxConstraints(minWidth: double.infinity),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    );
}