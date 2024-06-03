import 'package:aventure/models/paymentmodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PaymentHistoryPage extends StatefulWidget {
  @override
  _PaymentHistoryPageState createState() => _PaymentHistoryPageState();
}

class _PaymentHistoryPageState extends State<PaymentHistoryPage> {

  var uid;
  @override
  void initState() {
    super.initState();
    getData();

  }

  getData() async {
    uid = FirebaseAuth.instance.currentUser!.uid;
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Payment History',style: TextStyle(color: Colors.white),),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('payments')
            .where('userId', isEqualTo: uid)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (snapshot.hasData && snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No payments found.'));
          }
          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data = document.data() as Map<String, dynamic>;
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.orange.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    title: Text('Amount: ${data['amountPaid']}'),
                    subtitle: Column(
                      children: [
                        Text('Date: ${data['dateTime']}'),
                      ],
                    ),
                    // Add more fields as needed
                  ),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
