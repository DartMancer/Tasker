import 'package:flutter/material.dart';
import 'package:kurs_oop/core/constants.dart';
import 'package:kurs_oop/models/models.dart';
import 'package:kurs_oop/utils/utils.dart';
import 'package:kurs_oop/views/task_detail_screen/task_detail_screen.dart';

class AddPropertyButton extends StatelessWidget {
  const AddPropertyButton({
    super.key,
    required this.task,
    required this.selectedIndex,
    required this.saveDeadline,
    required this.saveEstimated,
    required this.saveTags,
  });

  final Task task;
  final List<int> selectedIndex;
  final Function saveDeadline;
  final Function saveEstimated;
  final Function saveTags;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        Icons.add,
        color: TaskMethods(
          context: context,
          task: task,
        ).hasAvailableProperties()
            ? AppColors.primary
            : Colors.grey,
      ),
      title: Text(
        "Добавить параметр",
        style: TextStyle(
          fontFamily: fontApp,
          color: TaskMethods(
            context: context,
            task: task,
          ).hasAvailableProperties()
              ? AppColors.primary
              : Colors.grey,
        ),
      ),
      onTap: TaskMethods(
        context: context,
        task: task,
      ).hasAvailableProperties()
          ? () {
              TaskMethods(
                context: context,
                task: task,
              ).showAddPropertyModal(
                selectedIndex: selectedIndex,
                saveDeadline: saveDeadline,
                saveEstimate: saveEstimated,
                saveTags: saveTags,
              );
            }
          : null,
    );
  }
}
