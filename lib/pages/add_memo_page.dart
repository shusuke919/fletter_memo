import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddMemoPage extends StatefulWidget {
  const AddMemoPage({Key? key}) : super(key: key);

  @override
  State<AddMemoPage> createState() => _AddMemoPageState();
}

class _AddMemoPageState extends State<AddMemoPage> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('っっっd'),
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
                    await createMemo();
                    //一番上のレイヤーを取り除く
                    Navigator.pop(context);
                  },
                  child: const Text('追加'),
                ))
          ],
        ),
      ),
    );
  }
}






