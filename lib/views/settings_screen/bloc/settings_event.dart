part of 'settings_bloc.dart';

class SettingsScreenEvent {}

class LoadSettingsScreen extends SettingsScreenEvent {
  LoadSettingsScreen({
    this.completer,
  });

  final Completer? completer;
}

class UpdateCategoryCompletedTasks extends SettingsScreenEvent {
  final Category category;

  UpdateCategoryCompletedTasks(this.category);
}
