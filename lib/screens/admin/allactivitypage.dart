import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AllActivityListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text('Activities',style: TextStyle(color: Colors.white),),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('activities').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No activities found'));
          }

          final activities = snapshot.data!.docs;

          return ListView.builder(
            itemCount: activities.length,
            itemBuilder: (context, index) {
              final activity = activities[index].data() as Map<String, dynamic>;
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.orange)
                  ),
                  child: ListTile(
                    leading: Image.network(activity['image']!),
                    title: Text(activity['title']),
                    subtitle: Text(activity['description']),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ActivityDetailPage(activity: activity),
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
class ActivityDetailPage extends StatelessWidget {
  final Map<String, dynamic> activity;

  ActivityDetailPage({required this.activity});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text(activity['title'],style: TextStyle(color:  Colors.white,),),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Image.network(activity['image']),
            SizedBox(height: 16.0),
            Text(
              activity['title'],
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(activity['description']),
            SizedBox(height: 8.0),
            Text('Location: ${activity['location']}'),
            Text('Category: ${activity['category']}'),
            Text('Price: ₹${activity['price']}'),
            Text('Duration: ${activity['duration']} hours'),
            Text('Sealevel: ${activity['sealevel']} meters'),
            Text('Weight: ${activity['weight']} kg'),
            Text('Event Manager ID: ${activity['eventManagerId']}'),
            SizedBox(height: 16.0),
            Text(
              'Schedules:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            ...List.generate(activity['schedules'].length, (index) {
              final schedule = activity['schedules'][index];
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 4.0),
                child: Text('${schedule['time']}: ${schedule['tickets']} tickets'),
              );
            }),
          ],
        ),
      ),
    );
  }
}
