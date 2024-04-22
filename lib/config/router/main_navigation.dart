import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:kurs_oop/models/task.dart';
import 'package:kurs_oop/views/categories_screen/view/category_screen.dart';
import 'package:kurs_oop/views/settings_screen/view/settings_screen.dart';
import 'package:kurs_oop/views/task_detail_screen/view/task_detail_screen.dart';
import 'package:kurs_oop/views/tasks_screen/view/tasks_screen.dart';

part 'main_navigation.gr.dart';

//!___________________________________________КОНЕЦ ИМПОРТОВ________________________________________________!\\

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        CustomRoute(
          page: CategoryRoute.page,
          transitionsBuilder: TransitionsBuilders.fadeIn,
          durationInMilliseconds: 300,
          reverseDurationInMilliseconds: 150,
        ),
        CustomRoute(
          page: TasksRoute.page,
          transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
          durationInMilliseconds: 200,
          reverseDurationInMilliseconds: 100,
        ),
        CustomRoute(
          page: TaskDetailRoute.page,
          transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
          durationInMilliseconds: 200,
          reverseDurationInMilliseconds: 100,
        ),
        CustomRoute(
          page: SettingsRoute.page,
          transitionsBuilder: TransitionsBuilders.slideTop,
          durationInMilliseconds: 200,
          reverseDurationInMilliseconds: 100,
        ),
      ];
}
