import 'package:flutter/material.dart';

import 'package:kurs_oop/utils/utils.dart';
import 'package:kurs_oop/models/models.dart';
import 'package:kurs_oop/core/constants.dart';
import 'package:kurs_oop/views/task_detail_screen/task_detail_screen.dart';

import 'package:auto_route/auto_route.dart';

@RoutePage()
class TaskDetailScreen extends StatefulWidget {
  final Task task;

  const TaskDetailScreen({
    super.key,
    required this.task,
  });

  @override
  State<TaskDetailScreen> createState() => _TaskDetailScreenState();
}

class _TaskDetailScreenState extends State<TaskDetailScreen> {
  List<int> selectedIndex = [];
  late Task task;

  @override
  void initState() {
    for (var tag in widget.task.tags) {
      selectedIndex.add(tag.id);
    }
    task = widget.task;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'О задаче',
            style: TextStyle(
              fontSize: 26,
              fontFamily: fontApp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: ListView(
          children: <Widget>[
            TaskDetailsHeader(categoryTitle: task.categoryTitle),
            TaskDetailsTitle(title: task.title),
            PropertyTile(
              title: 'Статус',
              subtitle: Text(
                task.status,
                style: const TextStyle(
                  fontFamily: fontApp,
                ),
              ),
              icon: Icons.flag,
              visible: true,
              task: task,
              onTap: () {
                TaskMethods(
                  context: context,
                  task: task,
                ).showStatusPicker(saveStatus: saveStatus);
              },
            ),
            PropertyTile(
              title: 'Добавить даты',
              subtitle: task.deadline != null
                  ? Text(
                      '${TaskMethods(context: context, task: task).dateFormat(task.deadline![0])} - ${TaskMethods(context: context, task: task).dateFormat(task.deadline![1])}',
                      style: const TextStyle(
                        fontFamily: fontApp,
                      ),
                    )
                  : null,
              icon: Icons.calendar_today,
              visible: task.deadline != null,
              task: task,
              onTap: () {
                TaskMethods(
                  context: context,
                  task: task,
                ).pickDateRange(saveDeadline: saveDeadline);
              },
            ),
            PropertyTile(
              title: 'Теги',
              subtitle: task.tags.isNotEmpty
                  ? TagsPropertyList(task: task, selectedIndex: selectedIndex)
                  : null,
              icon: Icons.label,
              visible: task.tags.isNotEmpty,
              task: task,
              onTap: () {
                TaskMethods(
                  context: context,
                  task: task,
                ).showTagsModal(
                  selectedIndex: selectedIndex,
                  saveTags: saveTags,
                );
              },
            ),
            PropertyTile(
              title: 'Время выполнения',
              subtitle: Text(
                task.estimatedTime ?? task.estimatedTime.toString(),
                style: const TextStyle(
                  fontFamily: fontApp,
                ),
              ),
              icon: Icons.more_time_rounded,
              visible: task.estimatedTime != null,
              task: task,
              onTap: () {
                TaskMethods(
                  context: context,
                  task: task,
                ).pickEstimatedTime(saveEstimate: saveEstimated);
              },
            ),
            PropertyTile(
              title: 'Приоритет',
              subtitle: Text(
                task.priority ?? task.priority.toString(),
                style: const TextStyle(
                  fontFamily: fontApp,
                ),
              ),
              icon: Icons.priority_high_outlined,
              visible: task.priority != null,
              task: task,
              onTap: () {
                TaskMethods(
                  context: context,
                  task: task,
                ).showPriorityPicker(savePriority: savePriority);
              },
            ),
            AddPropertyButton(
              task: task,
              selectedIndex: selectedIndex,
              saveDeadline: saveDeadline,
              saveEstimated: saveEstimated,
              saveTags: saveTags,
            ),
            Container(height: 10, color: AppColors.highlight),
            DescriptionTile(task: task, saveDescription: saveDescription),
          ],
        ),
      ),
    );
  }

  void saveStatus({required String newStatus}) {
    setState(() => task.status = newStatus);
    TaskMethods(context: context, task: task).categoryUpdate();
  }

  void savePriority({required String newPriority}) {
    setState(() => task.priority = newPriority);
    TaskMethods(context: context, task: task).categoryUpdate();
  }

  void saveDeadline({required List<DateTime> newDates}) {
    setState(() => task.deadline = newDates);
    TaskMethods(context: context, task: task).categoryUpdate();
  }

  void saveEstimated({required String newEstimate}) {
    setState(() => task.estimatedTime = newEstimate);
    TaskMethods(context: context, task: task).categoryUpdate();
  }

  void saveTags({required List<Tag> tagsUpdate}) {
    setState(() => task.tags = tagsUpdate);
    TaskMethods(context: context, task: task).categoryUpdate();
  }

  void saveDescription({required String descriptionUpdate}) {
    setState(() => task.description = descriptionUpdate);
    TaskMethods(context: context, task: task).categoryUpdate();
  }
}
