import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ScenarioListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("시나리오 리스트")),
      body: ListView(
        children: [
          ListTile(
            title: Text("첫 카톡 (Dummy)"),
            subtitle: Text("가볍고 밝게 시작하는 첫 대화"),
            onTap: () => context.go('/character_select'),
          ),
          ListTile(
            title: Text("썸 단계 (Dummy)"),
            subtitle: Text("호감 유지와 밀당"),
            onTap: () => context.go('/character_select'),
          ),
        ],
      ),
    );
  }
}
