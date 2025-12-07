// lib/pages/start/widgets/top_intro.dart

import 'package:flutter/material.dart';
import 'package:love_chat_simulator/theme/app_colors.dart';

class TopIntro extends StatelessWidget {
  const TopIntro({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'MellowTalk',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontSize: 32,
                  height: 1.3,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textPrimary,
                  // fontFamily: 'Pretendard',
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '부드러운 감정선에 몰입해서,\n편안하게 연애 대화를 연습해봐요.',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontSize: 12,
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.9),
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.03),
                blurRadius: 14,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.favorite, size: 16, color: AppColors.accentPink),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Guest',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '오늘의 한 장면',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
