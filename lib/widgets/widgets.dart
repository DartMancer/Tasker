import 'package:flutter/material.dart';
import 'package:kurs_oop/core/constants.dart';
import 'package:kurs_oop/models/tag.dart';
import 'package:kurs_oop/utils/colors.dart';

class TagBuilder extends StatefulWidget {
  const TagBuilder({
    super.key,
    required this.index,
    required this.tagsList,
    required this.selectedIndex,
    this.isChanging = false,
  });
  final int index;
  final List<Tag> tagsList;
  final List<int> selectedIndex;
  final bool isChanging;

  @override
  State<TagBuilder> createState() => _TagBuilderState();
}

class _TagBuilderState extends State<TagBuilder> {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    double width = mediaQuery.size.width;
    int id = widget.tagsList[widget.index].id;

    bool isSelected = widget.selectedIndex.contains(id);
    Color color =
        TagColors.allTagsColors[widget.tagsList[widget.index].colorKey]!;
    return AnimatedContainer(
      key: ValueKey(widget.tagsList[widget.index]),
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInCubic,
      margin: EdgeInsets.all(width * 0.01282),
      height: width * 0.0948,
      decoration: BoxDecoration(
        color:
            isSelected ? color.withOpacity(0.1) : Colors.grey.withOpacity(0.1),
        border: Border.all(
          width: 1.5,
          color: isSelected ? color : Colors.grey,
        ),
        borderRadius: BorderRadius.circular(200),
      ),
      child: MaterialButton(
        onPressed:
            widget.isChanging ? () => categorySelect(isSelected, id) : null,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(width * 0.041),
        ),
        child: Text(
          widget.tagsList[widget.index].title,
          style: TextStyle(
            fontSize: 16,
            fontFamily: fontApp,
            color: isSelected ? color : Colors.grey,
          ),
        ),
      ),
    );
  }

  void categorySelect(bool isSelected, int id) {
    if (isSelected) {
      setState(() {
        widget.selectedIndex.remove(id);
      });
    } else {
      setState(() {
        widget.selectedIndex.add(id);
      });
    }
  }
}
