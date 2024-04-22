import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kurs_oop/core/constants.dart';
import 'package:kurs_oop/models/category.dart';
import 'package:kurs_oop/utils/app_colors.dart';
import 'package:kurs_oop/utils/gradients.dart';
import 'package:kurs_oop/utils/icons.dart';
import 'package:kurs_oop/views/categories_screen/bloc/categories_screen_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddCategoryDialog extends StatefulWidget {
  const AddCategoryDialog({
    super.key,
    required this.bloc,
  });

  final CategoriesScreenBloc bloc;

  @override
  State<AddCategoryDialog> createState() => _AddCategoryDialogState();
}

class _AddCategoryDialogState extends State<AddCategoryDialog> {
  final TextEditingController _titleController = TextEditingController();
  final Map<String, List<Color>> gradients = CategoryGradients.allGradients;
  final Map<String, IconData> icons = CategoryIcons.allIcons;
  String? _selectedGradientKey;
  String? _selectedIconKey;

  void _addCategory() {
    if (_selectedGradientKey != null &&
        _selectedIconKey != null &&
        _titleController.text.isNotEmpty) {
      final box = Hive.box<Category>(categoriesBox);

      var prefs = GetIt.I<SharedPreferences>();
      int id = prefs.getInt(categoryPreference)!;
      box.put(
        _titleController.text,
        Category(
          id: id,
          title: _titleController.text,
          iconKey: _selectedIconKey!,
          gradientKey: _selectedGradientKey!,
          tasks: [],
        ),
      );

      prefs.setInt(categoryPreference, id + 1);
      widget.bloc.add(LoadCategoriesScreen());
    }

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Добавить категорию',
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
                labelText: 'Название категории',
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
              children: CategoryGradients.allGradients.keys.map((key) {
                LinearGradient gradient = LinearGradient(
                  colors: CategoryGradients.allGradients[key]!,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                );
                bool isSelected = key == _selectedGradientKey;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedGradientKey = key;
                    });
                  },
                  child: Container(
                    width: 55,
                    height: 55,
                    decoration: BoxDecoration(
                      gradient: gradient,
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
            const SizedBox(height: 30),
            const Text(
              'Выберите иконку',
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
              children: CategoryGradients.allGradients.keys.map((key) {
                bool isSelected = key == _selectedIconKey;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedIconKey = key;
                    });
                  },
                  child: Container(
                    width: 55,
                    height: 55,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: isSelected
                          ? Border.all(
                              color: AppColors.onBackground.withOpacity(0.7),
                              width: 2,
                            )
                          : null,
                    ),
                    child: Icon(
                      icons[key],
                      size: 40,
                      color: AppColors.onBackground,
                    ),
                  ),
                );
              }).toList(),
            ),
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
            _addCategory();
          },
          child: const Text('Добавить'),
        ),
      ],
    );
  }
}
