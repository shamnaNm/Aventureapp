import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/eventmanager_model.dart';
import '../../services/eventmanager_service.dart';

class EventManagerPage extends StatefulWidget {
  const EventManagerPage({Key? key}) : super(key: key);

  @override
  State<EventManagerPage> createState() => _EventManagerPageState();
}

class _EventManagerPageState extends State<EventManagerPage> {
  final EventManagerService _eventManagerService = EventManagerService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Event Managers',
          style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('eventmanager').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              EventManager eventManager = EventManager.fromJson(document);
              return Padding(
                padding: const EdgeInsets.all(8.0),
               
                  child: ListTile(
                    tileColor: Colors.grey.withOpacity(0.2),
                    title:  Text('Co.Name: ${eventManager.companyname}'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(eventManager.name),
                        Text(eventManager.email),

                      ],
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () async {
                        // Show confirmation dialog before deleting
                        bool delete = await showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Delete Event Manager'),
                              content: Text('Are you sure you want to delete ${eventManager.name}?'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(false); // Cancel deletion
                                  },
                                  child: Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(true); // Confirm deletion
                                  },
                                  child: Text(
                                    'Delete',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                        if (delete == true) {
                          await _eventManagerService.deleteEventManager(eventManager.id!);
                        }
                      },
                    ),
                  ),

              );
            }).toList(),
          );
        },
      ),
    );
  }
}
