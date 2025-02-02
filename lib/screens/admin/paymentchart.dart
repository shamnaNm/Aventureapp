import 'package:aventure/models/paymentmodel.dart';
import 'package:aventure/screens/admin/paymentdetail.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class PaymentListScreen extends StatefulWidget {
  @override
  State<PaymentListScreen> createState() => _PaymentListScreenState();
}
class _PaymentListScreenState extends State<PaymentListScreen> {
  final PaymentService paymentService = PaymentService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('All Payments',style: TextStyle(color: Colors.orange),),
        // actions: [
        //   IconButton(onPressed: (){
        //     Navigator.of(context).push(
        //         MaterialPageRoute(
        //         builder: (_) =>PaymentHistory()
        //         ) );
        //   }, icon: Icon(Icons.bar_chart,color: Colors.orange,)),
        // ],
      ),
      body: FutureBuilder<List<PaymentModel>>(
        future: paymentService.fetchAllPayments(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No payments found.'));
          } else {
            final payments = snapshot.data!;
            return ListView.builder(
              itemCount: payments.length,
              itemBuilder: (context, index) {
                final payment = payments[index];
                return Padding(
                    padding: const EdgeInsets.all(8.0),
                child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.white)
                ),
                  child: ListTile(
                    title: Text('Activity ID: ${payment.activityId}'),
                    subtitle: Text(
                      'Amount Paid: \$${payment.amountPaid}\nDate: ${payment.dateTime}\nEvent Manager ID: ${payment.eventManagerId}\nUser ID: ${payment.userId}',
                    ),
                  ),
                ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
class PaymentService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<List<PaymentModel>> fetchAllPayments() async {
    QuerySnapshot snapshot = await _firestore.collection('payments').get();
    return snapshot.docs.map((doc) => PaymentModel.fromDocument(doc)).toList();
  }
}
