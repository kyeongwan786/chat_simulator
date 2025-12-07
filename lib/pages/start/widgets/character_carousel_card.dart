// lib/pages/start/widgets/character_carousel_card.dart

import 'dart:math';
import 'package:flutter/material.dart';
import '../../../models/character.dart';
import 'package:love_chat_simulator/theme/app_colors.dart';

class CharacterCarouselCard extends StatelessWidget {
  final Character character;
  final VoidCallback? onTap;

  const CharacterCarouselCard({super.key, required this.character, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'character_${character.id}',
      child: GestureDetector(
        onTapDown: (_) {},
        onTap: onTap,
        child: AnimatedScale(
          scale: 1.0,
          duration: const Duration(milliseconds: 80),
          child: Container(
            width: 165,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.96),
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.03),
                  blurRadius: 18,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              children: [_buildTopVisual(), _buildBottomInfo(context)],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTopVisual() {
    return Container(
      height: 125,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(18)),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            character.primaryColor.withOpacity(0.95),
            character.primaryColor.withOpacity(0.7),
          ],
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            right: -8,
            bottom: -12,
            child: Transform.rotate(
              angle: -pi / 10,
              child: Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white.withOpacity(0.9),
                    width: 3,
                  ),
                ),
              ),
            ),
          ),
          Center(
            child: CircleAvatar(
              radius: 32,
              backgroundColor: Colors.white.withOpacity(0.96),
              child: Text(
                character.name.characters.first,
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w800,
                  color: character.primaryColor,
                ),
              ),
            ),
          ),
          if (character.isNew || character.isLocked)
            Positioned(top: 10, right: 10, child: _badge()),
        ],
      ),
    );
  }

  Widget _badge() {
    final isNew = character.isNew;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(999),
        color: isNew
            ? Colors.white.withOpacity(0.9)
            : Colors.black.withOpacity(0.6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isNew ? Icons.fiber_new_rounded : Icons.lock_rounded,
            size: 13,
            color: isNew ? AppColors.accentPink : Colors.white,
          ),
          const SizedBox(width: 4),
          Text(
            isNew ? 'NEW' : '잠금',
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              color: isNew ? AppColors.textPrimary : Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomInfo(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            character.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            character.tagline,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontSize: 11,
              height: 1.3,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 6),
          Wrap(
            spacing: 4,
            runSpacing: -2,
            children: character.tags
                .take(3)
                .map(
                  (t) => Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.chipBackground,
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Text(
                      t,
                      style: const TextStyle(
                        fontSize: 9.5,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}
