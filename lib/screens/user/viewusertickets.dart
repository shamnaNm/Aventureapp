
import 'dart:io';
import 'package:aventure/screens/event_manager/gen_tickets.dart';
import 'package:aventure/screens/event_manager/mytickets.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

class TicketListScreen extends StatefulWidget {
  @override
  _TicketListScreenState createState() => _TicketListScreenState();
}

class _TicketListScreenState extends State<TicketListScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  User? _currentUser;

  @override
  void initState() {
    super.initState();
    _currentUser = _auth.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    if (_currentUser == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text('My Tickets'),
        ),
        body: Center(
          child: Text('No user logged in.'),
        ),
      );
    }
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('My Tickets', style: TextStyle(color: Colors.white)),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore
            .collection('tickets')
            .where('userid', isEqualTo: _currentUser!.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          final tickets = snapshot.data?.docs ?? [];
          if (tickets.isEmpty) {
            return Center(child: Text('No tickets found.'));
          }
          return ListView.builder(
            itemCount: tickets.length,
            itemBuilder: (context, index) {
              final ticket = tickets[index];
              final Timestamp timestamp = ticket['date'];
              final DateTime dateTime = timestamp.toDate();

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.orange.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    title: Text(ticket['activity']),
                    subtitle: Text('Amount Paid: \$${ticket['amountPaid']}'),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => PDFViewer(
                            // pdfUrl: ticket['pdfUrl'],
                            tickectNumber: ticket['ticketNumber'],
                            eventer: ticket['eventer'],
                            activity: ticket['activity'],
                            category: ticket['category'],
                            amountPaid: ticket['amountPaid'],
                            time: ticket['time'],
                            numberOfTickets: ticket['numberOfTickets'],
                            filePath: '',
                            date: dateTime,
                          ),
                        ),
                      );
                      // You can handle tap event here if needed
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
