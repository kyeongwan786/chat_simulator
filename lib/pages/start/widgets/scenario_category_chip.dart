// lib/pages/start/widgets/scenario_category_chip.dart

import 'package:flutter/material.dart';
import 'package:love_chat_simulator/theme/app_colors.dart';

class ScenarioCategoryChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback? onTap;

  const ScenarioCategoryChip({
    super.key,
    required this.label,
    required this.isSelected,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final selected = isSelected;
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 140),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(999),
          color: selected ? AppColors.accentPink : Colors.white,
          border: Border.all(
            color: selected
                ? Colors.transparent
                : AppColors.accentLavender.withOpacity(0.7),
          ),
          boxShadow: selected
              ? [
                  BoxShadow(
                    color: AppColors.accentPink.withOpacity(0.3),
                    blurRadius: 14,
                    offset: const Offset(0, 8),
                  ),
                ]
              : [],
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: selected ? Colors.white : AppColors.accentLavender,
          ),
        ),
      ),
    );
  }
}
