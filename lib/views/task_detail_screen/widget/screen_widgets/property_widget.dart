import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:kurs_oop/config/router/main_navigation.dart';
import 'package:kurs_oop/core/constants.dart';
import 'package:kurs_oop/utils/app_colors.dart';

class PropertyWidget extends StatelessWidget {
  const PropertyWidget({
    super.key,
    required this.label,
    required this.icon,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) => Column(
        children: [
          ListTile(
            title: Text(
              label,
              style: const TextStyle(
                fontFamily: fontApp,
                fontWeight: FontWeight.bold,
              ),
            ),
            leading: Icon(icon),
            onTap: () {
              GetIt.I<AppRouter>().popForced();
              onTap();
            },
          ),
          Container(
            height: 2,
            color: AppColors.onBackground.withOpacity(0.1),
          )
        ],
      ),
    );
  }
}
