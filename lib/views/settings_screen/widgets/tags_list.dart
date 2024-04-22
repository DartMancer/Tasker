import 'package:flutter/material.dart';
import 'package:kurs_oop/core/constants.dart';
import 'package:kurs_oop/models/models.dart';
import 'package:kurs_oop/utils/utils.dart';

class TagsList extends StatelessWidget {
  const TagsList({super.key, required this.tags});

  final List<Tag> tags;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    double width = mediaQuery.size.width;
    return SingleChildScrollView(
      child: Column(
        children: List.generate(tags.length, (index) {
          Color color = TagColors.allTagsColors[tags[index].colorKey]!;
          return Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 5,
                  horizontal: 30,
                ),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  border: Border.all(
                    width: 1.5,
                    color: color,
                  ),
                  borderRadius: BorderRadius.circular(width),
                ),
                child: Text(
                  tags[index].title,
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: fontApp,
                    color: color,
                  ),
                ),
              ),
              const SizedBox(height: 10),
            ],
          );
        }),
      ),
    );
  }
}
