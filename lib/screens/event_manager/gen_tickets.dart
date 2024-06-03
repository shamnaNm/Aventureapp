
import 'dart:io';
import 'dart:typed_data';
import 'package:aventure/screens/event_manager/listtickets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pdfWid;
import 'package:printing/printing.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GenerateTicket extends StatelessWidget {
  final String ticketNumber;
  final String eventer;
  final String activity;
  final String category;
  final double amountPaid;
  final int numberOfTickets;

  GenerateTicket({
    required this.ticketNumber,
    required this.eventer,
    required this.activity,
    required this.category,
    required this.amountPaid,
    required this.numberOfTickets,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Generate Ticket'),
        actions: [
          IconButton(
            icon: Icon(Icons.list),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => PdfListPage(),
                ),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TicketWidget(
              ticketNumber: ticketNumber,
              eventer: eventer,
              activity: activity,
              category: category,
              amountPaid: amountPaid,
              numberOfTickets: numberOfTickets,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final pdfData = await _createPdf();
                final pdfFile = await _savePdfFile(pdfData);
                updataBooking(ticketNumber);
                _viewPdf(context, pdfFile);
              },
              child: Text('Generate PDF Ticket'),
            ),
          ],
        ),
      ),
    );
  }

  Future<Uint8List> _createPdf() async {
    final pdf = pdfWid.Document(version: PdfVersion.pdf_1_4, compress: true);
    final ByteData bytes = await rootBundle.load('assets/img/aventures.png');
    final Uint8List byteList = bytes.buffer.asUint8List();
    final image = pdfWid.MemoryImage(byteList);

    pdf.addPage(
      pdfWid.Page(
        pageFormat: PdfPageFormat.a4,
        build: (context) {
          return pdfWid.Container(
            padding: pdfWid.EdgeInsets.all(16.0),
            child: pdfWid.Column(
              mainAxisSize: pdfWid.MainAxisSize.min,
              crossAxisAlignment: pdfWid.CrossAxisAlignment.start,
              children: [
                pdfWid.Center(
                  child: pdfWid.Image(image, height: 80, width: 80),
                ),
                pdfWid.SizedBox(height: 30.0),
                pdfWid.Text(
                  'Ticket Number: $ticketNumber',
                  style: pdfWid.TextStyle(
                      fontSize: 18, fontWeight: pdfWid.FontWeight.bold),
                ),
                pdfWid.SizedBox(height: 8.0),
                pdfWid.Text(
                  'Eventer: $eventer',
                  style: pdfWid.TextStyle(fontSize: 16),
                ),
                pdfWid.SizedBox(height: 8.0),
                pdfWid.Text(
                  'Activity: $activity',
                  style: pdfWid.TextStyle(fontSize: 16),
                ),
                pdfWid.SizedBox(height: 8.0),
                pdfWid.Text(
                  'Category: $category',
                  style: pdfWid.TextStyle(fontSize: 16),
                ),
                pdfWid.SizedBox(height: 8.0),
                pdfWid.Text(
                  'Amount Paid: ₹Rs. ${amountPaid.toStringAsFixed(2)}',
                  style: pdfWid.TextStyle(fontSize: 16),
                ),
                pdfWid.SizedBox(height: 8.0),
                pdfWid.Text(
                  'Number of Tickets: $numberOfTickets',
                  style: pdfWid.TextStyle(fontSize: 16),
                ),
              ],
            ),
          );
        },
      ),
    );

    return pdf.save();
  }

  Future<void> updataBooking(String bookingid)async{

    await FirebaseFirestore.instance.collection('bookings').doc(bookingid).update({
     'status':1
  });

}

  // Future<File> _savePdfFile(Uint8List pdfData) async {
  //   final directory = await getApplicationDocumentsDirectory();
  //   final file = File('${directory.path}/ticket.pdf');
  //   await file.writeAsBytes(pdfData);
  //   return file;
  // }


  Future<File> _savePdfFile(Uint8List pdfData) async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/ticket_${DateTime.now().millisecondsSinceEpoch}.pdf');
    await file.writeAsBytes(pdfData);

    // Upload PDF to Firestore Storage and get the URL
    final storageRef = FirebaseStorage.instance.ref().child('tickets/${file.path.split('/').last}');
    await storageRef.putFile(file);
    final pdfUrl = await storageRef.getDownloadURL();

    // Save the URL in Firestore
    await FirebaseFirestore.instance.collection('tickets').add({
      'ticketNumber': ticketNumber,
      'pdfUrl': pdfUrl,
      'timestamp': FieldValue.serverTimestamp(),
    });

    return file;
  }





  // Future<File> _savePdfFile(Uint8List pdfData) async {
  //   final directory = await getApplicationDocumentsDirectory();
  //   final file = File('${directory.path}/ticket_${DateTime.now().millisecondsSinceEpoch}.pdf');
  //   await file.writeAsBytes(pdfData);
  //
  //   // Save the file path to shared preferences
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   List<String> pdfList = prefs.getStringList('pdfList') ?? [];
  //   pdfList.add(file.path);
  //   await prefs.setStringList('pdfList', pdfList);
  //
  //   return file;
  // }
  //


