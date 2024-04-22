import 'package:flutter/material.dart';
import 'package:kurs_oop/core/constants.dart';

class CustomTaskTile extends StatefulWidget {
  const CustomTaskTile({
    super.key,
    required this.title,
    this.description,
    required this.isCompleted,
    required this.onStatusChanged,
    required this.onTap,
  });

  final String title;
  final String? description;
  final bool isCompleted;
  final Function(bool?) onStatusChanged;
  final Function onTap;

  @override
  State<CustomTaskTile> createState() => _CustomTaskTileState();
}

class _CustomTaskTileState extends State<CustomTaskTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => widget.onTap(),
      child: Card(
        margin: const EdgeInsets.all(8.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.title,
                          style: const TextStyle(
                            fontFamily: fontApp,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Visibility(
                          visible: widget.description != null,
                          child: Column(
                            children: [
                              const SizedBox(height: 4),
                              Text(
                                widget.description ?? '',
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontFamily: fontApp,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Checkbox(
                    value: widget.isCompleted,
                    onChanged: widget.onStatusChanged,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
