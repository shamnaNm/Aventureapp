
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class CombinedPage extends StatefulWidget {
  @override
  _CombinedPageState createState() => _CombinedPageState();
}

class _CombinedPageState extends State<CombinedPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String? uid;
  bool _isLoading = true;
  List<Map<String, dynamic>> processedRefunds = [];
  List<Map<String, dynamic>> createdActivities = [];

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
        await fetchCreatedActivities();
      }
    } catch (e) {
      print("Error fetching current user: $e");
    }
  }

  Future<void> fetchProcessedRefunds() async {
    try {
      var refundDocs = await _firestore
          .collection('refund_requests')
          .where('status', isEqualTo: 'Processed')
          .where('userId', isEqualTo: uid)
          .get();
      setState(() {
        processedRefunds = refundDocs.docs.map((doc) {
          var data = doc.data();
          data['id'] = doc.id; // Store document ID
          return data;
        }).toList();
      });
    } catch (e) {
      print("Error fetching processed refunds: $e");
    }
  }

  Future<void> fetchCreatedActivities() async {
    try {
      QuerySnapshot querySnapshot = await _firestore.collection('activities').get();
      setState(() {
        createdActivities = querySnapshot.docs.map((doc) {
          var data = doc.data() as Map<String, dynamic>;
          data['id'] = doc.id; // Store document ID
          return data;
        }).toList();
        _isLoading = false;
      });
    } catch (e) {
      print('Error fetching activities: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Notifications', style: TextStyle(color: Colors.white)),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        child: Column(
          children: [

            processedRefunds.isEmpty
                ? Center(child: Text('No processed refunds found'))
                : ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: processedRefunds.length,
              itemBuilder: (context, index) {
                final refund = processedRefunds[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
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
                            'Status: ${refund['status']}',
                      ),
                    ),
                  ),
                );
              },
            ),

            createdActivities.isEmpty
                ? Center(child: Text('No activities found'))
                : ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: createdActivities.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration:BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(strokeAlign: BorderSide.strokeAlignOutside) ),
                    child: ListTile(
                      title: Text('New Activity available for now on!'),
                      subtitle: Column(
                        children: [
                          Text(createdActivities[index]['title']),
                          Text(createdActivities[index]['location']),
                        ],
                      ),
                      onTap: () {
                        // Navigate to the activity details page if needed
                      },
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
 }