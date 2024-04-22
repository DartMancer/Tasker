import 'package:flutter/material.dart';
import 'package:kurs_oop/core/constants.dart';
import 'package:kurs_oop/utils/utils.dart';

class SettingsScreenButton extends StatelessWidget {
  const SettingsScreenButton({
    super.key,
    required this.title,
    required this.icon,
    required this.onPressed,
  });

  final String title;
  final IconData icon;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    double width = mediaQuery.size.width;
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: width * 0.9,
              height: width * 0.15,
              decoration: BoxDecoration(
                color: AppColors.background,
                border: Border.all(
                  width: 1,
                  color: AppColors.onBackground,
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.25),
                    offset: const Offset(0, 4),
                    blurRadius: 4,
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 40),
              child: Row(
                children: [
                  Icon(icon),
                  SizedBox(width: width * 0.03),
                  Text(
                    title,
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                      fontFamily: fontApp,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: width * 0.9,
              height: width * 0.15,
              child: MaterialButton(
                onPressed: () {
                  onPressed();
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            )
          ],
        ),
        SizedBox(height: width * 0.05)
      ],
    );
  }
}
