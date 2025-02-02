
import 'package:aventure/screens/user/activity.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:aventure/models/activity_model.dart';

class CategoryActivitiesPage extends StatefulWidget {
  final String title;

  const CategoryActivitiesPage({Key? key, required this.title})
      : super(key: key);

  @override
  _CategoryActivitiesPageState createState() => _CategoryActivitiesPageState();
}

class _CategoryActivitiesPageState extends State<CategoryActivitiesPage> {
  late Stream<List<ActivityModel>> _activitiesStream;

  @override
  void initState() {
    super.initState();
    _activitiesStream = _getActivitiesByCategoryTitle(widget.title);
  }

  Stream<List<ActivityModel>> _getActivitiesByCategoryTitle(String title) {
    return FirebaseFirestore.instance
        .collection('activities')
        .where('category', isEqualTo: title) // Assuming 'category' is the field containing category titles in the activities documents
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map((doc) => ActivityModel.fromSnapshot(doc))
        .toList());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Category Activities',style: TextStyle(color: Colors.white),),
      ),
      body: StreamBuilder<List<ActivityModel>>(
        stream: _activitiesStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.data!.isEmpty) {
            return Center(child: Text('No activities found for this category'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final activity = snapshot.data![index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.orange)
                    ),
                    child: ListTile(
                      leading: Image.network(activity.image ?? ''),
                      title: Text(activity.title ?? ''),
                      subtitle: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(activity.location ?? ''), Text(activity.eventer ?? ''),
                        ],
                      ),
                      onTap: (){ Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ActivityPage(
                            activity: activity,
                          ),
                        ),
                      );},// Add more details as needed
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
