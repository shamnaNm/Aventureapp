import 'package:aventure/models/wishlist%20model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class ActivityModel{
  String? id;
  String? location;
  String? title;
  String? image;
  double ?price;
  String?description;
  String?duration;
  String?eventer;
  String ?eventManagerId;
  String?sealevel;
  String?weight; String?category;
  List<Map<String, dynamic>>? schedules;
  ActivityModel({this.id,this.title,this.location,this.price,this.image,this.description,this.duration,this.eventer,this.sealevel,this.weight,this.category, this.schedules,this.eventManagerId
    });
  factory ActivityModel.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return ActivityModel(
      id: snapshot.id,
      title: data['title'],
      location: data['location'],
      price: data['price']?.toDouble(),
      image: data['image'],
      description: data['description'],
      duration: data['duration'],
      eventer: data['eventer'],
      sealevel: data['sealevel'],
      weight: data['weight'], category: data['category'],
      schedules: List<Map<String, dynamic>>.from(data['schedules'] ?? []),
      eventManagerId: data['eventManagerId'],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'id':id,
      'location': location,
      'title': title,
      'image': image,
      'price': price,
      'description': description,
      'duration': duration,
      'eventer': eventer,
      'sealevel': sealevel,
      'weight': weight,
      'category':category,
      'schedules': schedules,
      'eventManagerId': eventManagerId,
    };
  }
  WishlistModel toWishlistModel() {
    return WishlistModel(
      activityId: id,
      title: title,
      location: location,
      price: price,
      image: image,
      category: category,
      userId: '',
    );
  }
}