//   void _viewPdf(BuildContext context, File file) {
//     Navigator.of(context).push(
//       MaterialPageRoute(
//         builder: (_) => PDFViewer(filePath: file.path,),
//       ),
//     );
//   }
// }
  void _viewPdf(BuildContext context, File file) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) =>
            PDFViewer(
              filePath: file.path,
              tickectNumber: ticketNumber,
              eventer: eventer,
              activity: activity,
              category: category,
              amountPaid: amountPaid,
              numberOfTickets: numberOfTickets,
            ),
      ),
    );
  }
}
class PDFViewer extends StatelessWidget {
  final String filePath;
  final String? tickectNumber;
  final String? eventer;
  final String ?activity;
  final String ?category;
  final double? amountPaid;
  final int? numberOfTickets;

  PDFViewer({
    required this.filePath,
    this.tickectNumber,
    this.eventer,
    this.activity,
    this.category,
    this.amountPaid,
    this.numberOfTickets,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PDF Viewer'),
      ),
      body: PDFView(
        filePath: filePath,
        tickectNumber: tickectNumber,
        eventer: eventer,
        activity: activity,
        category: category,
        amountPaid: amountPaid,
        numberOfTickets: numberOfTickets,
      ),
    );
  }
}
class TicketWidget extends StatelessWidget {
  final String ticketNumber;
  final String eventer;
  final String activity;
  final String category;
  final double amountPaid;
  final int numberOfTickets;
  TicketWidget({
    required this.ticketNumber,
    required this.eventer,
    required this.activity,
    required this.category,
    required this.amountPaid,
    required this.numberOfTickets,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Ticket Number: $ticketNumber'),
        Text('Eventer: $eventer'),
        Text('Activity: $activity'),
        Text('Category: $category'),
        Text('Amount Paid: ₹Rs. ${amountPaid.toStringAsFixed(2)}'),
        Text('Number of Tickets: $numberOfTickets'),
      ],
    );
  }
}
class PDFView extends StatefulWidget {
  final String filePath;
  final String? tickectNumber;
  final String? eventer;
  final String ?activity;
  final String ?category;
  final double? amountPaid;
  final int? numberOfTickets;
  const PDFView({required this.filePath, this.tickectNumber, Key? key, this.eventer, this.activity,  this.category,  this.amountPaid,  this.numberOfTickets}) : super(key: key);

  @override
  _PDFViewState createState() => _PDFViewState();
}

class _PDFViewState extends State<PDFView> {
  @override
  Widget build(BuildContext context) {
    return
      PdfPreview(
        build: (format) => _createPdf(format),
      );

  }

  Future<Uint8List> _createPdf(PdfPageFormat format) async {
    final pdf = pdfWid.Document(version: PdfVersion.pdf_1_4, compress: true);
    final ByteData bytes = await rootBundle.load('assets/img/aventures.png');
    final Uint8List byteList = bytes.buffer.asUint8List();
    final image = pdfWid.MemoryImage(byteList);

    pdf.addPage(
      pdfWid.Page(
        pageFormat: PdfPageFormat.a4,
        build: (context) {
          return pdfWid.Container(
            padding: pdfWid.EdgeInsets.all(16.0),
            child: pdfWid.Column(
              mainAxisSize: pdfWid.MainAxisSize.min,
              crossAxisAlignment: pdfWid.CrossAxisAlignment.start,
              children: [
                pdfWid.Center(
                  child: pdfWid.Image(image, height: 50, width: 50),
                ),
                pdfWid.SizedBox(height: 8.0),
                pdfWid.Text(
                  'Ticket Number: ${widget.tickectNumber}',
                  style: pdfWid.TextStyle(fontSize: 18, fontWeight: pdfWid.FontWeight.bold),
                ),
                pdfWid.SizedBox(height: 8.0),
                pdfWid.Text(
                  'Eventer: ${widget.eventer}',
                  style: pdfWid.TextStyle(fontSize: 16),
                ),
                pdfWid.SizedBox(height: 8.0),
                pdfWid.Text(
                  'Activity: ${widget.activity}',
                  style: pdfWid.TextStyle(fontSize: 16),
                ),
                pdfWid.SizedBox(height: 8.0),
                pdfWid.Text(
                  'Category: ${widget.category}',
                  style: pdfWid.TextStyle(fontSize: 16),
                ),
                pdfWid.SizedBox(height: 8.0),
                pdfWid.Text(
                  'Amount Paid: ₹Rs. ${widget.amountPaid}',
                  style: pdfWid.TextStyle(fontSize: 16),
                ),
                pdfWid.SizedBox(height: 8.0),
                pdfWid.Text(
                  'Number of Tickets: ${widget.numberOfTickets}',
                  style: pdfWid.TextStyle(fontSize: 16),
                ),
              ],
            ),
          );
        },
      ),
    );
    return pdf.save();
  }
}

