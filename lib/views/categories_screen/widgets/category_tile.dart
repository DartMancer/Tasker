import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:kurs_oop/config/router/main_navigation.dart';
import 'package:kurs_oop/core/constants.dart';
import 'package:kurs_oop/models/task.dart';
import 'package:kurs_oop/utils/app_colors.dart';
import 'package:kurs_oop/utils/logger.dart';

class CategoryTile extends StatefulWidget {
  const CategoryTile({
    super.key,
    required this.id,
    required this.title,
    required this.icon,
    required this.gradient,
    required this.tasksList,
    // required this.completedTasks,
    // required this.totalTasks,
    required this.isDeletingMode,
    required this.deleteToggle,
  });

  final int id;
  final String title;
  final IconData icon;
  final List<Color> gradient;
  final List<Task> tasksList;
  // final int completedTasks;
  // final int totalTasks;
  final bool isDeletingMode;
  final Function() deleteToggle;
  @override
  State<CategoryTile> createState() => _CategoryTileState();
}

class _CategoryTileState extends State<CategoryTile> {
  @override
  Widget build(BuildContext context) {
    int tasksCount = widget.tasksList.length;
    int completedTasks = widget.tasksList
        .where(
          (task) => task.status == 'Done',
        )
        .length;
    return GestureDetector(
      onTap: () {
        GetIt.I<AppRouter>().push(
          TasksRoute(tasksList: widget.tasksList, categoryTitle: widget.title),
        );
      },
      onLongPress: () {
        widget.deleteToggle();
        Logger().debug('Long press');
      },
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: widget.gradient,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    widget.icon,
                    color: AppColors.onBackground,
                    size: 45,
                  ),
                  Text(
                    widget.title,
                    style: const TextStyle(
                      color: AppColors.onBackground,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: fontApp,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 10,
              left: 10,
              child: Text(
                "$completedTasks/$tasksCount",
                style: const TextStyle(
                  color: AppColors.onBackground,
                  fontSize: 16,
                  fontFamily: fontApp,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
