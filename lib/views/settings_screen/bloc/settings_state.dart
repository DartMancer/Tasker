part of 'settings_bloc.dart';

class SettingsScreenState {}

class SettingsScreenInitial extends SettingsScreenState {}

class CategoriesScreenLoading extends SettingsScreenState {}

class SettingsScreenLoaded extends SettingsScreenState {
  SettingsScreenLoaded({
    required this.tagsList,
  });

  final List<Tag> tagsList;
}

class SettingsScreenFailure extends SettingsScreenState {
  SettingsScreenFailure({
    required this.exception,
  });
  final Object? exception;
}
