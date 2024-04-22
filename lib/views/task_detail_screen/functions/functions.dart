import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:kurs_oop/core/constants.dart';
import 'package:kurs_oop/models/category.dart';
import 'package:kurs_oop/models/reminder.dart';
import 'package:kurs_oop/models/tag.dart';
import 'package:kurs_oop/models/task.dart';
import 'package:kurs_oop/views/task_detail_screen/task_detail_screen.dart';

class TaskMethods {
  TaskMethods({
    required this.context,
    required this.task,
  });

  final BuildContext context;
  final Task task;

  void showStatusPicker({
    required Function saveStatus,
  }) {
    final List<Map<String, dynamic>> statusOptions = [
      {'status': 'ToDo', 'label': 'Not started'},
      {'status': 'Done', 'label': 'Completed'},
    ];

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return StatusPickerModal(
          statusOptions: statusOptions,
          task: task,
          saveStatus: saveStatus,
        );
      },
    );
  }

  Future<void> pickDateRange({
    required Function saveDeadline,
  }) async {
    DateTimeRange? newDateRange = await showDateRangePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
      saveText: 'Сохранить',
      locale: const Locale('ru', 'RU'),
    );

    if (newDateRange != null) {
      task.deadline?.add(newDateRange.start);
      task.deadline?.add(newDateRange.end);
      List<DateTime> newDates = [newDateRange.start, newDateRange.end];

      DateTime currentDate = DateTime.now();
      int substractDate = newDateRange.end
          .subtract(const Duration(days: 2))
          .compareTo(currentDate);

      saveDeadline(newDates: newDates);
      if (task.priority != null && substractDate != -1) {
        if (task.priority == highPriorityTag) {
          HighPriorityReminder(
            title: task.title,
            // remindAt: newDateRange.end.subtract(const Duration(days: 2)),
            remindAt: DateTime.now().add(const Duration(seconds: 5)),
          ).triggerNotificaton();
        } else if (task.priority == lowPriorityTag) {
          LowPriorityReminder(
            title: task.title,
            // remindAt: newDateRange.end.subtract(const Duration(days: 2)),
            remindAt: DateTime.now().add(const Duration(seconds: 5)),
          ).triggerNotificaton();
        }
      }
    }
  }

  void pickEstimatedTime({
    required Function saveEstimate,
  }) {
    final TextEditingController hoursController = TextEditingController();
    final TextEditingController minutesController = TextEditingController();
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return EstimatedTimePickerModal(
          hoursController: hoursController,
          minutesController: minutesController,
          saveEstimate: saveEstimate,
        );
      },
    );
  }

  void showPriorityPicker({
    required Function savePriority,
  }) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return PriorityPickerModal(
          task: task,
          savePriority: savePriority,
        );
      },
    );
  }

  void showTagsModal({
    required List<int> selectedIndex,
    required Function saveTags,
  }) {
    final allTags = Hive.box<Tag>(tagsBox).values.toList();

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return TagsListModal(
          allTags: allTags,
          selectedIndex: selectedIndex,
        );
      },
    ).then((_) {
      List<Tag> updatedTags = [];
      for (var tag in allTags) {
        if (selectedIndex.contains(tag.id)) {
          updatedTags.add(tag);
        }
      }
      saveTags(tagsUpdate: updatedTags);
    });
  }

  void showAddPropertyModal({
    required List<int> selectedIndex,
    required Function saveDeadline,
    required Function saveEstimate,
    required Function saveTags,
  }) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        final List<Widget> availableProperties = [];
        if (task.deadline == null) {
          availableProperties.add(
            PropertyWidget(
              label: 'Добавить даты',
              icon: Icons.calendar_today,
              onTap: () {
                pickDateRange(
                  saveDeadline: saveDeadline,
                );
              },
            ),
          );
        }
        if (task.estimatedTime == null) {
          availableProperties.add(
            PropertyWidget(
              label: 'Время выполнения',
              icon: Icons.more_time,
              onTap: () {
                pickEstimatedTime(
                  saveEstimate: saveEstimate,
                );
              },
            ),
          );
        }
        if (task.tags.isEmpty) {
          availableProperties.add(
            PropertyWidget(
              label: 'Теги',
              icon: Icons.tag,
              onTap: () {
                showTagsModal(
                  selectedIndex: selectedIndex,
                  saveTags: saveTags,
                );
              },
            ),
          );
        }
        if (task.priority == null) {
          availableProperties.add(
            PropertyWidget(
              label: 'Приоритет',
              icon: Icons.priority_high_rounded,
              onTap: () {
                showPriorityPicker(savePriority: () {});
              },
            ),
          );
        }

        return Padding(
          padding: const EdgeInsets.only(top: 20),
          child: ListView.builder(
            itemCount: availableProperties.length,
            itemBuilder: (context, index) {
              return availableProperties[index];
            },
          ),
        );
      },
    );
  }

  void showDescriptionModal({
    required String currentDescription,
    required Function saveDescription,
  }) {
    final descriptionController = TextEditingController();
    descriptionController.text = currentDescription;
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return DescriptionModal(
          descriptionController: descriptionController,
          saveDescription: saveDescription,
        );
      },
    );
  }

  void categoryUpdate() {
    final category = Hive.box<Category>(categoriesBox).get(
      task.categoryTitle,
    );

    category?.save();
  }

  String dateFormat(DateTime date) =>
      DateFormat('dd MMM, yyyy', 'ru_RU').format(date);

  bool hasAvailableProperties() {
    return task.estimatedTime == null ||
        task.deadline == null ||
        task.tags.isEmpty ||
        task.priority == null;
  }
}
