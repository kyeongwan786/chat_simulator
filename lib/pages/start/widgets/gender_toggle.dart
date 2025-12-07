// lib/pages/start/widgets/gender_toggle.dart

import 'package:flutter/material.dart';
import 'package:love_chat_simulator/theme/app_colors.dart';
import '../../../models/enums.dart';

class GenderToggle extends StatelessWidget {
  final Gender selectedGender;
  final ValueChanged<Gender> onChanged;

  const GenderToggle({
    super.key,
    required this.selectedGender,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.82),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: Colors.white.withOpacity(0.9), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 18,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Stack(
        children: [
          AnimatedAlign(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOutCubic,
            alignment: selectedGender == Gender.male
                ? Alignment.centerLeft
                : Alignment.centerRight,
            child: FractionallySizedBox(
              widthFactor: 0.5,
              heightFactor: 0.9,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 3),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(999),
                  gradient: const LinearGradient(
                    colors: [AppColors.accentPink, AppColors.accentPinkSoft],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.accentPink.withOpacity(0.35),
                      blurRadius: 16,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: _segment(
                  context: context,
                  label: '남자 캐릭터',
                  isSelected: selectedGender == Gender.male,
                  onTap: () => onChanged(Gender.male),
                ),
              ),
              Expanded(
                child: _segment(
                  context: context,
                  label: '여자 캐릭터',
                  isSelected: selectedGender == Gender.female,
                  onTap: () => onChanged(Gender.female),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _segment({
    required BuildContext context,
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: AnimatedDefaultTextStyle(
        duration: const Duration(milliseconds: 140),
        style: TextStyle(
          fontSize: 13,
          fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
          color: isSelected ? Colors.white : const Color(0xFF777777),
        ),
        child: Center(child: Text(label)),
      ),
    );
  }
}
