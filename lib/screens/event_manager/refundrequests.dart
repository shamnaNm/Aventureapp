//
//
// import 'package:aventure/screens/user/notification.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
//
// class RefundRequestList extends StatefulWidget {
//   const RefundRequestList({super.key});
//
//   @override
//   State<RefundRequestList> createState() => _RefundRequestListState();
// }
//
// class _RefundRequestListState extends State<RefundRequestList> {
//   bool _isLoading = true;
//   List<Map<String, dynamic>> refundRequests = [];
//
//   String? uid;
//
//   @override
//   void initState() {
//     super.initState();
//     fetchCurrentUser();
//   }
//
//   Future<void> fetchCurrentUser() async {
//     try {
//       User? user = FirebaseAuth.instance.currentUser;
//       if (user != null) {
//         uid = user.uid;
//         await fetchRefundRequests();
//       }
//     } catch (e) {
//       print("Error fetching current user: $e");
//     }
//   }
//
//   Future<void> fetchRefundRequests() async {
//     try {
//       var refundDocs = await FirebaseFirestore.instance
//           .collection('refund_requests')
//           .where('eventManagerId', isEqualTo: uid)
//           .get();
//
//       setState(() {
//         refundRequests = refundDocs.docs.map((doc) {
//           var data = doc.data();
//           data['id'] = doc.id; // Store document ID
//           return data;
//         }).toList();
//         _isLoading = false;
//       });
//     } catch (e) {
//       print("Error fetching refund requests: $e");
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }
//
//   void processRefundRequest(Map<String, dynamic> refund) async {
//     try {
//       String? userId = refund['userId'];
//       double? refundAmount = refund['refundAmount'];
//       String? refundId = refund['id']; // Get the document ID
//
//       // Ensure none of these values are null
//       if (userId == null || refundAmount == null || refundId == null) {
//         throw Exception('Invalid refund data: $refund');
//       }
//
//       // Deduct the refund amount from the user's payments
//       var paymentDocs = await FirebaseFirestore.instance
//           .collection('payments')
//           .where('userId', isEqualTo: userId)
//           .get();
//
//       for (var doc in paymentDocs.docs) {
//         double currentAmount = doc['amountPaid'];
//         double newAmount = currentAmount - refundAmount;
//
//         await doc.reference.update({'amountPaid': newAmount});
//       }
//       // Update the refund request status to 'Processed'
//       await FirebaseFirestore.instance
//           .collection('refund_requests')
//           .doc(refundId) // Use the document ID for update
//           .update({
//         'status': 'Processed',
//         'refundedAt': FieldValue.serverTimestamp(),
//       });
//       var updatedRefundDoc = await FirebaseFirestore.instance
//           .collection('refund_requests')
//           .doc(refundId)
//           .get();
//
//       var updatedRefund = updatedRefundDoc.data();
//       if (updatedRefund == null) {
//         throw Exception('Failed to fetch updated refund data');
//       }
//
//
//
//       // Navigate to the RefundedDetailsPage with refund details
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => RefundedDetailsPage(refund: refund),
//         ),
//       );
//
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         content: Text('Refund processed successfully.'),
//       ));
//     } catch (e) {
//       print("Error processing refund request: $e");
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         content: Text('Failed to process refund request'),
//       ));
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         title: Text(
//           'Refund Requests',
//           style: TextStyle(
//             color: Colors.white,
//           ),
//         ),
//         actions: [
//           IconButton(
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => ProcessedRefundsPage(),
//                 ),
//               );
//             },
//             icon: Icon(Icons.monitor),
//           )
//         ],
//       ),
//       body: _isLoading
//           ? Center(child: CircularProgressIndicator())
//           : ListView.builder(
//               itemCount: refundRequests.length,
//               itemBuilder: (context, index) {
//                 final refund = refundRequests[index];
//                 return GestureDetector(
//                   onTap: () => processRefundRequest(refund),
//                   child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Container(
//                       decoration: BoxDecoration(
//                         color: Colors
//                             .white, // Add background color for better visibility
//                         borderRadius: BorderRadius.circular(10),
//                         border: Border.all(color: Colors.orange),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.grey.withOpacity(0.5),
//                             spreadRadius: 2,
//                             blurRadius: 5,
//                             offset: Offset(0, 3),
//                           ),
//                         ],
//                       ),
//                       child: ListTile(
//                         title: Text('Booking ID: ${refund['bookingId']}'),
//                         subtitle: Text(
//                           'User ID: ${refund['userId']}\n'
//                           'Refund Amount: \$${refund['refundAmount']}\n'
//                           'Status: ${refund['status']}\n'
//                           'Requested At: ${refund['requestedAt'].toDate()}',
//                         ),
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             ),
//     );
//   }
// }
//
// class RefundedDetailsPage extends StatelessWidget {
//   final Map<String, dynamic> refund;
//
//   const RefundedDetailsPage({super.key, required this.refund});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Refunded Details'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text('Booking ID: ${refund['bookingId']}'),
//             SizedBox(height: 8),
//             Text('User ID: ${refund['userId']}'),
//             SizedBox(height: 8),
//             Text('Refund Amount: \$${refund['refundAmount']}'),
//             SizedBox(height: 8),
//             Text('Status: ${refund['status']}'),
//             SizedBox(height: 8),
//             Text('Requested At: ${refund['requestedAt'].toDate()}'),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class ProcessedRefundsPage extends StatefulWidget {
//   @override
//   _ProcessedRefundsPageState createState() => _ProcessedRefundsPageState();
// }
//
// class _ProcessedRefundsPageState extends State<ProcessedRefundsPage> {
//   bool _isLoading = true;
//   List<Map<String, dynamic>> processedRefunds = [];
//
//   @override
//   void initState() {
//     super.initState();
//     fetchProcessedRefunds();
//   }
//
//   Future<void> fetchProcessedRefunds() async {
//     try {
//       var refundDocs = await FirebaseFirestore.instance
//           .collection('refund_requests')
//           .where('status', isEqualTo: 'Processed')
//           .get();
//       setState(() {
//         processedRefunds = refundDocs.docs.map((doc) {
//           var data = doc.data();
//           data['id'] = doc.id; // Store document ID
//           return data;
//         }).toList();
//         _isLoading = false;
//       });
//     } catch (e) {
//       print("Error fetching processed refunds: $e");
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Processed Refunds'),
//       ),
//       body: _isLoading
//           ? Center(child: CircularProgressIndicator())
//           : ListView.builder(
//               itemCount: processedRefunds.length,
//               itemBuilder: (context, index) {
//                 final refund = processedRefunds[index];
//                 return Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Container(
//                     decoration: BoxDecoration(
//                       color: Colors
//                           .white, // Add background color for better visibility
//                       borderRadius: BorderRadius.circular(10),
//                       border: Border.all(color: Colors.orange),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.grey.withOpacity(0.5),
//                           spreadRadius: 2,
//                           blurRadius: 5,
//                           offset: Offset(0, 3),
//                         ),
//                       ],
//                     ),
//                     child: ListTile(
//                       title: Text('Booking ID: ${refund['bookingId']}'),
//                       subtitle: Text(
//                         'User ID: ${refund['userId']}\n'
//                         'Refund Amount: \$${refund['refundAmount']}\n'
//                         'Status: ${refund['status']}\n'
//                         'Requested At: ${refund['requestedAt'].toDate()}',
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             ),
//     );
//   }
// }
import 'package:aventure/screens/user/notification.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RefundRequestList extends StatefulWidget {
  const RefundRequestList({super.key});

  @override
  State<RefundRequestList> createState() => _RefundRequestListState();
}

