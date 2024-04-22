import 'package:flutter/material.dart';
import 'package:kurs_oop/models/models.dart';
import 'package:kurs_oop/widgets/widgets.dart';

class TagsPropertyList extends StatelessWidget {
  const TagsPropertyList({
    super.key,
    required this.task,
    required this.selectedIndex,
  });

  final Task task;
  final List<int> selectedIndex;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 37,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: task.tags.length,
        itemBuilder: (context, index) {
          return TagBuilder(
            index: index,
            tagsList: task.tags,
            selectedIndex: selectedIndex,
          );
        },
      ),
    );
  }
}
