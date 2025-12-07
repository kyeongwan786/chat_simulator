// lib/pages/start/widgets/scenario_list_item.dart

import 'package:flutter/material.dart';
import '../../../models/scenario.dart';
import '../../../models/difficulty.dart';
import '../../../models/enums.dart';
import 'package:love_chat_simulator/theme/app_colors.dart';

class ScenarioListItem extends StatelessWidget {
  final Scenario scenario;
  final VoidCallback? onTap;

  const ScenarioListItem({super.key, required this.scenario, this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Ink(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.96),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.02),
              blurRadius: 12,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildLeadingIcon(),
              const SizedBox(width: 10),
              Flexible(
                fit: FlexFit.loose,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      scenario.title,
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
                      scenario.subtitle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontSize: 11.5,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        _difficultyDots(scenario.difficulty),
                        const SizedBox(width: 8),
                        Text(
                          '${scenario.durationMinutes}분',
                          style: const TextStyle(fontSize: 10.5),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  _buildPriceBadge(),
                  const SizedBox(height: 8),
                  const Icon(
                    Icons.chevron_right_rounded,
                    size: 22,
                    color: AppColors.textSecondary,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLeadingIcon() {
    IconData icon;
    Color color;

    switch (scenario.typeHint) {
      case ScenarioTypeHint.slowReply:
        icon = Icons.schedule_rounded;
        color = AppColors.accentLavender;
        break;
      case ScenarioTypeHint.conflict:
        icon = Icons.heart_broken_rounded;
        color = Colors.redAccent;
        break;
      case ScenarioTypeHint.firstMeet:
        icon = Icons.flare_rounded;
        color = Colors.orangeAccent;
        break;
      default:
        icon = Icons.chat_bubble_rounded;
        color = AppColors.accentPink;
        break;
    }

    return Container(
      width: 42,
      height: 42,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: color.withOpacity(0.12),
      ),
      child: Icon(icon, size: 22, color: color.withOpacity(0.9)),
    );
  }

  Widget _difficultyDots(Difficulty difficulty) {
    final count = difficulty.level;
    return Row(
      children: List.generate(
        3,
        (index) => Padding(
          padding: const EdgeInsets.only(right: 2),
          child: Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: index < count
                  ? difficulty.color
                  : AppColors.chipBackground,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPriceBadge() {
    final isFree = scenario.isFree;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(999),
        color: isFree
            ? AppColors.chipBackground
            : AppColors.accentLavender.withOpacity(0.08),
        border: Border.all(
          color: isFree
              ? Colors.transparent
              : AppColors.accentLavender.withOpacity(0.55),
        ),
      ),
      child: Text(
        isFree ? '무료' : '코인 ${scenario.coinCost}',
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w600,
          color: isFree
              ? AppColors.textSecondary
              : AppColors.accentLavender.withOpacity(0.95),
        ),
      ),
    );
  }
}
