import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("홈")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => context.go('/scenario_list'),
              child: Text("연애 카톡 시뮬레이터"),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => context.go('/real_chat'),
              child: Text("실전 카톡 분석하기"),
            ),
          ],
        ),
      ),
    );
  }
}
