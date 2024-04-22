import 'package:flutter/material.dart';
import 'package:kurs_oop/core/constants.dart';
import 'package:kurs_oop/views/tasks_screen/functions/functions.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({
    super.key,
    required this.categoryTitle,
    required this.saveChanges,
  });

  final String categoryTitle;
  final Function() saveChanges;

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  String _description = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Добавить задачу",
          style: TextStyle(
            fontFamily: fontApp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              TextFormField(
                style: const TextStyle(
                  fontFamily: fontApp,
                  fontWeight: FontWeight.normal,
                ),
                decoration: const InputDecoration(
                  labelText: 'Название',
                  labelStyle: TextStyle(
                    fontFamily: fontApp,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                onChanged: (value) => setState(() => _title = value),
                validator: (value) => value!.isEmpty
                    ? 'Пожалуйста, введите название задачи'
                    : null,
              ),
              TextFormField(
                style: const TextStyle(
                  fontFamily: fontApp,
                  fontWeight: FontWeight.normal,
                ),
                decoration: const InputDecoration(
                  labelText: 'Описание',
                  labelStyle: TextStyle(
                    fontFamily: fontApp,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                onChanged: (value) => setState(() => _description = value),
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  TasksSaving(
                    context: context,
                    categoryTitle: widget.categoryTitle,
                    title: _title,
                    description: _description,
                    saveChanges: widget.saveChanges,
                  ).submitForm(formKey: _formKey);
                },
                child: const Text(
                  'Добавить задачу',
                  style: TextStyle(
                    fontFamily: fontApp,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
