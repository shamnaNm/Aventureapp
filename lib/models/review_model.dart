
import 'package:flutter/material.dart';

class Review {
 final String id;
 final String username;
 final String comment;
 final double rating; // Assuming rating is on a scale of 1 to 5

 Review({
  required this.id,
  required this.username,
  required this.comment,
  required this.rating,
 });

 factory Review.fromJson(Map<String, dynamic> json) {
  return Review(
   id: json['id'],
   username: json['username'],
   comment: json['comment'],
   rating: json['rating'].toDouble(),
  );
 }

 Map<String, dynamic> toJson() {
  return {
   'id': id,
   'username': username,
   'comment': comment,
   'rating': rating,
  };
 }
}
