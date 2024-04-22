import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kurs_oop/core/constants.dart';
import 'package:kurs_oop/models/category.dart';
import 'package:kurs_oop/models/tag.dart';
import 'package:kurs_oop/utils/logger.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsScreenBloc
    extends Bloc<SettingsScreenEvent, SettingsScreenState> {
  SettingsScreenBloc() : super(SettingsScreenInitial()) {
    on<LoadSettingsScreen>((event, emit) {
      try {
        final List<Tag> tags = getTags();
        emit(SettingsScreenLoaded(tagsList: tags));
      } catch (e, st) {
        emit(SettingsScreenFailure(exception: e));
        Logger().handle(e, st);
      }
    });
  }

  List<Tag> getTags() {
    final box = Hive.box<Tag>(tagsBox);
    List<Tag> tags = [];
    for (var i = 0; i < box.length; i++) {
      tags.add(box.getAt(i)!);
    }
    tags.sort((a, b) => a.id.compareTo(b.id));

    return tags;
  }
}
