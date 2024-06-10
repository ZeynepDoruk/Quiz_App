import 'package:flutter/material.dart';

final Map<String, Color> kategoriRenkleri = {
  'matematik': Colors.deepPurple,
  'tarih': const Color.fromARGB(255, 129, 77, 25),
  'spor': Colors.blueAccent,
  'edebiyat': Colors.orange,
  'müzik' : Colors.pink,
  'coğrafya' : Colors.greenAccent,
};

Color _getCategoryColor(String categoryId) {
  return kategoriRenkleri[categoryId] ?? Colors.grey;
}