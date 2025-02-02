
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
          qualification: user.qualification,
          status: 0
      );

 
      await FirebaseFirestore.instance.collection('login').doc(userResponse.user!.uid).set({
        'uid': eventmanager.id,
        'role': eventmanager.role,
        'email': eventmanager.email,'status':eventmanager.status
      });

      await FirebaseFirestore.instance.collection('eventmanager').doc(userResponse.user!.uid).set(eventmanager.toJson());

      // Notify the admin
      await _notifyAdmin(eventmanager);

      return "";
    } on FirebaseAuthException catch (e) {
      print('Firebase Auth Exception: ${e.message}');
      return e.message; // Return Firebase Auth error message
    } catch (e) {
      print('Error: $e');
      return 'Registration failed: $e'; // Return generic error message
    }
  }
  Future<void> deleteEventManager(String eventManagerId) async {
    try {
      await FirebaseFirestore.instance.collection('eventmanager').doc(eventManagerId).delete();
      await FirebaseFirestore.instance.collection('login').doc(eventManagerId).delete();
    } catch (e) {
      throw Exception('Failed to delete event manager: $e');
    }
  }
  Future<List<EventManager>> getPendingRegistrations() async {
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance
          .collection('eventmanager')
          .where('status', isEqualTo:0)
          .get();

      List<EventManager> pendingRegistrations = snapshot.docs
          .map((DocumentSnapshot<Map<String, dynamic>> doc) => EventManager.fromJson(doc))
          .toList();
      return pendingRegistrations;
    } catch (e) {
      throw Exception('Failed to get pending registrations: $e');
    }
  }
  // Method to approve a registration
  Future<void> approveRegistration(String registrationId) async {
    try {
      await FirebaseFirestore.instance
          .collection('eventmanager')
          .doc(registrationId)
          .update({'status': 1}).then((value) {


       FirebaseFirestore.instance
            .collection('login')
            .doc(registrationId)
            .update({'status': 1});

      });
    } catch (e) {
      throw Exception('Failed to approve registration: $e');
    }
  }// Method to reject a registration
  Future<void> rejectRegistration(String registrationId) async {
    try {
      await FirebaseFirestore.instance
          .collection('eventmanager')
          .doc(registrationId)
          .update({'status': 'rejected'});
    } catch (e) {
      throw Exception('Failed to reject registration: $e');
    }
  }
  Future<void> _notifyAdmin(EventManager eventManager) async {
    // Create a notification for the admin
    await FirebaseFirestore.instance.collection('admin_notifications').add({
      'message': 'New eventers registration: ${eventManager.name}',
      'event_manager_id': eventManager.id,
      'timestamp': DateTime.now(),
    });
  }
  Future<void> updateEventManager(
      String? uid,
      String name,
      String description,
      String phone,
      String qualification,
      String companyname,
      String img
      ) async {
    FirebaseFirestore.instance.collection('eventmanager').doc(uid!).update({
      'companyname': companyname,
      'qualification': qualification,
      'description': description,
      'phone': phone,
      'img': img,
      'name': name
    });
    SharedPreferences _pref = await SharedPreferences.getInstance();
    _pref.setString('name', name);
    _pref.setString('companyname', companyname);
    _pref.setString('phone', phone);
    _pref.setString('img', img);
    _pref.setString('qualification', qualification);
    _pref.setString('description', description);
  }
}

