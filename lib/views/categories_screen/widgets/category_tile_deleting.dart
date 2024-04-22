import 'package:flutter/material.dart';
import 'package:kurs_oop/core/constants.dart';
import 'package:kurs_oop/utils/app_colors.dart';

class CategoryTileDeleting extends StatefulWidget {
  const CategoryTileDeleting({
    super.key,
    required this.id,
    required this.title,
    required this.icon,
    required this.gradient,
    required this.isDeletingMode,
    required this.selectedCategories,
    required this.deleteToggle,
    required this.hasDeleteElements,
  });

  final int id;
  final String title;
  final IconData icon;
  final List<Color> gradient;

  final bool isDeletingMode;
  final List<int> selectedCategories;
  final Function() deleteToggle, hasDeleteElements;

  @override
  State<CategoryTileDeleting> createState() => _CategoryTileDeletingState();
}

class _CategoryTileDeletingState extends State<CategoryTileDeleting> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: widget.gradient,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    widget.icon,
                    color: AppColors.onBackground,
                    size: 45,
                  ),
                  Text(
                    widget.title,
                    style: const TextStyle(
                      color: AppColors.onBackground,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: fontApp,
                    ),
                  ),
                ],
              ),
            ),
            widget.isDeletingMode
                ? Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.onBackground.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      widget.selectedCategories.contains(widget.id)
                          ? const Icon(
                              Icons.close_rounded,
                              size: 100,
                              color: Colors.redAccent,
                            )
                          : const SizedBox(),
                      SizedBox(
                        width: double.infinity,
                        height: double.infinity,
                        child: MaterialButton(
                          onPressed: () {
                            if (!widget.selectedCategories
                                .contains(widget.id)) {
                              setState(() {
                                widget.selectedCategories.add(widget.id);
                              });
                            } else {
                              setState(() {
                                widget.selectedCategories.remove(widget.id);
                              });
                            }
                            widget.hasDeleteElements();
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                    ],
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
