import 'package:flutter/material.dart';
import 'package:kurs_oop/core/constants.dart';
import 'package:kurs_oop/models/models.dart';
import 'package:kurs_oop/views/task_detail_screen/task_detail_screen.dart';

class DescriptionTile extends StatelessWidget {
  const DescriptionTile({
    super.key,
    required this.task,
    required this.saveDescription,
  });

  final Task task;
  final Function saveDescription;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: const Text(
        "Описание",
        style: TextStyle(
          fontSize: 22,
          fontFamily: fontApp,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(
        task.description == null
            ? "Нажмите, чтобы добавить описание"
            : task.description!,
        style: const TextStyle(
          fontSize: 16,
          fontFamily: fontApp,
        ),
      ),
      onTap: () {
        TaskMethods(
          context: context,
          task: task,
        ).showDescriptionModal(
          currentDescription:
              task.description ?? 'Нажмите, чтобы добавить описание',
          saveDescription: saveDescription,
        );
      },
    );
  }
}
