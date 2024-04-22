import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:kurs_oop/config/router/main_navigation.dart';
import 'package:kurs_oop/core/constants.dart';
import 'package:kurs_oop/models/models.dart';
import 'package:kurs_oop/utils/logger.dart';

class PriorityPickerModal extends StatelessWidget {
  const PriorityPickerModal({
    super.key,
    required this.task,
    required this.savePriority,
  });

  final Task task;
  final Function savePriority;

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> priorityOptions = [
      {
        'priority': highPriorityTag,
        'text': 'High',
        'label': 'Высокий приоритет'
      },
      {'priority': lowPriorityTag, 'text': 'Low', 'label': 'Низкий приоритет'},
    ];
    return StatefulBuilder(
      builder: (context, setState) => Container(
        height: 350,
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(width: 30),
                  const Text(
                    'Статус',
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: fontApp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    onPressed: () => GetIt.I<AppRouter>().popForced(),
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
            ),
            const Divider(),
            ...priorityOptions.map((option) {
              bool isSelected = task.priority == option['priority'];
              return Column(
                children: [
                  ListTile(
                    title: Text(
                      option['label'],
                      style: const TextStyle(
                        fontFamily: fontApp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.radio_button_checked_outlined,
                      color: option['priority'] == highPriorityTag
                          ? Colors.red
                          : Colors.green,
                    ),
                    title: Text(
                      option['text'],
                      style: const TextStyle(
                        fontFamily: fontApp,
                      ),
                    ),
                    trailing: isSelected
                        ? const Icon(Icons.check, color: Colors.blue)
                        : null,
                    onTap: () {
                      setState(() => task.priority = option['priority']);
                      Logger().debug(option['priority'].runtimeType);
                      savePriority(newPriority: option['priority']);
                    },
                  ),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }
}
