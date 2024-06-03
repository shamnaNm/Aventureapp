import 'package:aventure/models/booking_model.dart';
import 'package:aventure/screens/event_manager/gen_tickets.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
class BookingsPage extends StatefulWidget {


  @override
  State<BookingsPage> createState() => _BookingsPageState();
}

class _BookingsPageState extends State<BookingsPage> {

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

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
    print(uid);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('user Bookings', style: TextStyle(color: Colors.white)),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('bookings').where('eventManagerId',isEqualTo:uid).where('status',isEqualTo:0).snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          } else {
            print("hello");
            final bookings = snapshot.data!.docs.map((doc) {
              print("helo");
              return BookingModel.fromJson(doc);
            }).toList();
            return ListView.builder(
              itemCount: bookings.length,
              itemBuilder: (context, index) {
                final booking = bookings[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.orange, // Choose your border color
                        width: 2.0, // Choose the width of the border
                      ),
                      borderRadius: BorderRadius.circular(
                          10.0), // Optional: Add border radius
                    ),
                    child: ListTile(
                      tileColor: Colors.orange.withOpacity(0.1),
                      title: Text(booking.title ?? ''),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('eventer:${booking.eventer}'),
                          Text('UserId: ${booking.userid}'),
                          Text('Category: ${booking.category}'),
                          Text(
                              'Date: ${booking.date?.toLocal().toString().split(
                                  ' ')[0]}'),
                          Text('Time: ${booking.time}'),
                          Text('Tickets: ${booking.tickets}'),
                          Text('EventManagerId: ${booking.eventManagerId}'),
                          Text('Paid: ₹${booking.amountPaid?.toStringAsFixed(
                              2)}'),
                        ],
                      ),
                      trailing: IconButton(onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>// GenerateTicket(),
                             GenerateTicket(
                            ticketNumber: booking.id ?? '',
                           eventer: booking.eventer ?? '',
                            activity: booking.title ?? '',
                            category: booking.category ?? '',
                            amountPaid: booking.amountPaid ?? 0.0,
                            numberOfTickets: booking.tickets ?? 0,
                            //dateTime: booking.date?.toDate() ?? DateTime.now(),
                             ),

                          ),
                        );
                      }, icon: Icon(Icons.sticky_note_2_outlined)),
                    ),
                  ),
                );
              },
            );
          }
        }
      ),
    );
  }
}