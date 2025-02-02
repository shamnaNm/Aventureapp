// import 'package:flutter/material.dart';
// class TicketDetailsPage extends StatelessWidget {
//   final String ticketNumber;
//   final String eventer;
//   final String activity;
//   final String category;
//   final double amountPaid;
//   final int numberOfTickets;
//   final String time;
//
//   TicketDetailsPage({
//     required this.ticketNumber,
//     required this.eventer,
//     required this.activity,
//     required this.category,
//     required this.amountPaid,
//     required this.numberOfTickets,
//     required this.time
//
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Ticket Details',style:TextStyle(color: Colors.white),),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text('Ticket Number: $ticketNumber', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//             SizedBox(height: 8),
//             Text('Eventer: $eventer', style: TextStyle(fontSize: 16)),
//             SizedBox(height: 8),
//             Text('Activity: $activity', style: TextStyle(fontSize: 16)),
//             SizedBox(height: 8),
//             Text('Category: $category', style: TextStyle(fontSize: 16)),
//             SizedBox(height: 8),
//             Text('Amount Paid: Rs. ${amountPaid.toStringAsFixed(2)}', style: TextStyle(fontSize: 16)),
//             SizedBox(height: 8),
//             Text('Number of Tickets: $numberOfTickets', style: TextStyle(fontSize: 16)),
//             SizedBox(height: 16),
//             Text('Amount Paid: Rs. ${amountPaid.toStringAsFixed(2)}', style: TextStyle(fontSize: 16)),
//             SizedBox(height: 8),
//             Text('Number of Tickets: $numberOfTickets', style: TextStyle(fontSize: 16)),
//             SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: () {
//                 // Add any actions you want to perform on button press
//               },
//               child: Text('Download Ticket PDF'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
