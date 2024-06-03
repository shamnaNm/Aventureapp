import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../models/activity_model.dart';
import '../../services/activityService.dart';
import 'listactivity.dart';


class AllCreatedActivitiesPage extends StatefulWidget {
  @override
  State<AllCreatedActivitiesPage> createState() => _AllCreatedActivitiesPageState();
}

class _AllCreatedActivitiesPageState extends State<AllCreatedActivitiesPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  var uid;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    uid = FirebaseAuth.instance.currentUser!.uid;
    setState(() {});
  }

  final ActivityService _activityService = ActivityService();

  void _navigateToDetailedActivityPage(BuildContext context, ActivityModel activity) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailedActivityPage(activity: activity),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('All Created Activities',style: TextStyle(color: Colors.white),),
      ),
      body: StreamBuilder<List<ActivityModel>>(
        stream: _activityService.getActivities(uid),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

         if(snapshot.hasData){
           final activities = snapshot.data ?? [];

           return ListView.builder(
             itemCount: activities.length,
             itemBuilder: (context, index) {
               final activity = activities[index];
               return Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: ListTile(
                   style: ListTileStyle.list,
                   tileColor: Colors.orange[100],
                   leading: Container(
                     height: 100,
                     width: 100,

                     decoration:activity.image!=null? BoxDecoration(
                         shape: BoxShape.circle,
                         image: DecorationImage(
                             image: NetworkImage(
                                 activity.image.toString()
                             )
                         )
                     ):BoxDecoration(
                       shape: BoxShape.circle,


                     ),
                   ),
                   title: Text(activity.title ?? ''),
                   subtitle: Text('Location: ${activity.location}, Price:Rs.${activity.price}, Category: ${activity.category}'),
                   onTap: () => _navigateToDetailedActivityPage(context, activity),
                   trailing: Icon(Icons.arrow_forward),
                 ),
               );
             },
           );
         }

         return Center(
           child: CircularProgressIndicator(),
         );
        },
      ),
    );
  }
}
