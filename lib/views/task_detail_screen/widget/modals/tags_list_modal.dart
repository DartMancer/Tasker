import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:kurs_oop/config/router/main_navigation.dart';
import 'package:kurs_oop/core/constants.dart';
import 'package:kurs_oop/models/models.dart';
import 'package:kurs_oop/widgets/widgets.dart';

class TagsListModal extends StatelessWidget {
  const TagsListModal({
    super.key,
    required this.allTags,
    required this.selectedIndex,
  });

  final List<Tag> allTags;
  final List<int> selectedIndex;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    double width = mediaQuery.size.width;
    return StatefulBuilder(
      builder: (context, setState) {
        return ListView(
          physics: const AlwaysScrollableScrollPhysics(
            parent: BouncingScrollPhysics(),
          ),
          padding: EdgeInsets.all(width * 0.04128),
          children: [
            const Text(
              'Теги',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontFamily: fontApp,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Wrap(
              children: List.generate(
                allTags.length,
                (index) => TagBuilder(
                  index: index,
                  tagsList: allTags,
                  selectedIndex: selectedIndex,
                  isChanging: true,
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () {
                GetIt.I<AppRouter>().popForced();
                GetIt.I<AppRouter>().push(const SettingsRoute());
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add),
                  SizedBox(width: 10),
                  Text(
                    'Добавить теги',
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: fontApp,
                    ),
                  ),
                ],
              ),
            )
          ],
        );
      },
    );
  }
}
