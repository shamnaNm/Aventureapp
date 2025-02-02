// import 'package:aventure/models/paymentmodel.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:fl_chart/fl_chart.dart';
// import 'package:intl/intl.dart';
//
// class PaymentHistory extends StatefulWidget {
//   @override
//   _PaymentHistoryState createState() => _PaymentHistoryState();
// }
// Future<List<PaymentModel>> fetchPayments() async {
//   QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('payments').get();
//   return snapshot.docs.map((doc) => PaymentModel.fromDocument(doc)).toList();
// }
// Future<Map<String, dynamic>> getPaymentsSummary() async {
//   List<PaymentModel> payments = await fetchPayments();
//   double totalAmount = payments.fold(0, (sum, item) => sum + item.amountPaid);
//   int count = payments.length;
//
//   // Aggregate payment counts by day of the month
//   Map<int, int> paymentsPerDay = {};
//   for (var payment in payments) {
//     int day = payment.dateTime.day;
//     if (paymentsPerDay.containsKey(day)) {
//       paymentsPerDay[day] = paymentsPerDay[day]! + 1;
//     } else {
//       paymentsPerDay[day] = 1;
//     }
//   }
//
//   return {'totalAmount': totalAmount, 'count': count, 'paymentsPerDay': paymentsPerDay};
// }
// class _PaymentHistoryState extends State<PaymentHistory> {
//   late Future<Map<String, dynamic>> summary;
//
//   @override
//   void initState() {
//     super.initState();
//     summary = getPaymentsSummary();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return
//       Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar( ),
//       body:
//       FutureBuilder<Map<String, dynamic>>(
//         future: summary,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else if (!snapshot.hasData) {
//             return Center(child: Text('No data available'));
//           } else {
//             var data = snapshot.data!;
//             Map<int, int> paymentsPerDay = data['paymentsPerDay'] ?? {};
//             return Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 SizedBox(height: 20),
//                 Text('Total Amount Paid: \$${data['totalAmount']}'),
//                 Text('Total Payments: ${data['count']}'),
//                 SizedBox(height: 20),
//                 Expanded(
//                   child: PaymentChart(paymentsPerDay: paymentsPerDay),
//                 ),
//               ],
//             );
//           }
//         },
//       ),
//     );
//   }
// }
// class PaymentChart extends StatelessWidget {
//   final Map<int, int> paymentsPerDay;
//
//   PaymentChart({required this.paymentsPerDay});
//   @override
//   Widget build(BuildContext context) {
//     List<BarChartGroupData> barGroups = [];
//     paymentsPerDay.forEach((day, count) {
//       barGroups.add(
//         BarChartGroupData(
//           x: day,
//           barRods: [
//             BarChartRodData(
//               toY: count.toDouble(),
//               colors: [Colors.lightBlueAccent, Colors.greenAccent],
//             ),
//           ],
//         ),
//       );
//     });
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: BarChart(
//         BarChartData(
//           alignment: BarChartAlignment.spaceAround,
//           maxY: (paymentsPerDay.values.isNotEmpty
//               ? paymentsPerDay.values.reduce((a, b) => a > b ? a : b)
//               : 0) +
//               5,
//           barTouchData: BarTouchData(enabled: false),
//           titlesData: FlTitlesData(
//             show: true,
//             bottomTitles: SideTitles(
//               showTitles: true,
//               getTextStyles: (context, value) => const TextStyle(
//                   color: Colors.black, fontWeight: FontWeight.bold, fontSize: 14),
//               margin: 16,
//               getTitles: (double value) {
//                 return value.toInt().toString();
//               },
//             ),
//             leftTitles: SideTitles(showTitles: true),
//           ),
//           borderData: FlBorderData(
//             show: false,
//           ),
//           barGroups: barGroups,
//         ),
//       ),
//     );
//   }
// }