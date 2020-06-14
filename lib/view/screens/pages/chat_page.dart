import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterchat/view/screens/pages/login_page.dart';
import 'package:flutterchat/view/screens/pages/message_post.dart';

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
                MaterialPageRoute<MaterialPageRoute>(builder: (context) {
                  return LoginPage();
                }),
              );
            },
          )
        ],
      ),
      body: Column(
        // ユーザー情報を表示
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(8),
            child: Text('ログイン情報：${user.email}'),
          ),
          Expanded(
              //FutureBuilder
              //h動機処理の結果を基にWidgetを作成
              child: FutureBuilder<QuerySnapshot>(
            //メッセージを取得する
            future: Firestore.instance
                .collection('messages')
                .orderBy('date')
                .getDocuments(),

            builder: (context, snapshot) {
              //データが取得できた場合
              if (snapshot.hasData) {
                final List<DocumentSnapshot> documents =
                    snapshot.data.documents;

                //取得した投稿メッセージを一覧に表示
                return ListView(
                  children: documents.map((document) {
                    return Card(
                      child: ListTile(
                        title: Text(document['text'].toString()),
                        subtitle: Text(document['email'].toString()),
                      ),
                    );
                  }).toList(),
                );
              }

              return const Center(
                child: Text('読込中...'),
              );
            },
          ))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          //投稿画面に遷移
          await Navigator.of(context).push(
            MaterialPageRoute<MaterialPageRoute>(builder: (context) {
              return MessagePostPage(user);
            }),
          );
        },
      ),
    );
  }
}
