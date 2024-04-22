import 'package:hive_flutter/hive_flutter.dart';
import 'package:kurs_oop/models/tag.dart';

part 'task.g.dart';

@HiveType(typeId: 1)
class Task {
  @HiveField(0)
  final int id;

  @HiveField(1)
  String title;

  @HiveField(2)
  List<Tag> tags;

  @HiveField(3)
  String status;

  @HiveField(4)
  final String categoryTitle;

  @HiveField(5)
  String? description;

  @HiveField(6)
  List<DateTime>? deadline;

  @HiveField(7)
  String? estimatedTime;

  @HiveField(8)
  String? priority;

  Task({
    required this.id,
    required this.title,
    required this.tags,
    required this.status,
    required this.categoryTitle,
    this.description,
    this.deadline,
    this.estimatedTime,
    this.priority,
  });
}
