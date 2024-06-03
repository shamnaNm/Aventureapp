import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../models/activity_model.dart';
import '../../services/activityService.dart';
import 'editactivity.dart';

class DetailedActivityPage extends StatefulWidget {
  final ActivityModel activity;

  DetailedActivityPage({required this.activity});

  @override
  State<DetailedActivityPage> createState() => _DetailedActivityPageState();
}

class _DetailedActivityPageState extends State<DetailedActivityPage> {
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
  void _deleteActivity(BuildContext context) async {
    try {
      if (widget.activity.id != null) {
        await _activityService.deleteActivity(widget.activity.id!);
        Navigator.pop(context); // Navigate back after deletion
      }
    } catch (e) {
      // Show error message if there's an issue
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error deleting activity: $e')),
      );
    }
  }
  void _editActivity(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditActivityPage(activity: widget.activity),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(widget.activity.title ?? 'Activity Details',style: TextStyle(color: Colors.white),),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () => _editActivity(context),
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () => _deleteActivity(context),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              if (widget.activity.image != null)
                Image.network(widget.activity.image!),
              SizedBox(height: 8),
              Text(
                widget.activity.title ?? '',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text('Category: ${widget.activity.category ?? 'N/A'}'),
              SizedBox(height: 8),
              Text('Location: ${widget.activity.location ?? 'Unknown'}'),
              SizedBox(height: 8),
              Text('Price: Rs ${widget.activity.price?.toStringAsFixed(2) ?? 'N/A'}'),
              SizedBox(height: 8),
              Text('Duration in Hours: ${widget.activity.duration ?? 'N/A'} hr'),
              SizedBox(height: 8),
              Text('Eventer Name/Company Name: ${widget.activity.eventer ?? 'N/A'}'),
              SizedBox(height: 8),
              Text('Height above Sea Level: ${widget.activity.sealevel ?? 'N/A'} M'),
              SizedBox(height: 8),
              Text('Restricted Weight: ${widget.activity.weight ?? 'N/A'} Kg'),
              SizedBox(height: 8),
              Text('Description: ${widget.activity.description ?? 'N/A'}'),
              SizedBox(height: 8),
              if (widget.activity.schedules != null && widget.activity.schedules!.isNotEmpty)
                ...widget.activity.schedules!.map((schedule) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Scheduled Time: ${schedule['time']}'),
                      Text('Tickets: ${schedule['tickets']}'),
                      SizedBox(height: 8),
                    ],
                  );
                }).toList(),
            ],
          ),
        ),
      ),
    );
  }
}
