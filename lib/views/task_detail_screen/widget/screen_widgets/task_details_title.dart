import 'package:flutter/material.dart';
import 'package:kurs_oop/core/constants.dart';

class TaskDetailsTitle extends StatelessWidget {
  const TaskDetailsTitle({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        title,
        style: const TextStyle(
          fontFamily: fontApp,
          fontWeight: FontWeight.bold,
          fontSize: 32,
        ),
      ),
    );
  }
}
