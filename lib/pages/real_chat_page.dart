import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RealChatPage extends StatelessWidget {
  final TextEditingController input = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("실전 카톡 분석")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: input,
              maxLines: 6,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "카톡 대화 붙여넣기...",
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {},
              child: Text("분석하기 (Dummy)"),
            ),
          ],
        ),
      ),
    );
  }
}
