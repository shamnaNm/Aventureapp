import 'package:cloud_firestore/cloud_firestore.dart';

class WishlistModel {
  String? id; // Optional: If you want to store unique IDs for wishlist items
  String? userId; // New field to associate wishlist items with users
  String? activityId;
  String? title;
  String? location;
  double? price;
  String? image;
  String? category;

  WishlistModel({
    this.id,
    required this.userId, // Required: To associate wishlist items with users
    this.activityId,
    this.title,
    this.location,
    this.price,
    this.image,
    this.category,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id, // Optional: If you want to store unique IDs for wishlist items
      'userId': userId,
      'activityId': activityId,
      'title': title,
      'location': location,
      'price': price,
      'image': image,
      'category': category,
    };
  }
  factory WishlistModel.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return WishlistModel(
      id: snapshot.id, // Optional: If you want to store unique IDs for wishlist items
      userId: data['userId'],
      activityId: data['activityId'],
      title: data['title'],
      location: data['location'],
      price: data['price']?.toDouble(),
      image: data['image'],
      category: data['category'],
    );
  }
}
