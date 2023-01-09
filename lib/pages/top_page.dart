import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fletter_memo/model/memo.dart';
import 'package:fletter_memo/pages/add_edit_memo_page.dart';
import 'package:fletter_memo/pages/memo_detail_page.dart';

import 'package:flutter/material.dart';

class TopPage extends StatefulWidget {
  const TopPage({super.key, required this.title});


  final String title;

  @override
  State<TopPage> createState() => _TopPageState();
}

class _TopPageState extends State<TopPage> {
 final memoCollection = FirebaseFirestore.instance.collection('memo');

// 削除機能
 Future<void> deleteMemo(String id) async{
   final doc = FirebaseFirestore.instance.collection('memo').doc(id);
   await doc.delete();
 }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: const Text('筋トレメモkk'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        //　並び替え：where→何かと一致するもの
        stream: memoCollection.orderBy('createdDate' , descending: true).snapshots(),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting){
    return const CircularProgressIndicator();
          }
          // もしデータがなければ
          if(!snapshot.hasData){
            return const Center(child: Text('ないデータ'),);
          }
          final docs = snapshot.data!.docs;
          return ListView.builder(
              itemCount: docs.length,
              itemBuilder: (context, index) {
                // オブジェクト型はダイナミック型にする必要がある。ダイナミック型って何？
                Map<String, dynamic> data = docs[index].data() as Map<String, dynamic>;

                final Memo fetchMemo = Memo(
                  id: docs[index].id,
                    title: data['title'],
                    detail: data['detail'],
                    createdDate: data['createdDate'],
                    updatedDate: data['updatedDate']

                );
                return ListTile(
                    title: Text(fetchMemo.title),
                  trailing: IconButton(
                    onPressed: (){
                        showModalBottomSheet(context: context, builder: (context){
                           return SafeArea(
                             child: Column(
                               mainAxisSize: MainAxisSize.min,
                               children: [
                                 ListTile(
                                   onTap: (){
                                     // 表示を1回だけ出すようにする
                                     Navigator.pop(context);
                                     Navigator.push(context, MaterialPageRoute(
                                         builder: (context) => AddEditMemoPage(currentMemo: fetchMemo,)));
                                   },
                                   leading: Icon(Icons.edit),
                                   title: Text('編集'),
                                 ),
                                 ListTile(
                                   onTap: () async{


                                     await deleteMemo(fetchMemo.id);
                                     Navigator.pop(context);
                                   },

                                   leading: Icon(Icons.delete),
                                   title: Text('削除'),
                                 ),
                               ],
                             ),
                           );
                        });
                    },
                    icon: const Icon(Icons.edit),
                  ),
                  //クリックできるようにするプロパティ
                  onTap: () {
                    //詳細画面に遷移する記述を書く
                    Navigator.push(context, MaterialPageRoute(
                    builder: (context) => MemoDetailPage(fetchMemo)));
                  }
                );
              }
          );
        }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => AddEditMemoPage()));
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
