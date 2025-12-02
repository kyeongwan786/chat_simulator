import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("로그인")),
      body: Center(
        child: ElevatedButton(
          onPressed: () => context.go('/home'),
          child: Text("로그인 없이 시작하기"),
        ),
      ),
    );
  }
}
