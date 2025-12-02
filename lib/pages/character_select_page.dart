import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CharacterSelectPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("캐릭터 선택")),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildBox(context, "다정한 스타일"),
          _buildBox(context, "쿨한 스타일"),
        ],
      ),
    );
  }

  Widget _buildBox(BuildContext context, String text) {
    return GestureDetector(
      onTap: () => context.go('/simulator'),
      child: Container(
        width: 120,
        height: 150,
        color: Colors.grey.shade300,
        child: Center(child: Text(text)),
      ),
    );
  }
}
