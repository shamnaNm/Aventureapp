
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class UserNotificationPage extends StatefulWidget {
  final Map<String, dynamic> refund;

  const UserNotificationPage({super.key, required this.refund});

  @override
  State<UserNotificationPage> createState() => _UserNotificationPageState();
}

class _UserNotificationPageState extends State<UserNotificationPage> {
  bool _isLoading = true;

  List<Map<String, dynamic>> processedRefunds = [];


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
          .where('status', isEqualTo: 'Processed').where('userId',isEqualTo: uid)
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
      backgroundColor: Colors.white ,
      appBar: AppBar(
        title: Text('Refunds',style: TextStyle(color: Colors.white),),
      ),
      body:_isLoading
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

                    'Refund Amount: \$${refund['refundAmount']}\n'
                        'Status: ${refund['status']}\n'

                ),
              ),
            ),
          );
        },
      ),
    );
  }
}