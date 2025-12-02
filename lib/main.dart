import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// 화면 import
import 'pages/welcome_page.dart';
import 'pages/login_page.dart';
import 'pages/home_page.dart';
import 'pages/scenario_list_page.dart';
import 'pages/character_select_page.dart';
import 'pages/simulator_page.dart';
import 'pages/result_page.dart';
import 'pages/real_chat_page.dart';
import 'pages/profile_setting_page.dart'; // ⭐ 추가됨

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final _router = GoRouter(
    initialLocation: '/welcome',
    routes: [
      GoRoute(path: '/welcome', builder: (context, state) => WelcomePage()),
      GoRoute(path: '/login', builder: (context, state) => LoginPage()),
      GoRoute(path: '/home', builder: (context, state) => HomePage()),

      GoRoute(
        path: '/scenario_list',
        builder: (context, state) => ScenarioListPage(),
      ),

      GoRoute(
        path: '/character_select',
        builder: (context, state) => CharacterSelectPage(),
      ),

      GoRoute(path: '/simulator', builder: (context, state) => SimulatorPage()),
      GoRoute(path: '/result', builder: (context, state) => ResultPage()),
      GoRoute(path: '/real_chat', builder: (context, state) => RealChatPage()),

      // ⭐ 추가된 새 라우트 — 기존 문법 1:1 유지
      GoRoute(
        path: '/profile_setting_page',
        builder: (context, state) => ProfileSettingPage(),
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
    );
  }
}
