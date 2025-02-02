

import 'package:aventure/screens/event_manager/gen_tickets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PdfListPage extends StatefulWidget {
  @override
  State<PdfListPage> createState() => _PdfListPageState();
}

class _PdfListPageState extends State<PdfListPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var uid;
  var companyname;
  getData() async {
    uid = FirebaseAuth.instance.currentUser!.uid;
    DocumentSnapshot userDoc = await _firestore.collection('eventmanager').doc(uid).get();
    companyname = userDoc['companyname'];
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getData();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text(
          'Generated Tickets',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('tickets')
            .where('eventer', isEqualTo: companyname)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          final pdfDocs = snapshot.data!.docs;
          return ListView.builder(
            itemCount: pdfDocs.length,
            itemBuilder: (context, index) {
              final doc = pdfDocs[index];
              final data = doc.data() as Map<String, dynamic>;
              final pdfUrl = data['pdfUrl'];
              final ticketNumber = data['ticketNumber'];
              final eventer = data['eventer'];
              final category = data['category'];
              final activity = data['activity'];
              final amountPaid = data['amountPaid'];
              final numberOfTickets = data['numberOfTickets'];
              final date = data.containsKey('date') ? (data['date'] as Timestamp).toDate() : null;
              final time = data.containsKey('time') ? data['time'] : null;

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.black),
                  ),
                  child: ListTile(
                    title: Text('Ticket Number: $ticketNumber'),
                    // subtitle: Text(pdfUrl),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => PDFViewer(
                          filePath: pdfUrl,
                          tickectNumber: ticketNumber,
                          eventer: eventer,
                          numberOfTickets: numberOfTickets,
                          activity: activity,
                          amountPaid: amountPaid,
                          category: category,
                          date: date,
                          time: time,
                        ),
                      ));
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
