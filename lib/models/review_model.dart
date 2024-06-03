
import 'package:built_value/serializer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Review {
 final String? name;
 final String? uid;
 final String? avatarUrl;
 String? review;
 double ?rating;
 final Timestamp ?timestamp;

 static Serializer? serializer;

 Review(
     {this.name,
      this.uid,
      this.avatarUrl,
      this.review,
      this.rating,
      this.timestamp});

 factory Review.fromMap(Map<String,dynamic> data) {


  return Review(
   name: data['name'],
   uid: data['uid'],
   review: data["review"],
   rating: data["rating"],
   timestamp: data["timestamp"],
   avatarUrl: data["avatarUrl"],
  );
 }




}
