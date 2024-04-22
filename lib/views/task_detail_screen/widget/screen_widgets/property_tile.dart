import 'package:flutter/material.dart';
import 'package:kurs_oop/core/constants.dart';
import 'package:kurs_oop/models/task.dart';
import 'package:kurs_oop/utils/app_colors.dart';

class PropertyTile extends StatefulWidget {
  const PropertyTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.visible,
    required this.task,
    required this.onTap,
  });

  final String title;
  final Widget? subtitle;
  final IconData icon;
  final bool visible;
  final Task task;
  final Function() onTap;

  @override
  State<PropertyTile> createState() => _PropertyTileState();
}

class _PropertyTileState extends State<PropertyTile> {
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: widget.visible,
      child: Column(
        children: [
          ListTile(
            leading: Icon(widget.icon),
            title: Text(
              widget.title,
              style: const TextStyle(
                fontFamily: fontApp,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: widget.subtitle,
            onTap: widget.onTap,
          ),
          Container(height: 2, color: AppColors.highlight),
        ],
      ),
    );
  }
}
