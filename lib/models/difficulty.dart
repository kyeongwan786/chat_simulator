// lib/models/difficulty.dart

import 'package:flutter/material.dart';

class Difficulty {
  final int level; // 1~3
  final String label;
  final Color color;

  const Difficulty({
    required this.level,
    required this.label,
    required this.color,
  });

  static const easy = Difficulty(
    level: 1,
    label: 'Easy',
    color: Color(0xFF92D7A3),
  );
  static const normal = Difficulty(
    level: 2,
    label: 'Normal',
    color: Color(0xFFF2B35D),
  );
  static const hard = Difficulty(
    level: 3,
    label: 'Hard',
    color: Color(0xFFE57373),
  );
}
