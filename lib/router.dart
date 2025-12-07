import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// Pages
import 'pages/start/start_mode_page.dart';
import 'pages/chat/chat_page.dart';
import 'pages/character/character_detail_page.dart';

// Models
import 'models/scenario.dart';
import 'models/character.dart';

final GoRouter router = GoRouter(
  initialLocation: '/start',

  routes: [
    /// 홈(시작 화면)
    GoRoute(path: '/start', builder: (context, state) => const StartModePage()),

    /// 캐릭터 상세 페이지 (선택 시)
    GoRoute(
      path: '/character/:id',
      builder: (context, state) {
        final character = state.extra as Character;
        return CharacterDetailPage(character: character);
      },
    ),

    /// 채팅 페이지
    GoRoute(
      path: '/chat/:scenarioId',
      builder: (context, state) {
        final extras = state.extra as Map<String, dynamic>;

        final scenario = extras['scenario'] as Scenario;
        final character = extras['character'] as Character;

        return ChatPage(scenario: scenario, character: character);
      },
    ),
  ],
);
