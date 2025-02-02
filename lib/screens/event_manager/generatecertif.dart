
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class CertificateListPage extends StatelessWidget {
  const CertificateListPage({super.key});
  @override
  Widget build(BuildContext context) {
    return  StreamBuilder(
        stream: FirebaseFirestore.instance.collection('certificates').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          final certificates = snapshot.data!.docs;
          return ListView.builder(
            itemCount: certificates.length,
            itemBuilder: (context, index) {
              final cert = certificates[index];
              final data = cert.data() as Map<String, dynamic>;
              final name = data['name'];
              final activity = data['activity'];
              dynamic date = data['date']; // It could be Timestamp or String
              // Check the type of date and handle accordingly
              if (date is Timestamp) {
                date = date.toDate().toString();
              } else if (date is String) {
                // Handle your date string format if needed
              }
              return ListTile(
                title: Text('$name - $activity'),
                subtitle: Text('Date: $date'),
              );
            },
          );
        },

    );
  }
}


