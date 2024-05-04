
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/eventmanager_model.dart';


class EventManagerService{


  Future<String?> registerUser(EventManager user) async {
    try {
      UserCredential userResponse = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
          email: user.email.toString(), password: user.password.toString());

      final eventmanager=EventManager(
          role: user.role,
          email:user.email,
          id: userResponse.user!.uid,
          password:user.password,
          name: user.name, phone: user.phone,
          companyname: user.companyname,
          qualification: user.qualification);

      FirebaseFirestore.instance
          .collection('login')
          .doc(userResponse.user!.uid)
          .set({

        'uid':eventmanager.id,
        'role':eventmanager.role,
        'email':eventmanager.email
      });


      FirebaseFirestore.instance
          .collection('eventmanager')
          .doc(userResponse.user!.uid)
          .set(eventmanager.toJson());

      return "";
    } on FirebaseAuthException catch (e) {
      print('Firebase Auth Exception: ${e.message}');
      return e.message; // Return Firebase Auth error message
    } catch (e) {
      print('Error: $e');
      return 'Registration failed: $e'; // Return generic error message
    }
  }



}
