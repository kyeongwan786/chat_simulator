import 'package:flutter/material.dart';
import 'package:love_chat_simulator/theme/app_colors.dart';
import '../../models/character.dart';
import '../../models/scenario.dart';

class ChatPage extends StatefulWidget {
  final Scenario scenario;
  final Character character;

  const ChatPage({super.key, required this.scenario, required this.character});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final List<Map<String, dynamic>> messages = [];
  final TextEditingController _controller = TextEditingController();

  void _sendMessage() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    setState(() {
      messages.add({'text': text, 'isUser': true});
    });

    _controller.clear();

    // AI 응답 딜레이 후 추가 (임시)
    Future.delayed(const Duration(milliseconds: 600), () {
      setState(() {
        messages.add({
          'text': '${widget.character.name}의 응답입니다.',
          'isUser': false,
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final character = widget.character;

    return Scaffold(
      backgroundColor: AppColors.backgroundBottom,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: character.primaryColor.withOpacity(0.8),
              child: Text(
                character.name.characters.first,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Text(
              character.name,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final msg = messages[index];
                final isUser = msg['isUser'];

                return Align(
                  alignment: isUser
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 10,
                    ),
                    constraints: const BoxConstraints(maxWidth: 260),
                    decoration: BoxDecoration(
                      color: isUser ? AppColors.accentPink : Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.04),
                          blurRadius: 8,
                        ),
                      ],
                    ),
                    child: Text(
                      msg['text'],
                      style: TextStyle(
                        color: isUser ? Colors.white : AppColors.textPrimary,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // 입력창
          Container(
            padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
            color: Colors.white,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: "메시지를 입력하세요...",
                      filled: true,
                      fillColor: Colors.grey.shade100,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 12,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    onSubmitted: (_) => _sendMessage(),
                  ),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: _sendMessage,
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.accentPink,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.send_rounded,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
