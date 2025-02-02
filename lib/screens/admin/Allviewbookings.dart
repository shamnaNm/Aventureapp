import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AllBookingListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text('Bookings',style: TextStyle(color: Colors.white),),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('bookings').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No bookings found'));
          }

          final bookings = snapshot.data!.docs;

          return ListView.builder(
            itemCount: bookings.length,
            itemBuilder: (context, index) {
              final booking = bookings[index].data() as Map<String, dynamic>;
              final bookingId = bookings[index].id;
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.orange)
                  ),
                  child: ListTile(
                    title: Text('Booking ID: $bookingId'),
                    subtitle: Text('Eventer: ${booking['eventer']}'),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => BookingDetailPage(booking: booking, bookingId: bookingId,),
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
class BookingDetailPage extends StatelessWidget {
  final Map<String, dynamic> booking;
  final String bookingId;
  BookingDetailPage({required this.booking,required this.bookingId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text('Booking Details',style: TextStyle(color: Colors.white),),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text('Booking ID:  $bookingId'),
            Text('Activity ID: ${booking['activityId']}'),
            Text('Title: ${booking['title']}'),
            Text('Category: ${booking['category']}'),
            Text('Date: ${booking['date'].toDate()}'),
            Text('Time: ${booking['time']}'),
            Text('Amount Paid: ₹${booking['amountPaid']}'),
            Text('Number of Tickets: ${booking['tickets']}'),
            Text('Event Manager ID: ${booking['eventManagerId']}'),
            Text('Eventer: ${booking['eventer']}'),
            Text('User ID: ${booking['userid']}'),
            Text('Status: ${booking['status']}'),
            Text('Payment mode: ${booking['paymentMethod']}'),

          ],
        ),
      ),
    );
  }
}
