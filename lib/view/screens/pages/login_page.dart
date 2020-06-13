import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterchat/view/screens/pages/chat_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //ログインに関する情報を表示するメッセージ
  String infoText = '';

  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('ログイン'),
        ),
        body: Center(
            child: Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(labelText: 'メールアドレス'),
                onChanged: (String value) {
                  setState(() {
                    email = value;
                  });
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'パスワード'),
                onChanged: (String value) {
                  setState(() {
                    password = value;
                  });
                },
              ),
              Container(
                padding: const EdgeInsets.all(8),
                child: Text(infoText),
              ),
              Container(
                width: double.infinity,
                child: RaisedButton(
                    color: Colors.blue,
                    textColor: Colors.white,
                    child: const Text('ユーザ登録'),
                    onPressed: () async {
                      try {
                        //メールアドレス・パスワードでユーザ登録
                        final auth = FirebaseAuth.instance;
                        final result =
                            await auth.createUserWithEmailAndPassword(
                                email: email, password: password);

                        final user = result.user;

                        //ユーザ登録に成功した場合
                        await Navigator.of(context).pushReplacement(
                          MaterialPageRoute<void>(builder: (context) {
                            return ChatPage(user: user);
                          }),
                        );
                      } on Exception catch (error) {
                        setState(() {
                          infoText = 'ログインに失敗しました。:$error';
                        });
                      }
                    }),
              ),
              Container(
                width: double.infinity,
                child: OutlineButton(
                  textColor: Colors.blue,
                  child: const Text('ログイン'),
                  onPressed: () async {
                    try {
                      //メール・パスワードでログイン
                      final auth = FirebaseAuth.instance;
                      final result = await auth.signInWithEmailAndPassword(
                          email: email, password: password);
                      //ログインに成功した時の処理
                      final user = result.user;
                      await Navigator.of(context).pushReplacement(
                          MaterialPageRoute<void>(builder: (context) {
                        return ChatPage(
                          user: user,
                        );
                      }));
                    } on Exception catch (error) {
                      setState(() {
                        infoText = 'ログインに失敗しました$error.message';
                      });
                    }
                  },
                ),
              )
            ],
          ),
        )));
  }
}
