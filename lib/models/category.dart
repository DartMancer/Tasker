import 'package:hive/hive.dart';
import 'package:kurs_oop/models/models.dart';
import 'package:kurs_oop/models/task.dart';

part 'category.g.dart';

@HiveType(typeId: 0)
class Category extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String gradientKey;

  @HiveField(3)
  final String iconKey;

  @HiveField(4)
  List<Task> tasks;

  Category({
    required this.id,
    required this.title,
    required this.iconKey,
    required this.gradientKey,
    required this.tasks,
  });
}
