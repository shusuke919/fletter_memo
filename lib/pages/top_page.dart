import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fletter_memo/model/memo.dart';
import 'package:fletter_memo/pages/add_memo_page.dart';
import 'package:fletter_memo/pages/memo_detail_page.dart';

import 'package:flutter/material.dart';

class TopPage extends StatefulWidget {
  const TopPage({super.key, required this.title});


  final String title;

  @override
  State<TopPage> createState() => _TopPageState();
}

class _TopPageState extends State<TopPage> {
List<Memo> memoList = [];

Future<void> fetchMemo() async{
  //firebaseにアクセス
  final memoCollection = await FirebaseFirestore.instance.collection('memo').get();
  //memoコレクションを取得
  final docs = memoCollection.docs;
  for(var doc in docs) {
    Memo fetchMemo = Memo(
        title: doc.data()['title'],
        detail: doc.data()['detail'],
        createdDate: doc.data()['createdDate']
    );
   memoList.add(fetchMemo);
  }
  setState(() {});
}

@override
void initState(){
  super.initState();
  fetchMemo();
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: const Text('筋トレメモkk'),
      ),
      body: ListView.builder(
          itemCount: memoList.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(memoList[index].title),
              //クリックできるようにするプロパティ
              onTap: () {
                //詳細画面に遷移する記述を書く
                Navigator.push(context, MaterialPageRoute(
                builder: (context) => MemoDetailPage(memoList[index])));
              }
            );
          }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => AddMemoPage()));
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
