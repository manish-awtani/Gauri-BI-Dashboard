import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/constants/colors.dart';
import 'package:flutter_application_1/utils/helper/helper_functions.dart';

class SlidingSegmentedButton extends StatelessWidget {
  final ValueChanged<int> onValueChanged;
  final Map<int, Text> textList;
  final BorderRadius? borderRadius;
  final isShowDivider;
  final initialValue;

  const SlidingSegmentedButton({
    super.key,
    required this.onValueChanged,
    required this.textList,
    this.borderRadius,
    this.isShowDivider,
    this.initialValue,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkTheme = SrkayHelperFunctions.isDarkMode(context);

    return Container(
      height: 30,
      child: CustomSlidingSegmentedControl<int>(
        isShowDivider: isShowDivider ?? false,
        initialValue: initialValue ?? null,
        children: textList,
        decoration: BoxDecoration(
          color:
              isDarkTheme ? Color.fromARGB(255, 32, 32, 32) : SrkayColors.dark,
          borderRadius: BorderRadius.circular(8),
         
        ),
        thumbDecoration: BoxDecoration(
          color: SrkayColors.primary,
          borderRadius: borderRadius ?? BorderRadius.circular(0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.3),
              blurRadius: 4.0,
              spreadRadius: 1.0,
              offset: const Offset(
                0.0,
                2.0,
              ),
            ),
          ],
        ),
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInToLinear,
        onValueChanged: onValueChanged,
      ),
    );
  }
}
