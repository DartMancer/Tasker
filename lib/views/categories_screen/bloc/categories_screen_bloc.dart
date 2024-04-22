import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kurs_oop/core/constants.dart';
import 'package:kurs_oop/models/category.dart';
import 'package:kurs_oop/utils/logger.dart';

part 'categories_screen_event.dart';
part 'categories_screen_state.dart';

class CategoriesScreenBloc
    extends Bloc<CategoriesScreenEvent, CategoriesScreenState> {
  CategoriesScreenBloc() : super(CategoriesScreenInitial()) {
    on<LoadCategoriesScreen>((event, emit) {
      try {
        final List<Category> categories = getCategories();
        emit(CategoriesScreenLoaded(categoriesList: categories));
      } catch (e, st) {
        emit(CategoriesScreenFailure(exception: e));
        Logger().handle(e, st);
      }
    });
  }

  List<Category> getCategories() {
    final box = Hive.box<Category>(categoriesBox);
    List<Category> categories = [];
    for (var i = 0; i < box.length; i++) {
      categories.add(box.getAt(i)!);
    }
    categories.sort((a, b) => a.id.compareTo(b.id));

    return categories;
  }
}
