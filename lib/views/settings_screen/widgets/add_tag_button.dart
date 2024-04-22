import 'package:flutter/material.dart';
import 'package:kurs_oop/utils/utils.dart';
import 'package:kurs_oop/core/constants.dart';
import 'package:kurs_oop/views/settings_screen/settings_screen.dart';

class AddTagButton extends StatelessWidget {
  const AddTagButton({
    super.key,
    required SettingsScreenBloc settingsBloc,
  }) : _settingsBloc = settingsBloc;

  final SettingsScreenBloc _settingsBloc;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) => AddTagDialog(
            bloc: _settingsBloc,
          ),
        );
      },
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.add, color: AppColors.primary),
          SizedBox(width: 10),
          Text(
            'Добавить тег',
            style: TextStyle(
              fontSize: 16,
              fontFamily: fontApp,
              color: AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }
}
