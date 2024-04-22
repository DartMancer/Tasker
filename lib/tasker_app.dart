import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:kurs_oop/config/router/main_navigation.dart';
import 'package:talker_flutter/talker_flutter.dart';

class ToDoApp extends StatefulWidget {
  const ToDoApp({super.key});

  @override
  State<ToDoApp> createState() => _VkurseAppState();
}

class _VkurseAppState extends State<ToDoApp> {
  @override
  Widget build(BuildContext context) => MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'ToDo App',
        localizationsDelegates: const [
          GlobalCupertinoLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          DefaultCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('ru', 'RU'),
        ],
        routerConfig: GetIt.I<AppRouter>().config(
          deepLinkBuilder: (deepLink) async {
            return DeepLink.single(const CategoryRoute());
          },
          navigatorObservers: () => [
            TalkerRouteObserver(GetIt.I<Talker>()),
          ],
        ),
      );
}
