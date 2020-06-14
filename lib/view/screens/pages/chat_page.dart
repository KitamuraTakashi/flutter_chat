import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterchat/view/screens/pages/login_page.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({this.user});
  // ユーザー情報
  final FirebaseUser user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('チャット'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () async {
              /*
              ログアウト処理
              内部で保持しているログイン情報などが初期化される
              */
              await FirebaseAuth.instance.signOut();
              //ログイン画面に遷移＋チャット画面を破棄
              await Navigator.of(context).pushReplacement(
                MaterialPageRoute<void>(builder: (context) {
                  return LoginPage();
                }),
              );
            },
          )
        ],
      ),
      body: Center(
        // ユーザー情報を表示
        child: Text('ログイン情報：${user.email}'),
      ),
    );
  }
}
