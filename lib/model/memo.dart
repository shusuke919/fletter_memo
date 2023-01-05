import 'package:cloud_firestore/cloud_firestore.dart';

class Memo {
  String title;
  String detail;
  Timestamp createdDate;
  //?　nullもしくはデータ型が入る可能性がある意味
  Timestamp? updatedDate;

  Memo({
    //required必須項目
    required this.title,
    required this.detail,
    required this.createdDate,
    this.updatedDate

});
}