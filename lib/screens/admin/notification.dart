import 'package:flutter/material.dart';
import '../../models/eventmanager_model.dart';
import '../../services/eventmanager_service.dart';

class NotificationAccess extends StatefulWidget {
  const NotificationAccess({Key? key}) : super(key: key);

  @override
  State<NotificationAccess> createState() => _NotificationAccessState();
}

class _NotificationAccessState extends State<NotificationAccess> {
  final EventManagerService _eventManagerService = EventManagerService();
  late Future<List<EventManager>> _pendingRegistrations;

  @override
  void initState() {
    super.initState();
    _pendingRegistrations = _eventManagerService.getPendingRegistrations();
  }

  void _approveRegistration(String registrationId) async {
    try {
      await _eventManagerService.approveRegistration(registrationId);
      // Reload pending registrations after approval
      setState(() {
        _pendingRegistrations = _eventManagerService.getPendingRegistrations();
      });
    } catch (e) {
      // Handle error
      print('Error approving registration: $e');
    }
  }

  void _rejectRegistration(String registrationId) async {
    try {
      await _eventManagerService.rejectRegistration(registrationId);
      // Reload pending registrations after rejection
      setState(() {
        _pendingRegistrations = _eventManagerService.getPendingRegistrations();
      });
    } catch (e) {
      // Handle error
      print('Error rejecting registration: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Pending Registrations'),
      ),
      body: FutureBuilder<List<EventManager>>(
        future: _pendingRegistrations,
        builder: (BuildContext context,
            AsyncSnapshot<List<EventManager>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }


          else {
            List<EventManager> registrations = snapshot.data!;
            return registrations.length==0?Center(
              child: Text("No Pending Requests"),
            ):ListView.builder(
              itemCount: registrations.length,
              itemBuilder: (BuildContext context, int index) {
                EventManager registration = registrations[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    tileColor: Colors.grey.withOpacity(0.1),
                    title: Text(registration.companyname),
                    subtitle: Text(registration.email),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.check),
                          color: Colors.green,
                          onPressed: () {
                            _approveRegistration(
                                registration.id!); // Approve registration
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.close),
                          color: Colors.red,
                          onPressed: () {
                            _rejectRegistration(
                                registration.id!); // Reject registration
                          },
                        ),
                      ],
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