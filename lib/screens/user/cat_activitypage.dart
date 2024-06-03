import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:aventure/models/activity_model.dart'; // Import the ActivityModel

class CategoryActivitiesPage extends StatelessWidget {
  final String categoryId;
  final String categoryTitle;

  const CategoryActivitiesPage({Key? key, required this.categoryId, required this.categoryTitle}) : super(key: key);

  Future<List<ActivityModel>> _fetchActivitiesForCategory(String categoryId) async {
    try {
      QuerySnapshot activitySnapshot = await FirebaseFirestore.instance
          .collection('activities')
          .where('categoryId', isEqualTo: categoryId)
          .get();
      List<ActivityModel> activities = activitySnapshot.docs
          .map((doc) => ActivityModel.fromSnapshot(doc))
          .toList();
      return activities;
    } catch (e) {
      print('Error fetching activities: $e');
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
      ),
      body: FutureBuilder<List<ActivityModel>>(
        future: _fetchActivitiesForCategory(categoryId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (snapshot.hasData) {
            List<ActivityModel> activities = snapshot.data!;
            return ListView.builder(
              itemCount: activities.length,
              itemBuilder: (context, index) {
                ActivityModel activity = activities[index];
                return ListTile(
                  title: Text(activity.title ?? ''),
                  subtitle: Text(activity.description ?? ''),
                  // Add more widgets to display additional activity information
                );
              },
            );
          } else {
            return Center(
              child: Text('No activities found'),
            );
          }
        },
      ),
    );
  }
}
