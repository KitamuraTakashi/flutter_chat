import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  ChatPage({this.user});
  // ユーザー情報
  final FirebaseUser user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('チャット'),
      ),
      body: Center(
        // ユーザー情報を表示
        child: Text('ログイン情報：${user.email}'),
      ),
    );
  }
}
