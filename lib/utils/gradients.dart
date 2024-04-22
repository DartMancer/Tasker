import 'package:flutter/material.dart';

class CategoryGradients {
  static const List<Color> work = [Color(0xFFFDEB71), Color(0xFFF8D800)];
  static const List<Color> personal = [Color(0xFFABDCFF), Color(0xFF0396FF)];
  static const List<Color> home = [Color(0xFFFEB692), Color(0xFFEA5455)];
  static const List<Color> leisure = [Color(0xFFCE9FFC), Color(0xFF7367F0)];
  static const List<Color> health = [Color(0xFF90F7EC), Color(0xFF32CCBC)];
  static const List<Color> finance = [Color(0xFFFFF6B7), Color(0xFFF6416C)];
  static const List<Color> travel = [Color(0xFF81FBB8), Color(0xFF28C76F)];
  static const List<Color> studies = [Color(0xFFE2B0FF), Color(0xFF9F44D3)];
  static const List<Color> creative = [Color(0xFF69FF97), Color(0xFF00E4FF)];

  static Map<String, List<Color>> get allGradients {
    return {
      'Work': work,
      'Personal': personal,
      'Home': home,
      'Leisure': leisure,
      'Health': health,
      'Finance': finance,
      'Travel': travel,
      'Studies': studies,
      'Creative': creative,
    };
  }
}
