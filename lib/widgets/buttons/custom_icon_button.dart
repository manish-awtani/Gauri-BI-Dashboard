import 'package:flutter/material.dart';

// class CustomIconButton extends StatelessWidget {
//   final VoidCallback onPressed;
//   final Widget icon;
//   final double iconSize;

//   const CustomIconButton({
//     Key? key,
//     required this.onPressed,
//     required this.icon,
//     this.iconSize = 24.0,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return RawMaterialButton( // Use RawMaterialButton for customization
//       onPressed: onPressed,
//       materialTapTargetSize: MaterialTapTargetSize.padded, // Shrink tap area
//       constraints: BoxConstraints.tightFor(width: iconSize, height: iconSize), // Set exact size
//       child: icon,
//     );
//   }
// }

class CustomIconButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget icon;
  final double iconSize;
  final double spacing; // Added to control spacing between icon and button area

  const CustomIconButton({
    Key? key,
    required this.onPressed,
    required this.icon,
    this.iconSize = 24.0, // Default icon size
    this.spacing = 0.0, // Default spacing
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero, // Remove default padding
        minimumSize: Size(iconSize + spacing, iconSize), // Minimum size for button
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,  // Minimize row width
        children: [
          icon,
          SizedBox(width: spacing),  // Add spacing between icon and button area
        ],
      ),
    );
  }
}
