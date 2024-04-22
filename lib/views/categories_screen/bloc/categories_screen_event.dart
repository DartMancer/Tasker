part of 'categories_screen_bloc.dart';

class CategoriesScreenEvent {}

class LoadCategoriesScreen extends CategoriesScreenEvent {
  LoadCategoriesScreen({
    this.completer,
  });

  final Completer? completer;
}

class UpdateCategoryCompletedTasks extends CategoriesScreenEvent {
  final Category category;

  UpdateCategoryCompletedTasks(this.category);
}
