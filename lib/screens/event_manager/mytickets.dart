
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

class UserTicketsPage extends StatefulWidget {
  final String userid;

  UserTicketsPage({required this.userid});

  @override
  _UserTicketsPageState createState() => _UserTicketsPageState();
}

class _UserTicketsPageState extends State<UserTicketsPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('My Tickets', style: TextStyle(color: Colors.white)),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('tickets').where('userid', isEqualTo: widget.userid).snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final tickets = snapshot.data?.docs ?? [];

          return ListView.builder(
            itemCount: tickets.length,
            itemBuilder: (context, index) {
              final ticket = tickets[index];
              return ListTile(
                title: Text(ticket['activity']),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Eventer: ${ticket['eventer']}'),
                    Text('Category: ${ticket['category']}'),
                    Text('Amount Paid: Rs. ${ticket['amountPaid']}'),
                    Text('Number of Tickets: ${ticket['numberOfTickets']}'),
                    // Text('date. ${ticket['date']}'),
                    // Text('time: ${ticket['time']}'),

                  ],
                ),
                trailing: IconButton(
                  icon: Icon(Icons.picture_as_pdf),
                  onPressed: () {
                    _viewPdf(context, ticket['pdfUrl']);
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }

  void _viewPdf(BuildContext context, String pdfUrl) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => PDFViewPage(pdfUrl: pdfUrl),
      ),
    );
  }
}

class PDFViewPage extends StatefulWidget {
  final String pdfUrl;

  PDFViewPage({required this.pdfUrl});

  @override
  _PDFViewPageState createState() => _PDFViewPageState();
}

class _PDFViewPageState extends State<PDFViewPage> {
  String? localFilePath;

  @override
  void initState() {
    super.initState();
    _downloadPdf();
  }

  _downloadPdf() async {
    final response = await http.get(Uri.parse(widget.pdfUrl));
    final bytes = response.bodyBytes;
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/temp.pdf');
    await file.writeAsBytes(bytes, flush: true);
    setState(() {
      localFilePath = file.path;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PDF Viewer'),
      ),
      body: localFilePath != null
          ? PDFView(
        filePath: localFilePath,
      )
          : Center(child: CircularProgressIndicator()),
    );
  }
}
