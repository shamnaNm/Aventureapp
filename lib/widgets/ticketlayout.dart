import 'package:flutter/material.dart';
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
    return Container(
      margin: EdgeInsets.all(16.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10.0,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Ticket Number: $ticketNumber', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 8.0),
          Text('Eventer: $eventer', style: TextStyle(fontSize: 16)),
          SizedBox(height: 8.0),
          Text('Activity: $activity', style: TextStyle(fontSize: 16)),
          SizedBox(height: 8.0),
          Text('Category: $category', style: TextStyle(fontSize: 16)),
          SizedBox(height: 8.0),
          Text('Amount Paid: ₹Rs. ${amountPaid.toStringAsFixed(2).toString()}', style: TextStyle(fontSize: 16)),
          SizedBox(height: 8.0),
          Text('Number of Tickets: $numberOfTickets', style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}
