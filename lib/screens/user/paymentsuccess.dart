//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// //
// // class SuccessPage extends StatefulWidget {
// //   final double totalAmount;
// //   final Map<String, dynamic> bookingDetails;
// //
// //   const SuccessPage({Key? key, required this.totalAmount, required this.bookingDetails}) : super(key: key);
// //
// //   @override
// //   _SuccessPageState createState() => _SuccessPageState();
// // }
// //
// // class _SuccessPageState extends State<SuccessPage> {
// //   bool _isProcessingPayment = false;
// //   double _amount = 0.0;
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: Colors.white,
// //       appBar: AppBar(
// //         title: Text('Payment', style: TextStyle(color: Colors.white)),
// //       ),
// //       body: Padding(
// //         padding: EdgeInsets.all(16.0),
// //         child: _isProcessingPayment
// //             ? Center(
// //           child: Column(
// //             mainAxisAlignment: MainAxisAlignment.center,
// //             children: [
// //               CircularProgressIndicator(),
// //               SizedBox(height: 16.0),
// //               Text('Processing Payment...'),
// //             ],
// //           ),
// //         )
// //             : Column(
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           children: [
// //             Text(
// //               'Select Payment Method:',
// //               style: TextStyle(
// //                 fontSize: 20,
// //                 fontWeight: FontWeight.bold,
// //               ),
// //             ),
// //             SizedBox(height: 16.0),
// //             Row(
// //               children: [
// //                 Radio(
// //                   value: false,
// //                   groupValue: _isProcessingPayment,
// //                   onChanged: (value) {},
// //                 ),
// //                 Text('Liquid Payment'),
// //               ],
// //             ),
// //             Row(
// //               children: [
// //                 Radio(
// //                   value: true,
// //                   groupValue: _isProcessingPayment,
// //                   onChanged: (value) {
// //                     setState(() {
// //                       _isProcessingPayment = value as bool;
// //                       if (_isProcessingPayment) {
// //                         // Prompt the user to enter the amount
// //                         _showEnterAmountDialog();
// //                       }
// //                     });
// //                   },
// //                 ),
// //                 Text('Online Payment'),
// //               ],
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// //   void _showEnterAmountDialog() {
// //     showDialog(
// //       context: context,
// //       builder: (BuildContext context) {
// //         return AlertDialog(
// //           title: Text(' Enter amount ${widget.totalAmount}'),
// //           content: TextField(
// //             decoration: InputDecoration(
// //               labelText: 'Amount',
// //               hintText: 'Enter amount',
// //               prefixIcon: Icon(Icons.currency_rupee_outlined),
// //             ),
// //             keyboardType: TextInputType.number,
// //             onChanged: (value) {
// //               setState(() {
// //                 _amount = double.tryParse(value) ?? 0.0;
// //               });
// //             },
// //           ),
// //           actions: <Widget>[
// //             TextButton(
// //               onPressed: () {
// //                 Navigator.of(context).pop();
// //                 _processPayment();
// //               },
// //               child: Text('Proceed'),
// //             ),
// //           ],
// //         );
// //       },
// //     );
// //   }
// //
// //   void _processPayment() {
// //     setState(() {
// //       _isProcessingPayment = true;
// //     });
// //
// //     // Simulating payment processing
// //     Future.delayed(Duration(seconds: 3), () async {
// //       setState(() {
// //         _isProcessingPayment = false;
// //       });
// //
// //       // Save booking details to Firestore
// //       await _saveBookingDetails();
// //
// //       // Navigate to payment success page or show a success message
// //       _showPaymentSuccessDialog();
// //     });
// //   }
// //   Future<void> _saveBookingDetails() async {
// //     final bookingDetails = widget.bookingDetails;
// //     bookingDetails['amountPaid'] = widget.totalAmount;
// //
// //     await FirebaseFirestore.instance.collection('bookings').add(bookingDetails);
// //   }
// //   void _showPaymentSuccessDialog() {
// //     showDialog(
// //       context: context,
// //       builder: (BuildContext context) {
// //         return AlertDialog(
// //           title: Text('Payment Successful'),
// //           content: Text('Your payment of Rs. ${widget.totalAmount} was processed successfully.'),
// //           actions: <Widget>[
// //             TextButton(
// //               onPressed: () {
// //                 Navigator.of(context).pop();
// //               },
// //               child: Text('OK'),
// //             ),
// //           ],
// //         );
// //       },
// //     );
// //   }
// // }
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
//
// class SuccessPage extends StatefulWidget {
//   final double totalAmount;
//   final Map<String, dynamic> bookingDetails;
//
//   const SuccessPage({Key? key, required this.totalAmount, required this.bookingDetails}) : super(key: key);
//
//   @override
//   _SuccessPageState createState() => _SuccessPageState();
// }
// class _SuccessPageState extends State<SuccessPage> {
//
//   var uid;
//
//   @override
//   void initState() {
//     super.initState();
//     getData();
//   }
//
//   getData() async {
//     uid = FirebaseAuth.instance.currentUser!.uid;
//     setState(() {});
//   }
//   bool _isProcessingPayment = false;
//   double _amount = 0.0;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         title: Text('Payment', style: TextStyle(color: Colors.white)),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: _isProcessingPayment
//             ? Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               CircularProgressIndicator(),
//               SizedBox(height: 16.0),
//               Text('Processing Payment...'),
//             ],
//           ),
//         )
//             : Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Select Payment Method:',
//               style: TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             SizedBox(height: 16.0),
//             Row(
//               children: [
//                 Radio(
//                   value: false,
//                   groupValue: _isProcessingPayment,
//                   onChanged: (value) {},
//                 ),
//                 Text('Liquid Payment'),
//               ],
//             ),
//             Row(
//               children: [
//                 Radio(
//                   value: true,
//                   groupValue: _isProcessingPayment,
//                   onChanged: (value) {
//                     setState(() {
//                       _isProcessingPayment = value as bool;
//                       if (_isProcessingPayment) {
//                         // Prompt the user to enter the amount
//                         _showEnterAmountDialog();
//                       }
//                     });
//                   },
//                 ),
//                 Text('Online Payment'),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//   void _showEnterAmountDialog() {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Enter amount ${widget.totalAmount}'),
//           content: TextField(
//             decoration: InputDecoration(
//               labelText: 'Amount',
//               hintText: 'Enter amount',
//               prefixIcon: Icon(Icons.currency_rupee_outlined),
//             ),
//             keyboardType: TextInputType.number,
//             onChanged: (value) {
//               setState(() {
//                 _amount = double.tryParse(value) ?? 0.0;
//               });
//             },
//           ),
//           actions: <Widget>[
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//                 _processPayment();
//               },
//               child: Text('Proceed'),
//             ),
//           ],
//         );
//       },
//     );
//   }
//   void _processPayment() {
//     setState(() {
//       _isProcessingPayment = true;
//     });
//
//     // Simulating payment processing
//     Future.delayed(Duration(seconds: 3), () async {
//       setState(() {
//         _isProcessingPayment = false;
//       });
//
//       // Save booking and payment details to Firestore
//       await _saveBookingDetails();
//       await _savePaymentDetails();
//
//       // Navigate to payment success page or show a success message
//       _showPaymentSuccessDialog();
//     });
//   }
//
//   Future<void> _saveBookingDetails() async {
//     final bookingDetails = widget.bookingDetails;
//     bookingDetails['amountPaid'] = widget.totalAmount;
//
//     await FirebaseFirestore.instance.collection('bookings').add(bookingDetails);
//   }
//
//   Future<void> _savePaymentDetails() async {
//     final paymentDetails = {
//       'activityId': widget.bookingDetails['activityId'],
//       'eventManagerId': widget.bookingDetails['eventManagerId'],
//       'userId': FirebaseAuth.instance.currentUser!.uid,
//       'amountPaid': _amount,
//       'dateTime': DateTime.now(),
//     };
//     await FirebaseFirestore.instance.collection('payments').add(paymentDetails);
//   }
//   void _showPaymentSuccessDialog() {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Payment Successful'),
//           content: Text('Your payment of Rs. ${widget.totalAmount} was processed successfully.'),
//           actions: <Widget>[
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: Text('OK'),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SuccessPage extends StatefulWidget {
  final double totalAmount;
  final Map<String, dynamic> bookingDetails;

  const SuccessPage({Key? key, required this.totalAmount, required this.bookingDetails}) : super(key: key);

  @override
  _SuccessPageState createState() => _SuccessPageState();
}

class _SuccessPageState extends State<SuccessPage> {
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

  bool _isProcessingOnlinePayment = false;
  bool _isProcessingLiquidPayment = false;
  double _amount = 0.0;
  String _selectedPaymentMethod = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Payment', style: TextStyle(color: Colors.white)),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: _isProcessingOnlinePayment || _isProcessingLiquidPayment
            ? Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 16.0),
              Text('Processing Payment...'),
            ],
          ),
        )
            : Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select Payment Method:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            Row(
              children: [
                Radio(
                  value: 'Liquid Payment',
                  groupValue: _selectedPaymentMethod,
                  onChanged: (value) {
                    setState(() {
                      _selectedPaymentMethod = value.toString();
                    });
                  },
                ),
                Text('Liquid Payment'),
              ],
            ),
            Row(
              children: [
                Radio(
                  value: 'Online Payment',
                  groupValue: _selectedPaymentMethod,
                  onChanged: (value) {
                    setState(() {
                      _selectedPaymentMethod = value.toString();
                    });
                  },
                ),
                Text('Online Payment'),
              ],
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _selectedPaymentMethod.isEmpty
                  ? null
                  : () {
                if (_selectedPaymentMethod == 'Liquid Payment') {
                  _processLiquidBooking();
                } else if (_selectedPaymentMethod == 'Online Payment') {
                  _showEnterAmountDialog();
                }
              },
              child: Text('Proceed with $_selectedPaymentMethod'),
            ),
          ],
        ),
      ),
    );
  }

  void _showEnterAmountDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Enter amount ${widget.totalAmount}'),
          content: TextField(
            decoration: InputDecoration(
              labelText: 'Amount',
              hintText: 'Enter amount',
              prefixIcon: Icon(Icons.currency_rupee_outlined),
            ),
            keyboardType: TextInputType.number,
            onChanged: (value) {
              setState(() {
                _amount = double.tryParse(value) ?? 0.0;
              });
            },
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _processPayment();
              },
              child: Text('Proceed'),
            ),
          ],
        );
      },
    );
  }

  void _processPayment() {
    setState(() {
      _isProcessingOnlinePayment = true;
    });

    // Simulating payment processing
    Future.delayed(Duration(seconds: 3), () async {
      setState(() {
        _isProcessingOnlinePayment = false;
      });

      // Save booking and payment details to Firestore
      await _saveBookingDetails(_amount, 'Online Payment');
      await _savePaymentDetails(_amount);

      // Navigate to payment success page or show a success message
      _showPaymentSuccessDialog(_amount);
    });
  }

  Future<void> _saveBookingDetails(double amount, String paymentMethod) async {
    final bookingDetails = widget.bookingDetails;
    bookingDetails['amountPaid'] = amount;
    bookingDetails['paymentMethod'] = paymentMethod;

    await FirebaseFirestore.instance.collection('bookings').add(bookingDetails);
  }

  Future<void> _savePaymentDetails(double amount) async {
    final paymentDetails = {
      'activityId': widget.bookingDetails['activityId'],
      'eventManagerId': widget.bookingDetails['eventManagerId'],
      'userId': FirebaseAuth.instance.currentUser!.uid,
      'amountPaid': amount,
      'dateTime': DateTime.now(),
      'paymentMethod': 'Online Payment',
    };
    await FirebaseFirestore.instance.collection('payments').add(paymentDetails);
  }

  void _processLiquidBooking() async {
    setState(() {
      _isProcessingLiquidPayment = true;
    });

    // Simulating booking processing
    Future.delayed(Duration(seconds: 3), () async {
      setState(() {
        _isProcessingLiquidPayment = false;
      });

      // Save booking details to Firestore
      await _saveBookingDetails(0.0, 'Liquid Payment');

      // Show success message
      _showLiquidBookingSuccessDialog();
    });
  }

  void _showLiquidBookingSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Booking Successful'),
          content: Text('Your booking was processed successfully. Please pay the amount in person.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _showPaymentSuccessDialog(double amount) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Payment Successful'),
          content: Text('Your payment of Rs. $amount was processed successfully.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
