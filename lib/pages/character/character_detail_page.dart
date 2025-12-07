// lib/pages/character/character_detail_page.dart
//
// MellowTalk - Character Detail (Cute Pastel / Helbot-like)
//
// - 문구: "대화하기"
// - 버튼 뒤 흰 배경(CTA Wrapper) 완전 제거
// - StartModePage 톤과 완벽히 일치
// - 전체 UI 상업용 수준으로 재작성

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:love_chat_simulator/theme/app_colors.dart';
import '../../models/character.dart';
import '../../models/scenario.dart';
import '../../data/demo_data.dart';

class CharacterDetailPage extends StatefulWidget {
  final Character character;

  const CharacterDetailPage({super.key, required this.character});

  @override
  State<CharacterDetailPage> createState() => _CharacterDetailPageState();
}

class _CharacterDetailPageState extends State<CharacterDetailPage> {
  bool _isFavorite = false;
  bool _showFullIntro = false;

  late final List<Scenario> _recommended;

  Character get c => widget.character;

  @override
  void initState() {
    super.initState();
    _recommended = DemoData.scenarios
        .where((s) => s.recommendedCharacters.contains(widget.character))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
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
          child: Stack(
            children: [
              Column(
                children: [
                  _buildTopBar(context),
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.fromLTRB(20, 6, 20, 120),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildHeroCard(),
                          const SizedBox(height: 20),
                          _buildIntroSection(),
                          const SizedBox(height: 24),
                          _buildPersonalitySection(),
                          const SizedBox(height: 28),
                          _buildScenarioSection(context),
                          const SizedBox(height: 8),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              _buildBottomCTA(context),
            ],
          ),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // TOP BAR
  // ---------------------------------------------------------------------------

  Widget _buildTopBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: Row(
        children: [
          _roundIconButton(
            icon: Icons.arrow_back_ios_new_rounded,
            onTap: () => Navigator.pop(context),
          ),
          const Spacer(),
          _roundIconButton(
            icon: _isFavorite ? Icons.favorite : Icons.favorite_border,
            iconColor: _isFavorite
                ? AppColors.accentPink
                : AppColors.textPrimary,
            onTap: () {
              setState(() => _isFavorite = !_isFavorite);
            },
          ),
        ],
      ),
    );
  }

  Widget _roundIconButton({
    required IconData icon,
    required VoidCallback onTap,
    Color? iconColor,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(9),
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Icon(icon, size: 18, color: iconColor ?? AppColors.textPrimary),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // HERO CARD
  // ---------------------------------------------------------------------------

  Widget _buildHeroCard() {
    return Hero(
      tag: 'character_${c.id}',
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(18, 18, 18, 16),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.97),
          borderRadius: BorderRadius.circular(26),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Row(
          children: [
            // 왼쪽 캐릭터 비주얼
            Container(
              width: 84,
              height: 84,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(26),
                gradient: LinearGradient(
                  colors: [
                    c.primaryColor.withOpacity(0.95),
                    c.primaryColor.withOpacity(0.7),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    right: -8,
                    bottom: -10,
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white.withOpacity(0.7),
                          width: 3,
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.white,
                      child: Text(
                        c.name.characters.first,
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w800,
                          color: c.primaryColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),

            // 오른쪽 텍스트
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    c.name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 6),
                  _buildTagRow(),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      _metaChip(icon: Icons.mood_rounded, label: _toneLabel()),
                      const SizedBox(width: 6),
                      _metaChip(
                        icon: Icons.schedule_rounded,
                        label: _speedLabel(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTagRow() {
    if (c.tags.isEmpty) {
      return const Text(
        "태그 없음",
        style: TextStyle(fontSize: 11, color: AppColors.textSecondary),
      );
    }
    return Wrap(
      spacing: 6,
      runSpacing: -4,
      children: c.tags.take(3).map((t) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4.5),
          decoration: BoxDecoration(
            color: AppColors.chipBackground,
            borderRadius: BorderRadius.circular(999),
          ),
          child: Text(
            t,
            style: const TextStyle(
              fontSize: 10.5,
              fontWeight: FontWeight.w500,
              color: AppColors.textSecondary,
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _metaChip({required IconData icon, required String label}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4.5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(999),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
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
              fontWeight: FontWeight.w600,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // INTRO SECTION
  // ---------------------------------------------------------------------------

  Widget _buildIntroSection() {
    const maxLinesFolded = 2;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionHeader(
          title: "이 캐릭터, 이런 느낌이에요",
          subtitle: "대화 시작 전에 한 눈에 감 잡을 수 있게 정리했어요.",
        ),
        const SizedBox(height: 12),

        AnimatedSize(
          duration: const Duration(milliseconds: 200),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.03),
                  blurRadius: 14,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  c.tagline,
                  maxLines: _showFullIntro ? null : maxLinesFolded,
                  overflow: _showFullIntro
                      ? TextOverflow.visible
                      : TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 13.5,
                    height: 1.6,
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 6),

                GestureDetector(
                  onTap: () => setState(() => _showFullIntro = !_showFullIntro),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        _showFullIntro ? "접기" : "더 보기",
                        style: const TextStyle(
                          fontSize: 11.5,
                          fontWeight: FontWeight.w600,
                          color: AppColors.accentLavender,
                        ),
                      ),
                      Icon(
                        _showFullIntro
                            ? Icons.keyboard_arrow_up_rounded
                            : Icons.keyboard_arrow_down_rounded,
                        color: AppColors.accentLavender,
                        size: 16,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // PERSONALITY SECTION
  // ---------------------------------------------------------------------------

  Widget _buildPersonalitySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionHeader(
          title: "대화할 때 이런 점을 기억해보면 좋아요",
          subtitle: "한 번쯤 머릿속에 넣어두고 톡을 시작해보세요.",
        ),
        const SizedBox(height: 14),

        Row(
          children: [
            Expanded(
              child: _miniCard(
                emoji: "💬",
                title: "대화 톤",
                desc: _toneDescription(),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _miniCard(
                emoji: "⏱️",
                title: "답장 템포",
                desc: _tempoDescription(),
              ),
            ),
          ],
        ),

        const SizedBox(height: 10),

        Row(
          children: [
            Expanded(
              child: _miniCard(
                emoji: "🤍",
                title: "호감 표현",
                desc: "직접적인 고백보단 작은 배려로 마음을 드러내는 타입일 수 있어요.",
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _miniCard(
                emoji: "🧠",
                title: "관계 스타일",
                desc: _relationDescription(),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _miniCard({
    required String emoji,
    required String title,
    required String desc,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(emoji, style: const TextStyle(fontSize: 18)),
          const SizedBox(height: 6),
          Text(
            title,
            style: const TextStyle(
              fontSize: 12.5,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            desc,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 11,
              height: 1.4,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // SCENARIOS
  // ---------------------------------------------------------------------------

  Widget _buildScenarioSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionHeader(title: "추천 시나리오", subtitle: "이 캐릭터와 연습하면 좋은 상황들이에요."),
        const SizedBox(height: 14),

        if (_recommended.isEmpty)
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.03),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: const Text(
              "곧 추가될 예정이에요.",
              style: TextStyle(
                fontSize: 12.5,
                height: 1.45,
                color: AppColors.textSecondary,
              ),
            ),
          )
        else
          Column(
            children: _recommended
                .map(
                  (s) => Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: _ScenarioCard(scenario: s, character: c),
                  ),
                )
                .toList(),
          ),
      ],
    );
  }

  Widget _sectionHeader({required String title, String? subtitle}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w800,
            color: AppColors.textPrimary,
          ),
        ),
        if (subtitle != null)
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              subtitle!,
              style: const TextStyle(
                fontSize: 11.5,
                height: 1.45,
                color: AppColors.textSecondary,
              ),
            ),
          ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // NO-WRAPPER CTA (버튼 단독)
  // ---------------------------------------------------------------------------

  Widget _buildBottomCTA(BuildContext context) {
    final Scenario entry = _recommended.isNotEmpty
        ? _recommended.first
        : DemoData.scenarios.first;

    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: Padding(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          bottom: 10 + MediaQuery.of(context).padding.bottom,
        ),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.accentPink,
              elevation: 3,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
            ),
            onPressed: () {
              context.push(
                '/chat/${entry.id}',
                extra: {'scenario': entry, 'character': c},
              );
            },
            child: const Text(
              "대화하기",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Text Logic
  // ---------------------------------------------------------------------------

  String _toneLabel() {
    final lower = c.tags.join(",").toLowerCase();
    if (lower.contains("조용") || lower.contains("차분")) return "차분한 톤";
    if (lower.contains("밝") || lower.contains("장난")) return "밝은 톤";
    return "담백한 톤";
  }

  String _speedLabel() {
    final lower = c.tags.join(",").toLowerCase();
    if (lower.contains("빠르")) return "빠른 템포";
    if (lower.contains("늦") || lower.contains("여유")) return "여유 템포";
    return "보통 템포";
  }

  String _toneDescription() {
    final s = _toneLabel();
    if (s == "차분한 톤") {
      return "감정 기복 없이 차분하게 말을 이어가는 편이에요.";
    }
    if (s == "밝은 톤") {
      return "자연스럽게 농담도 섞어 분위기를 띄워줄 수 있어요.";
    }
    return "필요한 말만 담백하게 건네는 타입일 수 있어요.";
  }

  String _tempoDescription() {
    final s = _speedLabel();
    if (s == "빠른 템포") {
      return "답장이 빠른 편이라 템포감 있는 대화를 선호할 가능성이 높아요.";
    }
    if (s == "여유 템포") {
      return "답장이 조금 느려도 한 번에 정리해서 보내주는 스타일일 수 있어요.";
    }
    return "특별히 빠르지도 느리지도 않은 자연스러운 템포예요.";
  }

  String _relationDescription() {
    final lower = c.tags.join(",").toLowerCase();
    if (lower.contains("직진") || lower.contains("솔직")) {
      return "마음이 생기면 꽤 솔직하게 표현하는 편이에요.";
    }
    if (lower.contains("배려") || lower.contains("섬세")) {
      return "감정 표현도 천천히, 상대 기분을 세심하게 살피는 타입이죠.";
    }
    return "겉으론 조용해보여도 은근히 정이 깊은 스타일일 수 있어요.";
  }
}

// ----------------------------------------------------------------------------
// Scenario Card
// ----------------------------------------------------------------------------

class _ScenarioCard extends StatelessWidget {
  final Scenario scenario;
  final Character character;

  const _ScenarioCard({required this.scenario, required this.character});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push(
          '/chat/${scenario.id}',
          extra: {'scenario': scenario, 'character': character},
        );
      },
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: AppColors.chipBackground,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.chat_bubble_outline_rounded,
                size: 18,
                color: AppColors.accentLavender,
              ),
            ),
            const SizedBox(width: 12),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    scenario.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 13.5,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    scenario.subtitle,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 11.5,
                      height: 1.4,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 6),
            const Icon(
              Icons.chevron_right_rounded,
              size: 20,
              color: AppColors.textSecondary,
            ),
          ],
        ),
      ),
    );
  }
}
