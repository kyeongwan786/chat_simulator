// lib/pages/start/widgets/scenario_preview_sheet.dart

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../models/character.dart';
import '../../../models/scenario.dart';
import '../../../models/enums.dart';
import 'package:love_chat_simulator/theme/app_colors.dart';
import '../../../data/demo_data.dart';

/// 외부에서 호출하는 함수
void showScenarioPreview(
  BuildContext context,
  Scenario scenario,
  Gender selectedGender,
) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    barrierColor: Colors.black.withOpacity(0.28),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (context) {
      final characters = selectedGender == Gender.male
          ? DemoData.maleCharacters
          : DemoData.femaleCharacters;

      Character? selectedCharacter = characters.first;

      return StatefulBuilder(
        builder: (context, setModalState) {
          return DraggableScrollableSheet(
            expand: false,
            initialChildSize: 0.45,
            minChildSize: 0.45,
            maxChildSize: 0.9,
            builder: (context, scrollController) {
              return Container(
                padding: EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: 14,
                  bottom: 20 + MediaQuery.of(context).padding.bottom,
                ),
                child: ListView(
                  controller: scrollController,
                  children: [
                    // 핸들 바
                    Center(
                      child: Container(
                        width: 42,
                        height: 4,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(999),
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    Text(
                      scenario.title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: AppColors.textPrimary,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      scenario.subtitle,
                      style: const TextStyle(
                        fontSize: 13,
                        height: 1.4,
                        color: AppColors.textSecondary,
                      ),
                    ),

                    const SizedBox(height: 20),

                    Row(
                      children: [
                        _metaPill(
                          icon: Icons.timelapse_rounded,
                          label: '${scenario.durationMinutes}분',
                        ),
                        const SizedBox(width: 8),
                        _metaPill(
                          icon: Icons.auto_graph_rounded,
                          label: scenario.difficulty.label,
                        ),
                        const SizedBox(width: 8),
                        _metaPill(
                          icon: Icons.stars_rounded,
                          label: scenario.isFree
                              ? '무료'
                              : '코인 ${scenario.coinCost}',
                        ),
                      ],
                    ),

                    const SizedBox(height: 26),

                    const Text(
                      '어떤 캐릭터와 연습해볼까요?',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),

                    const SizedBox(height: 14),

                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: characters.map((c) {
                          bool isSelected = c.id == selectedCharacter?.id;
                          return GestureDetector(
                            onTap: () {
                              setModalState(() {
                                selectedCharacter = c;
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: _characterChip(c, isSelected),
                            ),
                          );
                        }).toList(),
                      ),
                    ),

                    const SizedBox(height: 36),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                          backgroundColor: AppColors.accentPink,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                          context.push(
                            '/chat/${scenario.id}',
                            extra: {
                              'scenario': scenario,
                              'character': selectedCharacter,
                            },
                          );
                        },
                        child: const Text(
                          '시작하기',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 14),

                    Center(
                      child: Text(
                        '선택하는 말 한마디에 따라 감정선이 달라져요.',
                        style: TextStyle(
                          fontSize: 11,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      );
    },
  );
}

Widget _metaPill({required IconData icon, required String label}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    decoration: BoxDecoration(
      color: AppColors.chipBackground,
      borderRadius: BorderRadius.circular(999),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: AppColors.accentLavender),
        const SizedBox(width: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w500,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    ),
  );
}

Widget _characterChip(Character character, bool isSelected) {
  return AnimatedContainer(
    duration: const Duration(milliseconds: 140),
    curve: Curves.easeOut,
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
    decoration: BoxDecoration(
      color: isSelected
          ? character.primaryColor.withOpacity(0.14)
          : Colors.white,
      borderRadius: BorderRadius.circular(999),
      border: Border.all(
        color: isSelected
            ? character.primaryColor.withOpacity(0.9)
            : Colors.grey.shade300,
        width: 1.1,
      ),
      boxShadow: isSelected
          ? [
              BoxShadow(
                color: character.primaryColor.withOpacity(0.28),
                blurRadius: 16,
                offset: const Offset(0, 8),
              ),
            ]
          : [],
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircleAvatar(
          radius: 13,
          backgroundColor: character.primaryColor.withOpacity(0.75),
          child: Text(
            character.name.characters.first,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(width: 7),
        Text(
          character.name,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
      ],
    ),
  );
}
