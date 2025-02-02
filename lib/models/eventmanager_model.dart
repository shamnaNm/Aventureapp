
import 'package:cloud_firestore/cloud_firestore.dart';

class EventManager {
  String? id;
  final String email;
  final String password;
  final String name;
  final String phone;
  final String companyname;
  final String qualification;
  final String role;
  final int ?status;
  final String?description;
  final String? img;
  EventManager({
    this.id,
    required this.email,
    required this.password,
    required this.name,
    required this.phone,
    required this.companyname,
    required this.qualification,
    required this.role,
     this.status,
    this.description,this.img,
  });

  Map<String, dynamic> toJson() {
    return {
      'id':id,
      'email': email,
      'password': password,
      'name': name,
      'phone': phone,
      'companyname': companyname,
      'qualification': qualification,
      'role':role,
      'status': status,
      'description':description,
      'img':img
    };
  }

  factory EventManager.fromJson(DocumentSnapshot doc) {
    Map<String, dynamic> json = doc.data() as Map<String, dynamic>;
    return EventManager(
      role: json['role'],
      id: json['id'],
      email: json['email'],
      password: json['password'],
      name: json['name'],
      phone: json['phone'],
      companyname: json['companyname'],
      qualification: json['qualification'],
      status: json['status'],
      description: json['description'],
      img: json['img']
    );
  }


  // Convert EventManager object to JSON

}
