// lib/models/scenario.dart

import 'character.dart';
import 'difficulty.dart';
import 'enums.dart';

class Scenario {
  final String id;
  final String title;
  final String subtitle;
  final ScenarioTypeHint typeHint;
  final Difficulty difficulty;
  final int durationMinutes;
  final bool isFree;
  final int coinCost;
  final List<String> categories;
  final List<Character> recommendedCharacters;

  const Scenario({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.typeHint,
    required this.difficulty,
    required this.durationMinutes,
    required this.isFree,
    required this.coinCost,
    required this.categories,
    required this.recommendedCharacters,
  });
}
