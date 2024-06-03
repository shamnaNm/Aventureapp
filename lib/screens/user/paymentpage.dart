import 'package:aventure/models/activity_model.dart';
import 'package:aventure/models/user_model.dart';
import 'package:aventure/screens/user/paymentsuccess.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PaymentPage extends StatefulWidget {

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
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
    final Map<String, dynamic> args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final ActivityModel activity = args['activity'];
    final DateTime? selectedDate = args['selectedDate'];
    final String? selectedTime = args['selectedTime'];
    final int ticketsSelected = args['ticketsSelected'];
    final double totalAmount = args['totalAmount'];
    final Map<String, dynamic> medicalInfo = args['medicalInfo'];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Payment', style: TextStyle(color: Colors.white)),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text(
              activity.title!,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              'Category: ${activity.category}',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'Eventer: ${activity.eventer} Eventers',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'Date: ${selectedDate?.toLocal().toString().split(' ')[0]}',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'Time: $selectedTime',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'Tickets: $ticketsSelected',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'Total: ₹${totalAmount.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            Text(
              'Medical Information',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            Text(
              'Blood Pressure: ${medicalInfo['bpRate']}',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'Glucose Rate: ${medicalInfo['glucoseRate']}',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'Allergies: ${medicalInfo['allergies']}',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'Other Diseases: ${medicalInfo['otherDiseases']}',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'Heart Problem: ${medicalInfo['hasHeartProblem'] ? 'Yes' : 'No'}',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'Disabilities: ${medicalInfo['hasDisability'] ? 'Yes' : 'No'}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SuccessPage(
                      totalAmount: totalAmount,
                      bookingDetails: {
                        'userid':uid,
                        'eventer':activity.eventer,
                        'activityId': activity.id,
                        'title': activity.title,
                        'category': activity.category,
                        'eventManagerId': activity.eventManagerId, // Include the event manager's ID
                        'date': selectedDate,
                        'time': selectedTime,
                        'tickets': ticketsSelected,
                        'status':0
                      },
                    ),
                  ),
                );
              },
              child: Text('Proceed to Payment'),
            ),
          ],
        ),
      ),
    );
  }
}
