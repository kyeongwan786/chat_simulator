import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F5F2), // 감성 아이보리 배경
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 14),

              // 브랜드 로고
              const Text(
                "MellowTalk",
                style: TextStyle(
                  fontFamily: "Pretendard",
                  fontSize: 35,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF3A3A3A),
                ),
              ),

              const SizedBox(height: 24),

              // 임팩트 문구
              const Text(
                "말 한마디가 분위기를 결정한다.",
                style: TextStyle(
                  fontFamily: "Pretendard",
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF5A5A5A),
                ),
              ),

              const SizedBox(height: 16),

              // 타이틀
              const Text(
                "마음은 결국\n말에서 드러난다.",
                style: TextStyle(
                  fontFamily: "Pretendard",
                  fontSize: 28,
                  height: 1.25,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF1F1F1F),
                ),
              ),

              const SizedBox(height: 12),

              // 설명
              const Text(
                "감정 기반 대화 플레이로 마음의 흐름을\n그대로 경험하는 연애 시뮬레이터",
                style: TextStyle(
                  fontFamily: "Pretendard",
                  fontSize: 14,
                  height: 1.5,
                  color: Color(0xFF6F6F6F),
                ),
              ),

              const SizedBox(height: 34),

              // 감정씬
              _emotionScene(),

              const SizedBox(height: 22),

              // ⭐ 수정된 프로필 설정 버튼
              GestureDetector(
                onTap: () {
                  GoRouter.of(context).push('/profile_setting_page');
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 20,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: const Color(0xFFE8E1DB)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    children: const [
                      CircleAvatar(
                        radius: 18,
                        backgroundColor: Color(0xFFF1EDED),
                        child: Icon(
                          Icons.person,
                          size: 22,
                          color: Color(0xFF7A7A7A),
                        ),
                      ),
                      SizedBox(width: 12),
                      Text(
                        "프로필 설정",
                        style: TextStyle(
                          fontFamily: "Pretendard",
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF3E3E3E),
                        ),
                      ),
                      Spacer(),
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 16,
                        color: Color(0xFFB4B4B4),
                      ),
                    ],
                  ),
                ),
              ),

              const Spacer(),

              // 경고 문구
              const Center(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 6),
                  child: Text(
                    "시작하기 전에 프로필을 먼저 설정해주세요.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: "Pretendard",
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFFB84A4A),
                    ),
                  ),
                ),
              ),

              // 시작하기 버튼
              Padding(
                padding: const EdgeInsets.only(bottom: 26),
                child: GestureDetector(
                  onTap: () {
                    GoRouter.of(context).push('/scenario_list');
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFF5A7A),
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFFF9BB0).withOpacity(0.4),
                          blurRadius: 12,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: const Center(
                      child: Text(
                        "시작하기",
                        style: TextStyle(
                          fontFamily: "Pretendard",
                          fontWeight: FontWeight.w700,
                          fontSize: 17,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 감정씬
  Widget _emotionScene() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 26, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: const Color(0xFFE5DED7)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 25,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _emotionBubble("그동안 고민을 좀 했어. 어떻게 말해야 할지 계속 정리했거든.", [
            Color(0xFFECE8FF),
            Color(0xFFD9D2FF),
          ], Alignment.centerRight),
          _emotionBubble("부담 갖지 말고 말해도 돼. 나 그냥 네 이야기 듣고 싶은 거야.", [
            Color(0xFFFFEEF2),
            Color(0xFFFFD1DD),
          ], Alignment.centerLeft),
          _emotionBubble("돌려 말하기 싫어 너 좋아해.", [
            Color(0xFFF6F2FF),
            Color(0xFFECE4FF),
          ], Alignment.centerRight),
        ],
      ),
    );
  }

  Widget _emotionBubble(String text, List<Color> colors, Alignment alignment) {
    return Align(
      alignment: alignment,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 12),
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: colors,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: colors.last.withOpacity(0.35),
              blurRadius: 18,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontFamily: "Pretendard",
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: Color(0xFF3A3A3A),
            height: 1.45,
          ),
        ),
      ),
    );
  }
}
