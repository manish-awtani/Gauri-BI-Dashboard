import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/constants/colors.dart';

class BottomTabBar extends StatelessWidget {
  final Function() onShowModal;
  final IconData icon;
  // final Function() onFilterButtonPressed;

  const BottomTabBar({
    Key? key,
    required this.onShowModal,
    required this.icon,
// required this.onFilterButtonPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkTheme = theme.brightness == Brightness.dark;

    return BottomAppBar(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      // height: 14,
      height: 22,
      color: isDarkTheme ? Color.fromARGB(255, 32, 32, 32) : Colors.grey[200],
      shape: const CircularNotchedRectangle(),
      shadowColor: SrkayColors.primary,
      notchMargin: 5,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // IconButton(
          //   icon: Icon(Icons.pie_chart),
          //   onPressed: () => onChartTypeSelected('Pie Chart'),
          // ),
          IconButton(
            icon: Icon(icon),
            onPressed: () => onShowModal(),
          ),
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () => (),
            // showChartSelectionModal(context),
          ),
        ],
      ),
    );
  }

// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/utils/constants/colors.dart';

// class BottomTabBar extends StatelessWidget {
//   final Function() onShowModal;
//   final IconData icon;
//   // final Function() onFilterButtonPressed;

// const BottomTabBar({ Key? key,
//     required this.onShowModal, required this.icon,
// // required this.onFilterButtonPressed,
//  }) : super(key: key);

//   @override
//   Widget build(BuildContext context){

//     final theme = Theme.of(context);
//     final isDarkTheme = theme.brightness == Brightness.dark;

//     return Container(
//       height: 48,
//       // color: isDarkTheme ? Colors.grey[800] : Colors.grey[200],
//       color: isDarkTheme ? Color.fromARGB(255, 32, 32, 32) : Colors.grey[200],
//       // theme.bottomSheetTheme.backgroundColor,
//       // SrkayColors.borderSecondary,
//       // theme.bottomAppBarColor,
//       // Colors.grey[200],
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: [
//           // IconButton(
//           //   icon: Icon(Icons.pie_chart),
//           //   onPressed: () => onChartTypeSelected('Pie Chart'),
//           // ),
//           IconButton(
//             icon: Icon(icon),
//             onPressed: () => onShowModal(),
//           ),
//           IconButton(
//             icon: Icon(Icons.filter_list),
//             onPressed: () => (),
//             // showChartSelectionModal(context),
//           ),
//         ],
//       ),
//     );
//   }
// }
}
