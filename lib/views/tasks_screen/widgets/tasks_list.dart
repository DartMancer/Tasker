import 'package:flutter/material.dart';

import 'package:kurs_oop/models/models.dart';
import 'package:kurs_oop/config/router/main_navigation.dart';
import 'package:kurs_oop/views/tasks_screen/tasks_screen.dart';

import 'package:get_it/get_it.dart';

class TasksList extends StatelessWidget {
  const TasksList({
    super.key,
    required this.categoryTitle,
    required this.tasksList,
    required this.statusUpdate,
  });

  final String categoryTitle;
  final List<Task> tasksList;
  final Function statusUpdate;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: tasksList.length,
      itemBuilder: (context, index) {
        var task = tasksList[index];
        return Dismissible(
          key: Key(task.id.toString()),
          background: Container(
            color: Colors.red,
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: const Icon(Icons.delete, color: Colors.white),
          ),
          direction: DismissDirection.endToStart,
          onDismissed: (direction) {
            TasksMethods(
              categoryTitle: categoryTitle,
              index: index,
            ).onDismissed();
          },
          child: CustomTaskTile(
            title: task.title,
            description: task.description,
            isCompleted: task.status == 'Done',
            onStatusChanged: (bool? newValue) {
              TasksMethods(
                categoryTitle: categoryTitle,
                index: index,
              ).todoStatusToggle(
                task: task,
                statusUpdate: statusUpdate,
              );
            },
            onTap: () {
              GetIt.I<AppRouter>().push(TaskDetailRoute(task: task));
            },
          ),
        );
      },
    );
  }
}
