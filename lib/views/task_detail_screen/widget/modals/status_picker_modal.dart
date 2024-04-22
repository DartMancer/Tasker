import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:kurs_oop/config/router/main_navigation.dart';
import 'package:kurs_oop/core/constants.dart';
import 'package:kurs_oop/models/models.dart';

class StatusPickerModal extends StatelessWidget {
  const StatusPickerModal({
    super.key,
    required this.statusOptions,
    required this.task,
    required this.saveStatus,
  });

  final List<Map<String, dynamic>> statusOptions;
  final Task task;
  final Function saveStatus;

  @override
  Widget build(BuildContext context) {
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
            ...statusOptions.map((option) {
              bool isSelected = task.status == option['status'];
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
                      color: option['status'] == 'ToDo'
                          ? Colors.grey
                          : Colors.green,
                    ),
                    title: Text(
                      option['status'],
                      style: const TextStyle(
                        fontFamily: fontApp,
                      ),
                    ),
                    trailing: isSelected
                        ? const Icon(Icons.check, color: Colors.blue)
                        : null,
                    onTap: () {
                      setState(() => task.status = option['status']);
                      saveStatus(newStatus: option['status']);
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
