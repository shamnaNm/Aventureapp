import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel{
  String?id;
  String?title;
  CategoryModel({this.id,this.title,});

  factory CategoryModel.fromDocumentSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return CategoryModel(
      id: snapshot.id,
      title: data['title'],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
    };
  }
}


