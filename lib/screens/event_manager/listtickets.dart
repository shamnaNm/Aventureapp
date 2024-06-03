import 'package:aventure/screens/event_manager/gen_tickets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
//
//   class PdfListPage extends StatefulWidget {
//   @override
//   _PdfListPageState createState() => _PdfListPageState();
// }
//
// class _PdfListPageState extends State<PdfListPage> {
//   List<String> pdfList = [];
//
//   @override
//   void initState() {
//     super.initState();
//     _loadPdfList();
//     getData();
//   }
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//
//   var uid;
//   getData() async {
//     uid = FirebaseAuth.instance.currentUser!.uid;
//     setState(() {});
//   }
//   Future<void> _loadPdfList() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     setState(() {
//       pdfList = prefs.getStringList('pdfList') ?? [];
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.orange,
//         title: Text('Generated Tickets',style: TextStyle(color: Colors.white,),),
//       ),
//       body: ListView.builder(
//         itemCount: pdfList.length,
//         itemBuilder: (context, index) {
//           String pdfPath = pdfList[index];
//           return Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Container(
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(10),
//                 border: Border.all(color: Colors.black)
//               ),
//               child: ListTile(
//
//                 title: Text('Ticket ${index + 1}'),
//                 subtitle: Text(pdfPath),
//                 onTap: () {
//                   Navigator.of(context).push(
//                     MaterialPageRoute(
//                       builder: (_) => PDFViewer(filePath: pdfPath),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
class PdfListPage extends StatefulWidget {
  @override
  State<PdfListPage> createState() => _PdfListPageState();
}

class _PdfListPageState extends State<PdfListPage> {


  @override
  void initState() {
    super.initState();
    getData();
  }
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  var uid;
  getData() async {
    uid = FirebaseAuth.instance.currentUser!.uid;
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text('Generated Tickets',style: TextStyle(color: Colors.white,),),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('tickets').//where('eventManagerId',isEqualTo:uid)
        snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          final pdfDocs = snapshot.data!.docs;
          return ListView.builder(
            itemCount: pdfDocs.length,
            itemBuilder: (context, index) {
              final doc = pdfDocs[index];
              final pdfUrl = doc['pdfUrl'];
              final ticketNumber = doc['ticketNumber'];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                     decoration: BoxDecoration(
                   borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.black)
                 ),
                  child: ListTile(
                    title: Text('Ticket Number: $ticketNumber'),
                    subtitle: Text(pdfUrl),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => PDFViewer(filePath: pdfUrl),
                        ),
                      );
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
