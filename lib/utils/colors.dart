import 'package:flutter/material.dart';

class TagColors {
  // // Срочность и приоритет
  // static const Color urgent = Color(0xFFF28B82); // Красный пастельный
  // static const Color mediumPriority = Color(0xFFFBBC04); // Оранжевый
  // static const Color highPriority = Color(0xFFE1BE02); // Желтый
  // static const Color lowPriority = Color(0xFF34A853); // Зеленый

  // Категоризация по типу задачи
  static const Color work = Color(0xFFAECBFA); // Светло-синий
  static const Color personal = Color(0xFFE6C9A8); // Бежевый
  static const Color home = Color(0xFFFBBC05); // Оранжевый тёплый

  // Прочие теги
  static const Color health = Color(0xFFEA4335); // Тёмно-красный
  static const Color finance = Color(0xFF0F9D58); // Тёмно-зеленый
  static const Color travel = Color(0xFF4285F4); // Синий
  static const Color studies = Color(0xFFD7AEFB); // Сиреневый
  static const Color creative = Color(0xFF34A853); // Зелёный

  // Нейтральные
  static const Color general = Color(0xFFBDBDBD); // Серый

  static Map<String, Color> get allTagsColors {
    return {
      'Work': work,
      'Personal': personal,
      'Home': home,
      'Health': health,
      'Finance': finance,
      'Travel': travel,
      'Studies': studies,
      'Creative': creative,
      'General': general,
    };
  }
}