class _RefundRequestListState extends State<RefundRequestList> {
  bool _isLoading = true;
  List<Map<String, dynamic>> refundRequests = [];

  String? uid;

  @override
  void initState() {
    super.initState();
    fetchCurrentUser();
  }

  Future<void> fetchCurrentUser() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        uid = user.uid;
        await fetchRefundRequests();
      }
    } catch (e) {
      print("Error fetching current user: $e");
    }
  }

  Future<void> fetchRefundRequests() async {
    try {
      var refundDocs = await FirebaseFirestore.instance
          .collection('refund_requests')
          .where('eventManagerId', isEqualTo: uid)
          .get();

      setState(() {
        refundRequests = refundDocs.docs.map((doc) {
          var data = doc.data();
          data['id'] = doc.id; // Store document ID
          return data;
        }).toList();
        _isLoading = false;
      });
    } catch (e) {
      print("Error fetching refund requests: $e");
      setState(() {
        _isLoading = false;
      });
    }
  }

  void processRefundRequest(Map<String, dynamic> refund) async {
    try {
      String? userId = refund['userId'];
      double? refundAmount = refund['refundAmount'];
      String? refundId = refund['id']; // Get the document ID

      // Ensure none of these values are null
      if (userId == null || refundAmount == null || refundId == null) {
        throw Exception('Invalid refund data: $refund');
      }

      // Deduct the refund amount from the user's payments
      var paymentDocs = await FirebaseFirestore.instance
          .collection('payments')
          .where('userId', isEqualTo: userId)
          .get();

      for (var doc in paymentDocs.docs) {
        double currentAmount = doc['amountPaid'];
        double newAmount = currentAmount - refundAmount;

        await doc.reference.update({'amountPaid': newAmount});
      }
      // Update the refund request status to 'Processed'
      await FirebaseFirestore.instance
          .collection('refund_requests')
          .doc(refundId)
          .update({
        'status': 'Processed',
        'refundedAt': FieldValue.serverTimestamp(),
      });

      var updatedRefundDoc = await FirebaseFirestore.instance
          .collection('refund_requests')
          .doc(refundId)
          .get();

      var updatedRefund = updatedRefundDoc.data();
      if (updatedRefund == null) {
        throw Exception('Failed to fetch updated refund data');
      }

      // Navigate to the RefundedDetailsPage with refund details
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => RefundedDetailsPage(refund: updatedRefund),
        ),
      );

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Refund processed successfully.'),
      ));
    } catch (e) {
      print("Error processing refund request: $e");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to process refund request'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Refund Requests',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        actions: [
          // IconButton(
          //   onPressed: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //         builder: (context) => ProcessedRefundsPage(),
          //       ),
          //     );
          //   },
          //   icon: Icon(Icons.monitor),
          // )
        ],
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: refundRequests.length,
        itemBuilder: (context, index) {
          final refund = refundRequests[index];
          return GestureDetector(
            onTap: () => processRefundRequest(refund),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors
                      .white, // Add background color for better visibility
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.orange),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: ListTile(
                  title: Text('Booking ID: ${refund['bookingId']}'),
                  subtitle: Text(
                    'User ID: ${refund['userId']}\n'
                        'Refund Amount: \$${refund['refundAmount']}\n'
                        'Status: ${refund['status']}\n'
                        'Requested At: ${refund['requestedAt'].toDate()}',
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class RefundedDetailsPage extends StatelessWidget {
  final Map<String, dynamic> refund;

  const RefundedDetailsPage({super.key, required this.refund});

  @override
  Widget build(BuildContext context) {
    DateTime? refundedAt;
    if (refund['refundedAt'] != null) {
      refundedAt = (refund['refundedAt'] as Timestamp).toDate();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Refunded Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Booking ID: ${refund['bookingId']}'),
            SizedBox(height: 8),
            Text('User ID: ${refund['userId']}'),
            SizedBox(height: 8),
            Text('Refund Amount: \$${refund['refundAmount']}'),
            SizedBox(height: 8),
            Text('Status: ${refund['status']}'),
            SizedBox(height: 8),
            Text('Requested At: ${(refund['requestedAt'] as Timestamp).toDate()}'),
            SizedBox(height: 8),
            if (refundedAt != null) ...[
              Text('Refunded At: $refundedAt'),
              SizedBox(height: 16),
              Text(
                'Your refund of \$${refund['refundAmount']} has been processed on $refundedAt.',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ] else ...[
              Text('Refunded At: Not available'),
              SizedBox(height: 16),
              Text(
                'Your refund of \$${refund['refundAmount']} has been processed.',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class ProcessedRefundsPage extends StatefulWidget {
  @override
  _ProcessedRefundsPageState createState() => _ProcessedRefundsPageState();
}

class _ProcessedRefundsPageState extends State<ProcessedRefundsPage> {
  bool _isLoading = true;
  List<Map<String, dynamic>> processedRefunds = [];


  String? uid;

  @override
  void initState() {
    super.initState();
    fetchProcessedRefunds();
    fetchCurrentUser();
  }

  Future<void> fetchCurrentUser() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        uid = user.uid;
        await fetchProcessedRefunds();
      }
    } catch (e) {
      print("Error fetching current user: $e");
    }
  }
  Future<void> fetchProcessedRefunds() async {
    try {
      var refundDocs = await FirebaseFirestore.instance
          .collection('refund_requests')
          .where('eventManagerId', isEqualTo: uid)
          .get();
      setState(() {
        processedRefunds = refundDocs.docs.map((doc) {
          var data = doc.data();
          data['id'] = doc.id; // Store document ID
          return data;
        }).toList();
        _isLoading = false;
      });
    } catch (e) {
      print("Error fetching processed refunds: $e");
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Processed Refunds'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: processedRefunds.length,
        itemBuilder: (context, index) {
          final refund = processedRefunds[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors
                    .white, // Add background color for better visibility
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.orange),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: ListTile(
                title: Text('Booking ID: ${refund['bookingId']}'),
                subtitle: Text(
                  'User ID: ${refund['userId']}\n'
                      'Refund Amount: \$${refund['refundAmount']}\n'
                      'Status: ${refund['status']}\n'
                      'Requested At: ${refund['requestedAt'].toDate()}',
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
