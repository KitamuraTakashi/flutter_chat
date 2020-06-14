import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MessagePostPage extends StatefulWidget {
  const MessagePostPage(this.user);

  final FirebaseUser user;
  @override
  _MessagePostPageState createState() => _MessagePostPageState();
}

class _MessagePostPageState extends State<MessagePostPage> {
  //入力投稿メッセージ
  String messageText = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('チャット投稿'),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              //投稿メッセージ
              TextFormField(
                decoration: const InputDecoration(labelText: '投稿メッセージ'),
                //複数行のテキスト入力
                keyboardType: TextInputType.multiline,
                //最大行数
                maxLines: 3,
                onChanged: (String value) {
                  setState(() {
                    messageText = value;
                  });
                },
              ),
              Container(
                width: double.infinity,
                child: RaisedButton(
                  color: Colors.blue,
                  textColor: Colors.white,
                  child: const Text('投稿'),
                  onPressed: () async {
                    //現在の日時
                    final date = DateTime.now().toLocal().toIso8601String();
                    final email = widget.user.email;

                    //投稿メッセージ用のdocument作成
                    await Firestore.instance
                        .collection('messages')
                        .document()
                        .setData(<String, dynamic>{
                      'text': messageText,
                      'email': email,
                      'date': date
                    });
                    //一つ前の画面に戻る
                    Navigator.of(context).pop();
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
