


import 'package:fletter_memo/model/memo.dart';
import 'package:flutter/material.dart';

class MemoDetailPage extends StatelessWidget {
  final Memo memo;
  //MemoDetailPageに画面遷移する際にmemoの内容を取得してくる
  const MemoDetailPage(this.memo, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(memo.title),
      ),
      //columウイジェットはチルドレンプロパティに入っているウィジェットを縦に入れる役目がある
      body: Center(
        child: Column(
          //中央揃え
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('メモ詳細', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
            Text(memo.detail, style: TextStyle(fontSize: 20),),
          ],
        ),
      )
    );
  }
}
