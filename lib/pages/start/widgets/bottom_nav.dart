// lib/pages/start/widgets/bottom_nav.dart

import 'package:flutter/material.dart';
import 'package:love_chat_simulator/theme/app_colors.dart';

class BottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int>? onTap;

  const BottomNav({super.key, required this.currentIndex, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.94),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 16,
            offset: const Offset(0, -8),
          ),
        ],
        border: const Border(
          top: BorderSide(color: Color(0xFFE5E5F0), width: 0.8),
        ),
      ),
      child: Row(
        children: [
          _item(index: 0, icon: Icons.home_rounded, label: '홈'),
          _item(index: 1, icon: Icons.people_alt_rounded, label: '캐릭터'),
          _item(index: 2, icon: Icons.category_rounded, label: '상황'),
          _item(index: 3, icon: Icons.insights_rounded, label: '기록'),
        ],
      ),
    );
  }

  Widget _item({
    required int index,
    required IconData icon,
    required String label,
  }) {
    final selected = index == currentIndex;
    return Expanded(
      child: InkWell(
        onTap: () => onTap?.call(index),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 140),
          curve: Curves.easeOut,
          padding: const EdgeInsets.only(top: 6, bottom: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(999),
                  color: selected
                      ? AppColors.accentPink.withOpacity(0.12)
                      : Colors.transparent,
                ),
                child: Icon(
                  icon,
                  size: 22,
                  color: selected
                      ? AppColors.accentPink
                      : const Color(0xFFB0B0C3),
                ),
              ),
              const SizedBox(height: 2),
              Text(
                label,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                  color: selected
                      ? AppColors.textPrimary
                      : const Color(0xFFB0B0C3),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
