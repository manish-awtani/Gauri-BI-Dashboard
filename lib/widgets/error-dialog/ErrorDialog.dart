import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/constants/colors.dart';
import '../../utils/theme/custom_themes/text_theme.dart';

class ErrorDialog extends StatelessWidget {
  final bool isDarkTheme;
  const ErrorDialog({Key? key, required this.isDarkTheme}) : super(key: key);

  @override
  Widget build(BuildContext context) {    
    final SRKTextTheme = isDarkTheme
        ? SrkayTextTheme.darkTextTheme
        : SrkayTextTheme.lightTextTheme;
    return Dialog(
      backgroundColor: isDarkTheme
          ? const Color.fromARGB(255, 32, 32, 32)
          : SrkayColors.primaryBackground,
      child: Container(
        width: 150,
        height: 200,
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.0),
        ),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.close_rounded),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(bottom: 8),
              child: Image.asset(
                "lib/utils/assets/images/chatbot2.png",
                width: 55,
                height: 55,
              ),
            ),
            Center(
              child: SizedBox(
                child: Text(
                  "Whoops! We messed up!\nYou can contact our team and we can help out!",
                  style: SRKTextTheme.displayLarge,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
