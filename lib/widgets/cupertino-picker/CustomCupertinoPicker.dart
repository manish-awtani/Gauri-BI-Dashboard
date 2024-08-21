import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/constants/colors.dart';
import 'package:flutter_application_1/utils/helper/helper_functions.dart';

class CustomCupertinoPicker extends StatelessWidget {
  final List<Map<String, String>> stoneTypeArray;
  final ValueChanged<String> onStoneTypeChanged;

  CustomCupertinoPicker({
    required this.stoneTypeArray,
    required this.onStoneTypeChanged,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkTheme = SrkayHelperFunctions.isDarkMode(context);

    return Container(
      decoration: BoxDecoration(
        color: isDarkTheme
            ? const Color.fromARGB(255, 32, 32, 32)
            : SrkayColors.primary,
        borderRadius: BorderRadius.circular(6),
      ),
      width: 100,
      child: CupertinoPicker(
        itemExtent: 32.0,
        onSelectedItemChanged: (index) {
          Iterable<String> values = stoneTypeArray[index].values;
          onStoneTypeChanged(
              values.first); // Callback to pass the selected value
        },
        selectionOverlay: const CupertinoPickerDefaultSelectionOverlay(
          background: Colors.transparent,
        ),
        children: List.generate(
          stoneTypeArray.length,
          (index) {
            return Center(
              child: Text(
                '${stoneTypeArray[index].keys.first}',
                // '${stoneTypeArray[index].values.first}',
                style: TextStyle(
                  color: isDarkTheme ? Colors.white70 : SrkayColors.dark,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
