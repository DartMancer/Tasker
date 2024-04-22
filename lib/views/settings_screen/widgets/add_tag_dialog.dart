import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kurs_oop/core/constants.dart';
import 'package:kurs_oop/models/tag.dart';
import 'package:kurs_oop/utils/app_colors.dart';
import 'package:kurs_oop/utils/colors.dart';
import 'package:kurs_oop/views/settings_screen/bloc/settings_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddTagDialog extends StatefulWidget {
  const AddTagDialog({
    super.key,
    required this.bloc,
  });

  final SettingsScreenBloc bloc;

  @override
  State<AddTagDialog> createState() => _AddTagDialogState();
}

class _AddTagDialogState extends State<AddTagDialog> {
  final TextEditingController _titleController = TextEditingController();
  final Map<String, Color> gradients = TagColors.allTagsColors;
  String? _selectedColorKey;

  void _addTag() {
    if (_selectedColorKey != null && _titleController.text.isNotEmpty) {
      final box = Hive.box<Tag>(tagsBox);

      var prefs = GetIt.I<SharedPreferences>();
      int id = prefs.getInt(tagsPreference)!;
      box.put(
        _titleController.text,
        Tag(
          id: id,
          title: _titleController.text,
          colorKey: _selectedColorKey!,
        ),
      );

      prefs.setInt(tagsPreference, id + 1);
      widget.bloc.add(LoadSettingsScreen());
    }

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Добавить тег',
        style: TextStyle(
          fontFamily: fontApp,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextField(
              controller: _titleController,
              style: const TextStyle(
                fontFamily: fontApp,
                fontWeight: FontWeight.normal,
              ),
              decoration: const InputDecoration(
                labelText: 'Название тега',
                labelStyle: TextStyle(fontFamily: fontApp),
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              'Выберите цвет',
              style: TextStyle(
                fontSize: 20,
                color: AppColors.onBackground,
                fontFamily: fontApp,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: TagColors.allTagsColors.keys.map((key) {
                Color tagColor = TagColors.allTagsColors[key]!;
                bool isSelected = key == _selectedColorKey;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedColorKey = key;
                    });
                  },
                  child: Container(
                    width: 55,
                    height: 55,
                    decoration: BoxDecoration(
                      color: tagColor,
                      borderRadius: BorderRadius.circular(8),
                      border: isSelected
                          ? Border.all(
                              color: AppColors.onBackground.withOpacity(0.7),
                              width: 2,
                            )
                          : null,
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Отмена'),
          onPressed: () => Navigator.of(context).pop(),
        ),
        TextButton(
          onPressed: () {
            _addTag();
          },
          child: const Text('Добавить'),
        ),
      ],
    );
  }
}
