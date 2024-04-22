part of 'categories_screen_bloc.dart';

class CategoriesScreenState {}

class CategoriesScreenInitial extends CategoriesScreenState {}

class CategoriesScreenLoading extends CategoriesScreenState {}

class CategoriesScreenLoaded extends CategoriesScreenState {
  CategoriesScreenLoaded({
    required this.categoriesList,
  });

  final List<Category> categoriesList;
}

class CategoriesScreenFailure extends CategoriesScreenState {
  CategoriesScreenFailure({
    required this.exception,
  });
  final Object? exception;
}
