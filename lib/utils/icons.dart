import 'package:flutter/material.dart';

class CategoryIcons {
  static const IconData work = Icons.work;
  static const IconData personal = Icons.person;
  static const IconData home = Icons.home;
  static const IconData leisure = Icons.beach_access;
  static const IconData health = Icons.local_hospital;
  static const IconData finance = Icons.monetization_on;
  static const IconData travel = Icons.flight;
  static const IconData studies = Icons.school;
  static const IconData creative = Icons.brush;

  static Map<String, IconData> get allIcons {
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
