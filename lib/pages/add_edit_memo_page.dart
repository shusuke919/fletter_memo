import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fletter_memo/model/memo.dart';
import 'package:flutter/material.dart';

class AddEditMemoPage extends StatefulWidget {
  //currentMemo変数に編集情報収集を入れる
  // Xx？→なくても良い　？Xx→なければ〜
  final Memo? currentMemo;
  const AddEditMemoPage({Key? key, this.currentMemo}) : super(key: key);

  @override
  State<AddEditMemoPage> createState() => _AddEditMemoPageState();
}

class _AddEditMemoPageState extends State<AddEditMemoPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController detailController = TextEditingController();

  //メソットとして追加
  Future<void> createMemo() async {
    final memoCollection = FirebaseFirestore.instance.collection('memo');
    await memoCollection.add({
      'title' : titleController.text,
      'detail' : detailController.text,
      'createdDate' : Timestamp.now()
    });
  }

  //更新機能
  Future<void> updateMemo() async{
    final doc = FirebaseFirestore.instance.collection('memo').doc(widget.currentMemo!.id);
     await doc.update({
      'title' : titleController.text,
      'detail' : detailController.text,
      'updatedDate' : Timestamp.now()
    });

  }


  //編集画面
  @override
  void initState() {
    super.initState();
    if(widget.currentMemo != null) {
      titleController.text = widget.currentMemo!.title;
      detailController.text = widget.currentMemo!.detail;
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // 三項演算子
        title: Text(widget.currentMemo == null ? 'memo追加' : 'メモ編集'),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
            const Text('タイトル'),
            const SizedBox(height: 20),
            Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey)
                ),
                width: MediaQuery.of(context).size.width*0.8,
                child: TextField(
                  controller: titleController,
                  decoration: InputDecoration(border: InputBorder.none,
                      contentPadding: EdgeInsets.only(left: 10)
                  ),
                )
            ),
            const SizedBox(height: 40),
            const Text('詳細'),
            const SizedBox(height: 20),
            Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey)
                ),
                width: MediaQuery.of(context).size.width*0.8,
                child: TextField(
                  controller: detailController,
                  decoration: InputDecoration(border: InputBorder.none,
                      contentPadding: EdgeInsets.only(left: 10)
                  ),
                )
            ),
            const SizedBox(height: 40),
            Container(
                width: MediaQuery.of(context).size.width*0.8,
                alignment: Alignment.center,

                child: ElevatedButton(
                  onPressed: () async{
                    //メモを処理する記述を作成
                    if(widget.currentMemo == null){
                      await createMemo();
                    }else{
                      await updateMemo();
                    }
                    //一番上のレイヤーを取り除く
                    Navigator.pop(context);
                  },
                  child: Text(widget.currentMemo == null ? '追加' : '更新'),
                ))
          ],
        ),
      ),
    );
  }
}






