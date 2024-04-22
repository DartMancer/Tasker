import 'package:flutter/material.dart';

import 'package:kurs_oop/models/task.dart';
import 'package:kurs_oop/core/constants.dart';
import 'package:kurs_oop/utils/app_colors.dart';
import 'package:kurs_oop/config/router/main_navigation.dart';
import 'package:kurs_oop/views/tasks_screen/tasks_screen.dart';

import 'package:get_it/get_it.dart';
import 'package:auto_route/auto_route.dart';

@RoutePage()
class TasksScreen extends StatefulWidget {
  const TasksScreen({
    super.key,
    required this.tasksList,
    required this.categoryTitle,
  });

  final List<Task> tasksList;
  final String categoryTitle;

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  @override
  void initState() {
    GetIt.I<AppRouter>().addListener(_routerListener);
    super.initState();
  }

  @override
  void dispose() {
    GetIt.I<AppRouter>().removeListener(_routerListener);
    super.dispose();
  }

  void _routerListener() {
    var route = GetIt.I<AppRouter>().current;
    if (route.name == 'TasksRoute') {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Задачи',
          style: TextStyle(
            fontSize: 26,
            fontFamily: fontApp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: TasksList(
        categoryTitle: widget.categoryTitle,
        tasksList: widget.tasksList,
        statusUpdate: statusUpdate,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AddTaskScreen(
              categoryTitle: widget.categoryTitle,
              saveChanges: () {
                setState(() {});
              },
            ),
          );
        },
        backgroundColor: AppColors.primary,
        child: const Icon(
          Icons.add,
          color: AppColors.highlight,
        ),
      ),
    );
  }

  void statusUpdate({
    required String currentStatus,
    required String newStatus,
  }) {
    setState(() => currentStatus = newStatus);
  }
}
