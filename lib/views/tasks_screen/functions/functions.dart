import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kurs_oop/core/constants.dart';
import 'package:kurs_oop/models/models.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TasksSaving {
  TasksSaving({
    required this.context,
    required this.categoryTitle,
    required this.title,
    required this.description,
    required this.saveChanges,
  });

  final BuildContext context;
  final String categoryTitle, title, description;
  final Function() saveChanges;

  void submitForm({required GlobalKey<FormState> formKey}) {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      saveTask();
      Navigator.pop(context);
    }
  }

  void saveTask() {
    final category = Hive.box<Category>(categoriesBox).get(
      categoryTitle,
    );
    var prefs = GetIt.I<SharedPreferences>();
    int id = prefs.getInt(tasksPreference)!;
    final newTask = Task(
      id: id,
      title: title,
      categoryTitle: categoryTitle,
      description: description.isNotEmpty ? description : null,
      status: 'ToDo',
      tags: [],
    );

    category!.tasks.add(newTask);
    category.save();
    prefs.setInt(tasksPreference, id + 1);
    saveChanges();
  }
}

class TasksMethods {
  TasksMethods({required this.categoryTitle, required this.index});

  final String categoryTitle;
  final int index;

  void todoStatusToggle({required Task task, required Function statusUpdate}) {
    final category = Hive.box<Category>(categoriesBox).get(
      categoryTitle,
    );

    if (task.status == "Done") {
      category?.tasks[index].status = 'ToDo';
      statusUpdate(currentStatus: task.status, newStatus: 'ToDo');
    } else {
      category?.tasks[index].status = 'Done';
      statusUpdate(currentStatus: task.status, newStatus: 'Done');
    }
    category?.save();
  }

  void onDismissed() {
    final category = Hive.box<Category>(categoriesBox).get(
      categoryTitle,
    );

    var prefs = GetIt.I<SharedPreferences>();
    int id = prefs.getInt(tasksPreference)!;

    prefs.setInt(tasksPreference, id - 1);
    category?.tasks.remove(category.tasks[index]);
  }
}
