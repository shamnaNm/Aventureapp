import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../models/activity_model.dart';

class ActivityService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final CollectionReference _activitiesCollection = FirebaseFirestore.instance.collection('activities');

  // Add a new activity
  Future<bool?> addActivity(ActivityModel activity, XFile imgurl ) async {
    var url;
    var filename=activity.id;
    try {
      var ref=FirebaseStorage.instance.ref().child('activity/$filename');
      UploadTask utask=ref.putFile(File(imgurl!.path));
    await utask.then((res)async{
        url=(await ref.getDownloadURL()).toString();
      }).then((value) {
        ActivityModel _activity=ActivityModel(
          id: activity.id,
          title:  activity.title,
          location: activity.location,
          price:activity. price,
          duration: activity.duration,
          weight: activity.weight,
          image:url,
          description: activity.description,
          eventer: activity.eventer,
          sealevel:activity. sealevel,
          category: activity.category,
          schedules: activity.schedules,
          eventManagerId:activity.eventManagerId,
        );
        _activitiesCollection.doc(activity.id).set(_activity.toMap());
        return true;
      });
    } catch (e) {
      throw Exception("Failed to add activity: $e");
    }
  }
  // Update an existing activity
  Future<void> updateActivity(String id, ActivityModel activity) async {
    try {
      await _activitiesCollection.doc(id).update(activity.toMap());
    } catch (e) {
      throw Exception("Failed to update activity: $e");
    }
  }
  // Delete an activity by id
  Future<void> deleteActivity(String id) async {
    try {
      await _activitiesCollection.doc(id).delete();
    } catch (e) {
      throw Exception("Failed to delete activity: $e");
    }
  }
  // Get a specific activity by id
  Future<ActivityModel?> getActivityById(String id) async {
    try {
      DocumentSnapshot doc = await _activitiesCollection.doc(id).get();
      if (doc.exists) {
        return ActivityModel.fromSnapshot(doc);
      }
      return null;
    } catch (e) {
      throw Exception("Failed to get activity: $e");
    }
  }
  // Get a stream of activities for real-time updates
  Stream<List<ActivityModel>> getActivities(String id) {
    return _activitiesCollection.where('eventManagerId',isEqualTo: id).snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => ActivityModel.fromSnapshot(doc)).toList();
    });
  }

  Stream<List<ActivityModel>> getActivitiesByCategory(String categoryId) {
    return _activitiesCollection
        .where('categoryId', isEqualTo: categoryId)
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map((doc) => ActivityModel.fromSnapshot(doc))
        .toList());
  }

}
