import 'package:aventure/models/eventmanager_model.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EventManagerProfilePage extends StatefulWidget {
  // Add this line
  @override
  _EventManagerProfilePageState createState() => _EventManagerProfilePageState();
}

class _EventManagerProfilePageState extends State<EventManagerProfilePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  EventManager? eventManager;

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    String uid = _auth.currentUser!.uid;
    DocumentSnapshot doc = await _firestore.collection('eventmanager').doc(uid).get();
    setState(() {
      eventManager = EventManager.fromJson(doc);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Eventer',style: TextStyle(color: Colors.white),),
      ),
      body: eventManager == null
          ? Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: eventManager?.img != null && eventManager!.img!.isNotEmpty
                      ? NetworkImage(eventManager!.img!)
                      : null,
                  child: (eventManager?.img == null || eventManager!.img!.isEmpty)
                      ? Icon(
                    Icons.person,
                    color: Colors.grey,
                    size: 45,
                  )
                      : null,
                  backgroundColor: Colors.grey[200],
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Name: ${eventManager?.name ?? 'N/A'}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'Email: ${eventManager?.email ?? 'N/A'}',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 8),
              Text(
                'Phone: ${eventManager?.phone ?? 'N/A'}',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 8),
              Text(
                'Company Name: ${eventManager?.companyname ?? 'N/A'}',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 8),
              Text(
                'Qualification: ${eventManager?.qualification ?? 'N/A'}',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 8),
              Text(
                'About Company: ${eventManager?.description ?? 'N/A'}',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
