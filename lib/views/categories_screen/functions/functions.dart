import 'package:hive_flutter/hive_flutter.dart';
import 'package:kurs_oop/core/constants.dart';
import 'package:kurs_oop/models/models.dart';
import 'package:kurs_oop/views/categories_screen/bloc/categories_screen_bloc.dart';

class CategoriesMethods {
  deleteCategories({
    required List<int> selectedCategories,
    required CategoriesScreenBloc bloc,
  }) {
    final box = Hive.box<Category>(categoriesBox);
    List deletingCategories = [];
    for (var element in box.values) {
      if (selectedCategories.contains(element.id)) {
        deletingCategories.add(element.title);
      }
    }
    box.deleteAll(deletingCategories);

    bloc.add(LoadCategoriesScreen());
  }
}
