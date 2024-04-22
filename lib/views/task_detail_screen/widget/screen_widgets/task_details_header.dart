import 'package:flutter/material.dart';
import 'package:kurs_oop/core/constants.dart';

class TaskDetailsHeader extends StatelessWidget {
  const TaskDetailsHeader({
    super.key,
    required this.categoryTitle,
  });

  final String categoryTitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        categoryTitle,
        style: const TextStyle(
          fontSize: 16,
          fontFamily: fontApp,
          color: Colors.grey,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
