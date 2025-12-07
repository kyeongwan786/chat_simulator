import 'package:flutter/material.dart';
import 'package:love_chat_simulator/router.dart'; // ★ 네 라우터 파일

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: router, // ★ _router 말고 이걸로!
    );
  }
}
