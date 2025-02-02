//
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:printing/printing.dart';
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pw;
//
// class UserCertificatesPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         title: Text('Your Certificates'),
//       ),
//       body: StreamBuilder(
//         stream: FirebaseFirestore.instance
//             .collection('certificates')
//             .where('userId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
//             .snapshots(),
//         builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           }
//           if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           }
//           final certificates = snapshot.data!.docs;
//           return ListView.builder(
//             itemCount: certificates.length,
//             itemBuilder: (context, index) {
//               final cert = certificates[index];
//               final data = cert.data() as Map<String, dynamic>;
//               final name = data['name'];
//               final activity = data['activity'];
//               final date = _parseDate(data['date']);
//               final pdfUrl = data['pdfUrl'];
//               return ListTile(
//                 title: Text('$name - $activity'),
//                 subtitle: Text('Date: $date'),
//                 trailing: IconButton(
//                   icon: Icon(Icons.download),
//                   onPressed: () async {
//                     await _viewOrDownloadPdf(pdfUrl);
//                   },
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
//
//   String _parseDate(dynamic dateData) {
//     if (dateData is Timestamp) {
//       return (dateData as Timestamp).toDate().toString();
//     } else if (dateData is String) {
//       // Attempt to parse dateData assuming it's in the format '31/8/2024'
//       try {
//         List<String> parts = dateData.split('/');
//         int day = int.parse(parts[0]);
//         int month = int.parse(parts[1]);
//         int year = int.parse(parts[2]);
//         return DateTime(year, month, day).toString();
//       } catch (e) {
//         print('Error parsing date: $e');
//         return 'Invalid Date';
//       }
//     }
//     return 'N/A'; // Return a default value if dateData is not recognized
//   }
//
//   Future<void> _viewOrDownloadPdf(String pdfUrl) async {
//     final pdf = pw.Document();
//     pdf.addPage(
//       pw.Page(
//         build: (pw.Context context) {
//           return pw.Center(
//             child: pw.Text(
//               'Certificate of Participation\n\n'
//                   'This is to certify that the user has participated in an activity.',
//               style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold),
//               textAlign: pw.TextAlign.center,
//             ),
//           );
//         },
//       ),
//     );
//     await Printing.layoutPdf(onLayout: (PdfPageFormat format) async => pdf.save());
//     // You can implement further logic here to display or download the generated PDF
//     // For simplicity, the example above generates a basic certificate.
//   }
// }

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:printing/printing.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class UserCertificatesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Participation Certificates',style: TextStyle(color: Colors.white),),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('certificates')
            .where('userId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
            .snapshots(),
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
              final date = _parseDate(data['date']);
              final userId = data['userId']; // Get userId from Firestore data

              return ListTile(
                title: Text('$name - $activity'),
                subtitle: Text('Date: $date'),
                trailing: IconButton(
                  icon: Icon(Icons.download),
                  onPressed: () async {
                    await _viewOrDownloadPdf(name, activity, date);
                  },
                ),
              );
            },
          );


        },
      ),
    );
  }

  String _parseDate(dynamic dateData) {
    if (dateData is Timestamp) {
      return (dateData as Timestamp).toDate().toString();
    } else if (dateData is String) {
      // Attempt to parse dateData assuming it's in the format '31/8/2024'
      try {
        List<String> parts = dateData.split('/');
        int day = int.parse(parts[0]);
        int month = int.parse(parts[1]);
        int year = int.parse(parts[2]);
        return DateTime(year, month, day).toString();
      } catch (e) {
        print('Error parsing date: $e');
        return 'Invalid Date';
      }
    }
    return 'N/A'; // Return a default value if dateData is not recognized
  }



  Future<void> _viewOrDownloadPdf(String name, String activity, String date) async {

    final pdf = pw.Document();

    // final ByteData bytes = await rootBundle.load('assets/img/adventures.png');
    // final Uint8List byteList = bytes.buffer.asUint8List();
    // final image = pw.MemoryImage(byteList);
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Column(
              mainAxisAlignment: pw.MainAxisAlignment.center,
              crossAxisAlignment: pw.CrossAxisAlignment.center,
              children: [
                // pw.Image(image, height: 50, width: 50),
                // pw.SizedBox(height: 20),
                pw.Text(
                  'Certificate of Participation',
                  style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold),
                  textAlign: pw.TextAlign.center,
                ),
                pw.SizedBox(height: 20),
                pw.Text(
                  'This is to certify that $name has participated in $activity',
                  style: pw.TextStyle(fontSize: 18),
                  textAlign: pw.TextAlign.center,
                ),
                pw.SizedBox(height: 20),
                pw.Text(
                  'Date: $date',
                  style: pw.TextStyle(fontSize: 16),
                  textAlign: pw.TextAlign.center,
                ),
              ],
            ),
          );
        },
      ),
    );

    await Printing.layoutPdf(onLayout: (PdfPageFormat format) async => pdf.save());
  }

}

