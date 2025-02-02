
import 'package:aventure/screens/event_manager/generatecertif.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:aventure/screens/event_manager/gen_tickets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class PdfListCertificate extends StatefulWidget {
  const PdfListCertificate({super.key});
  @override
  State<PdfListCertificate> createState() => _PdfListCertificateState();
}

class _PdfListCertificateState extends State<PdfListCertificate> {
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
    return  StreamBuilder(
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
              final userid = data['userid'];

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
                    trailing: IconButton(
                      icon: Icon(Icons.picture_as_pdf),
                      onPressed: () {
                        String formattedDate = date != null ? "${date.day}/${date.month}/${date.year}" : "N/A";
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => GenerateCertificatePage(
                            eventer: eventer,
                            activity: activity,
                            date: formattedDate,
                            userId: userid,
                          ),
                        ));
                      },
                    ),
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
    );
  }
}


class GenerateCertificatePage extends StatelessWidget {
  final String eventer;
  final String activity;
  final String date;
  final String userId;

  GenerateCertificatePage({
    required this.eventer,
    required this.activity,
    required this.date,
    required this.userId,
  });

  Future<String?> getUsername(String userId) async {
    try {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection(
          'user').doc(userId).get();
      if (userDoc.exists) {
        return userDoc['name']; // Assuming you have a 'name' field in your users collection
      } else {
        print('User document does not exist');
        return null;
      }
    } catch (e) {
      print('Error getting username: $e');
      return null;
    }
  }

  Future<void> generateCertificate(String name, String activity,
      String date) async {
    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Column(
              mainAxisAlignment: pw.MainAxisAlignment.center,
              children: [
                pw.Text(
                  'Certificate of Participation',
                  style: pw.TextStyle(
                      fontSize: 24, fontWeight: pw.FontWeight.bold),
                  textAlign: pw.TextAlign.center,
                ),
                pw.SizedBox(height: 20),
                pw.Text(
                  'This is to certify that $name',
                  style: pw.TextStyle(fontSize: 20),
                  textAlign: pw.TextAlign.center,
                ),
                pw.Text(
                  'has participated in $activity',
                  style: pw.TextStyle(fontSize: 20),
                  textAlign: pw.TextAlign.center,
                ),
                pw.Text(
                  'on $date',
                  style: pw.TextStyle(fontSize: 20),
                  textAlign: pw.TextAlign.center,
                ),
              ],
            ),
          );
        },
      ),
    );

    await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => pdf.save());

    // Save certificate details to Firestore
    await FirebaseFirestore.instance.collection('certificates').add({
      'name': name,
      'activity': activity,
      'date': date,
      'userId': userId,
      'generatedAt': Timestamp.now(),
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Generate Certificate'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            String? username = await getUsername(userId);
            if (username != null) {
              await generateCertificate(username, activity, date);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(
                    'Certificate generated and saved to database.')),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Failed to retrieve username.')),
              );
            }
          },
          child: Text('Generate Certificate'),
        ),
      ),
    );
  }
}