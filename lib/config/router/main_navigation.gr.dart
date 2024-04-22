// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'main_navigation.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    CategoryRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const CategoryScreen(),
      );
    },
    SettingsRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SettingsScreen(),
      );
    },
    TaskDetailRoute.name: (routeData) {
      final args = routeData.argsAs<TaskDetailRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: TaskDetailScreen(
          key: args.key,
          task: args.task,
        ),
      );
    },
    TasksRoute.name: (routeData) {
      final args = routeData.argsAs<TasksRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: TasksScreen(
          key: args.key,
          tasksList: args.tasksList,
          categoryTitle: args.categoryTitle,
        ),
      );
    },
  };
}

/// generated route for
/// [CategoryScreen]
class CategoryRoute extends PageRouteInfo<void> {
  const CategoryRoute({List<PageRouteInfo>? children})
      : super(
          CategoryRoute.name,
          initialChildren: children,
        );

  static const String name = 'CategoryRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [SettingsScreen]
class SettingsRoute extends PageRouteInfo<void> {
  const SettingsRoute({List<PageRouteInfo>? children})
      : super(
          SettingsRoute.name,
          initialChildren: children,
        );

  static const String name = 'SettingsRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [TaskDetailScreen]
class TaskDetailRoute extends PageRouteInfo<TaskDetailRouteArgs> {
  TaskDetailRoute({
    Key? key,
    required Task task,
    List<PageRouteInfo>? children,
  }) : super(
          TaskDetailRoute.name,
          args: TaskDetailRouteArgs(
            key: key,
            task: task,
          ),
          initialChildren: children,
        );

  static const String name = 'TaskDetailRoute';

  static const PageInfo<TaskDetailRouteArgs> page =
      PageInfo<TaskDetailRouteArgs>(name);
}

class TaskDetailRouteArgs {
  const TaskDetailRouteArgs({
    this.key,
    required this.task,
  });

  final Key? key;

  final Task task;

  @override
  String toString() {
    return 'TaskDetailRouteArgs{key: $key, task: $task}';
  }
}

/// generated route for
/// [TasksScreen]
class TasksRoute extends PageRouteInfo<TasksRouteArgs> {
  TasksRoute({
    Key? key,
    required List<Task> tasksList,
    required String categoryTitle,
    List<PageRouteInfo>? children,
  }) : super(
          TasksRoute.name,
          args: TasksRouteArgs(
            key: key,
            tasksList: tasksList,
            categoryTitle: categoryTitle,
          ),
          initialChildren: children,
        );

  static const String name = 'TasksRoute';

  static const PageInfo<TasksRouteArgs> page = PageInfo<TasksRouteArgs>(name);
}

class TasksRouteArgs {
  const TasksRouteArgs({
    this.key,
    required this.tasksList,
    required this.categoryTitle,
  });

  final Key? key;

  final List<Task> tasksList;

  final String categoryTitle;

  @override
  String toString() {
    return 'TasksRouteArgs{key: $key, tasksList: $tasksList, categoryTitle: $categoryTitle}';
  }
}
