import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SimulatorPage extends StatelessWidget {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("시뮬레이터")),
      body: Column(
        children: [
          Expanded(
            child: Container(
              color: Colors.grey.shade200,
              child: Center(child: Text("대화 내용 (Dummy)")),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "메시지 입력...",
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () => context.go('/result'),
            child: Text("엔딩 보기 (Dummy)"),
          ),
        ],
      ),
    );
  }
}
