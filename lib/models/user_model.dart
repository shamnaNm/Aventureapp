// blue print
// email, pass, id, name, mobile, createdat status

// methods

// to firebase
// from firebase
import 'package:cloud_firestore/cloud_firestore.dart';
class UserModel {
  String? uid;
  String? name;
  String? email;
  String? password;
  String?phone;
  String? role;
  int? status;
  DateTime? createdAt;
  String? address;
 // DateTime? dob;
  String? gender;
  String? nationality;
  String? experienceLevel;
  String? imgUrl;

  UserModel(
      {this.uid,
        this.name,
        this.email,
        this.password,
        this.createdAt,
        this.status,
        this.phone,
        this.role,
        this.address,
      //  this.dob,
        this.gender,
        this.nationality,
        this.experienceLevel,
      this.imgUrl});
  // fromJson
// Convert DocumentSnapshot to UserModel object
  factory UserModel.fromJoson(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return UserModel(
      uid: doc.id,
      name: data['name'],
      email: data['email'],
      password: data['password'],
      role: data['role'],
      phone: data['phone'],
      status: data['status'],
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      address: data['address'],
    //  dob: (data['dob'] as Timestamp).toDate(),
      gender: data['gender'],
      nationality: data['nationality'],
      experienceLevel: data['experienceLevel'],
      imgUrl: data['imgUrl'],
    );
  }// Convert UserModel object to Map
  Map<String, dynamic> toMap() {
    return {
      'uid':uid,
      'name': name,
      'email': email,
      'password': password,
      'role': role,
      'status': status,
      'phone':phone,
      'createdAt': createdAt ?? FieldValue.serverTimestamp(),
      'address': address,
     // 'dob': dob != null ? Timestamp.fromDate(dob!) : FieldValue.serverTimestamp(),
      'gender': gender,
      'nationality': nationality,
      'experienceLevel': experienceLevel,
     'imgUrl': imgUrl
    };
  }
  factory UserModel.fromJson(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return UserModel(
      uid: doc.id,
      name: data['name'],
      email: data['email'],
      password: data['password'],
      role: data['role'],
      phone: data['phone'],
      status: data['status'],
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      address: data['address'],
     // dob: (data['dob'] as Timestamp).toDate(),
      gender: data['gender'],
      nationality: data['nationality'],
      experienceLevel: data['experienceLevel'],
      imgUrl: data['imgUrl'],
    );
  }
// toMap
  // Create a UserModel from Firestore document
  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map;
    return UserModel(
      uid: data['uid'] ?? '',
      email: data['email'] ?? '',
      password: data['password'] ?? '',
      role: data['role'] ?? '',
      name: data['name'] ?? '',
      phone: data['phone'] ?? '',
    );
  }
}
