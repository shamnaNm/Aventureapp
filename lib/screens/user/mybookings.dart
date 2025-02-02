// import 'package:aventure/models/booking_model.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
//
// class MyBookingList extends StatefulWidget {
//   const MyBookingList({super.key});
//
//   @override
//   State<MyBookingList> createState() => _MyBookingListState();
// }
//
// class _MyBookingListState extends State<MyBookingList> {
//   String? uid;
//   bool _isLoading = true;
//   List<BookingModel> bookings = [];
//
//   @override
//   void initState() {
//     super.initState();
//     getData();
//   }
//
//   getData() async {
//     try {
//       uid = FirebaseAuth.instance.currentUser?.uid;
//       await fetchBookings();
//     } catch (e) {
//       print("Error getting user data: $e");
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }
//
//   Future<void> fetchBookings() async {
//     try {
//       if (uid != null) {
//         var bookingDocs = await FirebaseFirestore.instance
//             .collection('bookings')
//             .where('userid', isEqualTo: uid)
//             .get();
//         setState(() {
//           bookings = bookingDocs.docs
//               .map((doc) => BookingModel.fromJson(doc))
//               .toList();
//           _isLoading = false;
//         });
//       }
//     } catch (e) {
//       print("Error fetching bookings: $e");
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         title: Text(
//           'My Bookings',
//           style: TextStyle(
//             color: Colors.white,
//           ),
//         ),
//       ),
//       body: _isLoading
//           ? Center(child: CircularProgressIndicator())
//           : ListView.builder(
//               itemCount: bookings.length,
//               itemBuilder: (context, index) {
//                 final booking = bookings[index];
//                 return GestureDetector(
//                     onTap: () => showCancelDialog(context, booking),
//                     child: buildBookingItem(booking));
//               },
//             ),
//     );
//   }
//
//   Widget buildBookingItem(BookingModel booking) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Container(
//         decoration: BoxDecoration(
//           color: Colors.orange.withOpacity(0.1),
//           borderRadius: BorderRadius.circular(12),
//         ),
//         child: ListTile(
//           title: Text(booking.title ?? 'No title'),
//           subtitle: Text(
//             'Category: ${booking.category ?? 'No category'}\n'
//             'Date: ${booking.date?.toLocal() ?? 'No date'}\n'
//             'Amount Paid: \$${booking.amountPaid?.toStringAsFixed(2) ?? '0.00'}',
//           ),
//           trailing:
//               Text('Status: ${booking.status == 1 ? 'Confirmed' : 'Pending'}'),
//         ),
//       ),
//     );
//   }
//
//   void showCancelDialog(BuildContext context, BookingModel booking) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Cancel Booking'),
//           content: Text('Are you sure you want to cancel this booking?'),
//           actions: <Widget>[
//             TextButton(
//               child: Text('Exit'),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//             TextButton(
//               child: Text('Cancel'),
//               onPressed: () async {
//                 Navigator.of(context).pop();
//                // await cancelBooking(booking);
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   // Future<void> cancelBooking(BookingModel booking) async {
//   //   try {
//   //     await FirebaseFirestore.instance
//   //         .collection('bookings')
//   //         .doc(booking.id)
//   //         .update({'status': 0}); // Assuming 0 represents 'Cancelled'
//   //     setState(() {
//   //       booking.status = 0;
//   //     });
//   //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//   //       content: Text('Booking cancelled successfully'),
//   //     ));
//   //   } catch (e) {
//   //     print("Error cancelling booking: $e");
//   //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//   //       content: Text('Failed to cancel booking'),
//   //     ));
//   //   }
//   // }
// }
// import 'package:aventure/models/booking_model.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
//
// class MyBookingList extends StatefulWidget {
//   const MyBookingList({super.key});
//
//   @override
//   State<MyBookingList> createState() => _MyBookingListState();
// }
//
// class _MyBookingListState extends State<MyBookingList> {
//   String? uid;
//   bool _isLoading = true;
//   List<BookingModel> bookings = [];
//
//   @override
//   void initState() {
//     super.initState();
//     getData();
//   }
//
//   getData() async {
//     try {
//       uid = FirebaseAuth.instance.currentUser?.uid;
//       await fetchBookings();
//     } catch (e) {
//       print("Error getting user data: $e");
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }
//
//   Future<void> fetchBookings() async {
//     try {
//       if (uid != null) {
//         var bookingDocs = await FirebaseFirestore.instance
//             .collection('bookings')
//             .where('userid', isEqualTo: uid)
//             .get();
//         setState(() {
//           bookings = bookingDocs.docs
//               .map((doc) => BookingModel.fromJson(doc))
//               .toList();
//           _isLoading = false;
//         });
//       }
//     } catch (e) {
//       print("Error fetching bookings: $e");
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         title: Text(
//           'My Bookings',
//           style: TextStyle(
//             color: Colors.white,
//           ),
//         ),
//       ),
//       body: _isLoading
//           ? Center(child: CircularProgressIndicator())
//           : ListView.builder(
//         itemCount: bookings.length,
//         itemBuilder: (context, index) {
//           final booking = bookings[index];
//           return GestureDetector(
//               onTap: () => showCancelDialog(context, booking),
//               child: buildBookingItem(booking));
//         },
//       ),
//     );
//   }
//   Widget buildBookingItem(BookingModel booking) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Container(
//         decoration: BoxDecoration(
//           color: Colors.orange.withOpacity(0.1),
//           borderRadius: BorderRadius.circular(12),
//         ),
//         child: ListTile(
//           title: Text(booking.title ?? 'No title'),
//           subtitle: Text(
//             'Category: ${booking.category ?? 'No category'}\n'
//                 'Date: ${booking.date?.toLocal() ?? 'No date'}\n'
//                 'Amount Paid: \$${booking.amountPaid?.toStringAsFixed(2) ?? '0.00'}',
//           ),
//           trailing:
//           Text('Status: ${booking.status == 1 ? 'Confirmed' : 'Pending'}'),
//         ),
//       ),
//     );
//   }
//   void showCancelDialog(BuildContext context, BookingModel booking) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Cancel Booking'),
//           content: Text(
//               booking.status == 1
//                   ? 'This booking is confirmed and cannot be cancelled.'
//                   : 'Are you sure you want to cancel this booking? You will receive a 50% refund.'),
//           actions: <Widget>[
//             TextButton(
//               child: Text('Exit'),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//             if (booking.status == 0) // Only show the cancel button if status is pending
//               TextButton(
//                 child: Text('Cancel'),
//                 onPressed: () async {
//                   Navigator.of(context).pop();
//                   await cancelBooking(booking);
//                 },
//               ),
//           ],
//         );
//       },
//     );
//   }
//   Future<void> cancelBooking(BookingModel booking) async {
//     try {
//       double refundAmount = booking.amountPaid! * 0.5; // 50% refund
//       // Add refund logic here, e.g., update user's wallet or send refund request
//       await FirebaseFirestore.instance
//           .collection('bookings')
//           .doc(booking.id)
//           .update({'status': 0}); // Assuming 0 represents 'Cancelled'
//       setState(() {
//         booking.status = 0;
//       });
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         content: Text('Booking cancelled successfully. You will receive a 50% refund of \$${refundAmount.toStringAsFixed(2)}.'),
//       ));
//     } catch (e) {
//       print("Error cancelling booking: $e");
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         content: Text('Failed to cancel booking'),
//       ));
//     }
//   }
// }
import 'package:aventure/models/booking_model.dart';
import 'package:aventure/screens/event_manager/refundrequests.dart';
import 'package:aventure/screens/user/notification.dart';
import 'package:aventure/screens/user/refundusernoti.dart';
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
          bookings = bookingDocs.docs
              .map((doc) => BookingModel.fromJson(doc))
              .toList();
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
      appBar: AppBar(
        title: Text(
          'My Bookings',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(onPressed: (){Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => UserNotificationPage(refund: {},)),
          );}, icon: Icon(Icons.list))
        ],
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: bookings.length,
        itemBuilder: (context, index) {
          final booking = bookings[index];
          return GestureDetector(
              onTap: () => showCancelDialog(context, booking),
              child: buildBookingItem(booking));
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
                'Amount Paid: \$${booking.amountPaid?.toStringAsFixed(2) ?? '0.00'}\n'
              'No.of tickets:${booking.tickets?? 'no tickets'}\n'
              'payment Method:${booking.paymentMethod??'not available'}'
          ),
          trailing:
          Text('Status: ${booking.status == 1 ? 'Confirmed' : 'Pending'}'),
        ),
      ),
    );
  }

  void showCancelDialog(BuildContext context, BookingModel booking) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Cancel Booking'),
          content: Text(
              booking.status == 1
                  ? 'This booking is confirmed and cannot be cancelled.'
                  : 'Are you sure you want to cancel this booking? You will receive a 50% refund.'),
          actions: <Widget>[
            TextButton(
              child: Text('Exit'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            if (booking.status == 0) // Only show the cancel button if status is pending
              TextButton(
                child: Text('Cancel'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  await cancelBooking(booking);
                },
              ),
          ],
        );
      },
    );
  }

  Future<void> cancelBooking(BookingModel booking) async {
    try {
      double refundAmount = booking.amountPaid! * 0.5; // 50% refund
      await addRefundRequest(booking, refundAmount);

      await FirebaseFirestore.instance
          .collection('bookings')
          .doc(booking.id)
          .update({'status': 0}); // Assuming 0 represents 'Cancelled'
      setState(() {
        booking.status = 0;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Booking cancelled successfully. You will receive a 50% refund of \$${refundAmount.toStringAsFixed(2)}.'),
      ));
    } catch (e) {
      print("Error cancelling booking: $e");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to cancel booking'),
      ));
    }
  }

  Future<void> addRefundRequest(BookingModel booking, double refundAmount) async {
    try {
      await FirebaseFirestore.instance.collection('refund_requests').add({
        'bookingId': booking.id,
        'userId': booking.userid,
        'eventManagerId':booking.eventManagerId,
        'refundAmount': refundAmount,
        'status': 'Pending',
        'requestedAt': Timestamp.now(),
      });
    } catch (e) {
      print("Error adding refund request: $e");
    }
  }

}
