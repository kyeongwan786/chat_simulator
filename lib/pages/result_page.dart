import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ResultPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("엔딩 결과")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("GOOD 엔딩 (Dummy)", style: TextStyle(fontSize: 24)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => context.go('/scenario_list'),
              child: Text("다른 시나리오 선택"),
            ),
            ElevatedButton(
              onPressed: () => context.go('/home'),
              child: Text("홈으로"),
            ),
          ],
        ),
      ),
    );
  }
}
