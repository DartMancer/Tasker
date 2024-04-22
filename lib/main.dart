import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kurs_oop/config/router/main_navigation.dart';
import 'package:kurs_oop/core/constants.dart';
import 'package:kurs_oop/models/models.dart';

import 'package:timezone/data/latest.dart' as tz;
import 'package:kurs_oop/utils/logger.dart';
import 'package:talker_bloc_logger/talker_bloc_logger.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'tasker_app.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  tz.initializeTimeZones();
  Talker talker = regTalker();
  GetIt.I.registerSingleton<AppRouter>(AppRouter());
  WidgetsFlutterBinding.ensureInitialized();
  await regHive();
  regBloc(talker);
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const ToDoApp());
}

Future<void> regHive() async {
  await Hive.initFlutter();
  // Регистрация адаптеров
  Hive.registerAdapter<Category>(CategoryAdapter());
  Hive.registerAdapter<Task>(TaskAdapter());
  Hive.registerAdapter<Tag>(TagAdapter());

  GetIt.I.registerSingleton(await SharedPreferences.getInstance());
  var prefs = GetIt.I<SharedPreferences>();
  if (prefs.getInt(tasksPreference) == null) {
    prefs.setInt(tasksPreference, 0);
  }
  if (prefs.getInt(categoryPreference) == null) {
    prefs.setInt(categoryPreference, 0);
  }
  if (prefs.getInt(tagsPreference) == null) {
    prefs.setInt(tagsPreference, 0);
  }

  await Hive.openBox<Category>(categoriesBox);
  await Hive.openBox<Task>(tasksBox);
  await Hive.openBox<Tag>(tagsBox);
}

Talker regTalker() {
  final talker = TalkerFlutter.init();
  GetIt.I.registerSingleton(talker);
  Logger().debug('Talker started...');
  return talker;
}

void regBloc(Talker talker) {
  Bloc.observer = TalkerBlocObserver(
    talker: talker,
    settings: const TalkerBlocLoggerSettings(
      printStateFullData: false,
      printEventFullData: false,
    ),
  );
}

Future<void> initializeNotifications() async {
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  const DarwinInitializationSettings initializationSettingsIOS =
      DarwinInitializationSettings(
    requestAlertPermission: true,
    requestBadgePermission: true,
    requestSoundPermission: true,
  );
  const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onDidReceiveNotificationResponse: backgroundHandler,
  );
}

void backgroundHandler(NotificationResponse response) {
  Logger().debug("Handling a background notification: ${response.payload}");
}
