import 'package:hive_flutter/hive_flutter.dart';

part 'tag.g.dart';

@HiveType(typeId: 2)
class Tag {
  Tag({
    required this.id,
    required this.title,
    required this.colorKey,
  });

  @HiveField(0)
  final int id;

  @HiveField(1)
  String title;

  @HiveField(2)
  String colorKey;
}
