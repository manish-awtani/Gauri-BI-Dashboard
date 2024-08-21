import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/constants/colors.dart';

class BottomTabBar2 extends StatelessWidget {
  final Function() onShowModal;
  final IconData icon;

  const BottomTabBar2({
    Key? key,
    required this.onShowModal,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkTheme = theme.brightness == Brightness.dark;

    return ClipPath(
      clipper: CustomNotchedClipper(),
      child: Container(
        color: isDarkTheme ? Color.fromARGB(255, 32, 32, 32) : Colors.grey[200],
        height: 48,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: Icon(icon),
              onPressed: () => onShowModal(),
            ),
            IconButton(
              icon: Icon(Icons.filter_list),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}

class CustomNotchedClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final double notchRadius = 40.0;
    final double s1 = 30.0;
    final double s2 = 1.0;
    final double r = notchRadius;

    final double rQ = notchRadius / s1;
    final double r2Q = notchRadius / s2;

    final double radius = notchRadius;

    final Path path = Path()..moveTo(0, 0);
    path.lineTo(size.width / 2 - r, 0);
    path.conicTo(
      size.width / 2 - r + rQ,
      0,
      size.width / 2 - r + 2 * r2Q,
      r,
      1,
    );
    path.lineTo(size.width / 2 + r - 2 * r2Q, r);
    path.conicTo(
      size.width / 2 + r - rQ,
      0,
      size.width / 2 + r,
      0,
      1,
    );
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
