import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:kurs_oop/models/tag.dart';
import 'package:kurs_oop/core/constants.dart';
import 'package:kurs_oop/utils/app_colors.dart';
import 'package:kurs_oop/views/settings_screen/settings_screen.dart';

import 'package:auto_route/auto_route.dart';

@RoutePage()
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isActiveTag = false;
  final _settingsBloc = SettingsScreenBloc();

  @override
  void initState() {
    _settingsBloc.add(LoadSettingsScreen());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    double width = mediaQuery.size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Настройки',
          style: TextStyle(
            fontSize: 26,
            fontFamily: fontApp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: BlocBuilder<SettingsScreenBloc, SettingsScreenState>(
        bloc: _settingsBloc,
        builder: (context, state) {
          if (state is SettingsScreenLoaded) {
            List<Tag> tags = state.tagsList;
            return SizedBox(
              width: width,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: width * 0.1),
                    AnimatedCrossFade(
                      firstChild: SettingsScreenButton(
                        title: 'Теги',
                        icon: Icons.tag_rounded,
                        onPressed: () {
                          setState(() {
                            isActiveTag = !isActiveTag;
                          });
                        },
                      ),
                      secondChild: Column(
                        children: [
                          SettingsScreenButton(
                            title: 'Теги',
                            icon: Icons.tag_rounded,
                            onPressed: () {
                              setState(() {
                                isActiveTag = !isActiveTag;
                              });
                            },
                          ),
                          TagsList(tags: tags),
                          AddTagButton(settingsBloc: _settingsBloc)
                        ],
                      ),
                      crossFadeState: isActiveTag
                          ? CrossFadeState.showSecond
                          : CrossFadeState.showFirst,
                      duration: const Duration(milliseconds: 300),
                      sizeCurve: Curves.easeInCubic,
                    ),
                    SettingsScreenButton(
                      title: 'Тема приложения',
                      icon: Icons.dark_mode,
                      onPressed: () {},
                    ),
                    SettingsScreenButton(
                      title: 'Язык приложения',
                      icon: Icons.language,
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(
              color: AppColors.primary,
            ),
          );
        },
      ),
    );
  }
}
