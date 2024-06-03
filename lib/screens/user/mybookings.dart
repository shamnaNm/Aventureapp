import 'package:aventure/models/booking_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class MyBookingList extends StatefulWidget {
  const MyBookingList({super.key});

  @override
  State<MyBookingList> createState() => _MyBookingListState();
}

class _MyBookingListState extends State<MyBookingList> {
  String? uid;
  bool _isLoading = true;
  List<BookingModel> bookings = [];

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    try {
      uid = FirebaseAuth.instance.currentUser?.uid;
      await fetchBookings();
    } catch (e) {
      print("Error getting user data: $e");
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> fetchBookings() async {
    try {
      if (uid != null) {
        var bookingDocs = await FirebaseFirestore.instance
            .collection('bookings')
            .where('userid', isEqualTo: uid)
            .get();
        setState(() {
          bookings = bookingDocs.docs.map((doc) => BookingModel.fromJson(doc)).toList();
          _isLoading = false;
        });
      }
    } catch (e) {
      print("Error fetching bookings: $e");
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(  title: Text('My Bookings',style: TextStyle(color:Colors.white, ),),),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: bookings.length,
        itemBuilder: (context, index) {
          final booking = bookings[index];
          return buildBookingItem(booking);
        },
      ),
    );
  }
  Widget buildBookingItem(BookingModel booking) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.orange.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: ListTile(
          title: Text(booking.title ?? 'No title'),
          subtitle: Text(
            'Category: ${booking.category ?? 'No category'}\n'
                'Date: ${booking.date?.toLocal() ?? 'No date'}\n'
                'Amount Paid: \$${booking.amountPaid?.toStringAsFixed(2) ?? '0.00'}',
          ),
          trailing: Text('Status: ${booking.status == 1 ? 'Confirmed' : 'Pending'}'),
        ),
      ),
    );
  }
}
