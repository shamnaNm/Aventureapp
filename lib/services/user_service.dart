import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user_model.dart';

class UserService {
  // register
  //login
  // logout
  //alrady logined
  Future<String?> registerUser(UserModel user) async {
    try {
      UserCredential userResponse = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: user.email.toString(), password: user.password.toString());

      final usermodel = UserModel(
          role: user.role,
          email: user.email,
          uid: userResponse.user!.uid,
          password: user.password,
          name: user.name,
          phone: user.phone,
          status: user.status);

      FirebaseFirestore.instance
          .collection('login')
          .doc(userResponse.user!.uid)
          .set({
        'uid': usermodel.uid,
        'role': usermodel.role,
        'email': usermodel.email,
        'status': usermodel.status
      });

      FirebaseFirestore.instance
          .collection('user')
          .doc(userResponse.user!.uid)
          .set(usermodel.toMap());

      return "";
    } on FirebaseAuthException catch (e) {
      print('Firebase Auth Exception: ${e.message}');
      return e.message; // Return Firebase Auth error message
    } catch (e) {
      print('Error: $e');
      return 'Registration failed: $e'; // Return generic error message
    }
  }

  Future<List<UserModel>> getAllUsers() async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('user').get();

      List<UserModel> users =
          querySnapshot.docs.map((doc) => UserModel.fromJson(doc)).toList();
      return users;
    } catch (e) {
      throw Exception('Failed to fetch users: $e');
    }
  }
  Future<void> deleteUser(String userId) async {
    try {
      await FirebaseFirestore.instance.collection('user').doc(userId).delete();
      await FirebaseFirestore.instance.collection('login').doc(userId).delete();
    } catch (e) {
      throw Exception('Failed to delete user: $e');
    }
  }
  Future<void> updateUser(
      String? uid,
      String name,
      String address,
      String phone,
      String gender,
      String nationality,
      String experienceLevel) async {
    FirebaseFirestore.instance.collection('user').doc(uid!).update({
      'gender': gender,
      'nationality': nationality,
      'experienceLevel': experienceLevel,
      'phone': phone,
      'address': address,
      'name': name
    });

    SharedPreferences _pref = await SharedPreferences.getInstance();
    _pref.setString('name', name);

    _pref.setString('phone', phone);
    _pref.setString('address', address);
  }
}
