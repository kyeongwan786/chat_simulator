// lib/models/character.dart

import 'package:flutter/material.dart';
import 'enums.dart';

class Character {
  final String id;
  final String name;
  final String tagline;
  final List<String> tags;
  final Gender gender;
  final Color primaryColor;
  final bool isNew;
  final bool isLocked;

  const Character({
    required this.id,
    required this.name,
    required this.tagline,
    required this.tags,
    required this.gender,
    required this.primaryColor,
    this.isNew = false,
    this.isLocked = false,
  });
}
