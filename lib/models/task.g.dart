// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TaskAdapter extends TypeAdapter<Task> {
  @override
  final int typeId = 1;

  @override
  Task read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Task(
      id: fields[0] as int,
      title: fields[1] as String,
      tags: (fields[2] as List).cast<Tag>(),
      status: fields[3] as String,
      categoryTitle: fields[4] as String,
      description: fields[5] as String?,
      deadline: (fields[6] as List?)?.cast<DateTime>(),
      estimatedTime: fields[7] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Task obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.tags)
      ..writeByte(3)
      ..write(obj.status)
      ..writeByte(4)
      ..write(obj.categoryTitle)
      ..writeByte(5)
      ..write(obj.description)
      ..writeByte(6)
      ..write(obj.deadline)
      ..writeByte(7)
      ..write(obj.estimatedTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
