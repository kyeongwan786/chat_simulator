// lib/pages/start/start_mode_page.dart

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// 분리된 파일들 import
import 'package:love_chat_simulator/theme/app_colors.dart';
import '../../models/character.dart';
import '../../models/scenario.dart';
import '../../data/demo_data.dart';
import '../../models/enums.dart';
import '../../models/difficulty.dart';

// 위젯들
import 'widgets/gender_toggle.dart';
import 'widgets/character_carousel_card.dart';
import 'widgets/scenario_category_chip.dart';
import 'widgets/scenario_list_item.dart';
import 'widgets/bottom_nav.dart';
import 'widgets/top_intro.dart';
import 'widgets/scenario_preview_sheet.dart';

class StartModePage extends StatefulWidget {
  const StartModePage({super.key});

  @override
  State<StartModePage> createState() => _StartModePageState();
}

class _StartModePageState extends State<StartModePage> {
  Gender _selectedGender = Gender.male;
  String _selectedCategory = '전체';

  @override
  Widget build(BuildContext context) {
    final characters = _selectedGender == Gender.male
        ? DemoData.maleCharacters
        : DemoData.femaleCharacters;

    final scenarios = _filteredScenarios;

    return Scaffold(
      backgroundColor: AppColors.backgroundBottom,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.backgroundTop,
              AppColors.backgroundMid,
              AppColors.backgroundBottom,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const TopIntro(),
                        const SizedBox(height: 16),
                        GenderToggle(
                          selectedGender: _selectedGender,
                          onChanged: (gender) {
                            if (_selectedGender == gender) return;
                            setState(() {
                              _selectedGender = gender;
                            });
                          },
                        ),
                        const SizedBox(height: 24),
                        _buildCharacterSection(context, characters),
                        const SizedBox(height: 32),
                        _buildScenarioSection(context, scenarios),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                ),
              ),
              BottomNav(
                currentIndex: 0,
                onTap: (index) {
                  switch (index) {
                    case 0:
                      context.go('/start');
                      break;
                    case 1:
                      context.go('/characters');
                      break;
                    case 2:
                      context.go('/scenarios');
                      break;
                    case 3:
                      context.go('/insights');
                      break;
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCharacterSection(
    BuildContext context,
    List<Character> characters,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '대화할 상대를 골라볼까?',
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          '성격이 다른 캐릭터와 같은 상황도 전혀 다르게 흘러가요.',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            fontSize: 12,
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: 14),
        SizedBox(
          height: 240,
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 180),
            switchInCurve: Curves.easeOut,
            switchOutCurve: Curves.easeIn,
            child: ListView.separated(
              key: ValueKey(_selectedGender),
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.only(right: 4),
              itemCount: characters.length,
              separatorBuilder: (_, __) => const SizedBox(width: 14),
              itemBuilder: (context, index) {
                final character = characters[index];
                return CharacterCarouselCard(
                  character: character,
                  onTap: () {
                    context.push(
                      '/character/${character.id}',
                      extra: character,
                    );
                  },
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildScenarioSection(BuildContext context, List<Scenario> scenarios) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '상황별로 연애 대화 연습하기',
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 38,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: DemoData.categories.length,
            separatorBuilder: (_, __) => const SizedBox(width: 8),
            itemBuilder: (context, index) {
              final label = DemoData.categories[index];
              return ScenarioCategoryChip(
                label: label,
                isSelected: _selectedCategory == label,
                onTap: () {
                  setState(() {
                    _selectedCategory = label;
                  });
                },
              );
            },
          ),
        ),
        const SizedBox(height: 16),
        ...scenarios.map(
          (scenario) => Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: ScenarioListItem(
              scenario: scenario,
              onTap: () =>
                  showScenarioPreview(context, scenario, _selectedGender),
            ),
          ),
        ),
      ],
    );
  }

  List<Scenario> get _filteredScenarios {
    if (_selectedCategory == '전체') {
      return DemoData.scenarios;
    }
    return DemoData.scenarios
        .where((s) => s.categories.contains(_selectedCategory))
        .toList();
  }
}
