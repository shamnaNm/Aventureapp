
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class UserHistoryPage extends StatefulWidget {
  final String userId;

  const UserHistoryPage({Key? key, required this.userId}) : super(key: key);

  @override
  _UserHistoryPageState createState() => _UserHistoryPageState();
}

class _UserHistoryPageState extends State<UserHistoryPage> {
  List<dynamic> bookings = [];
  List<dynamic> payments = [];
  List<dynamic> refundRequests = [];
  List<dynamic> reviews = [];
  bool _isLoading = true;
  bool _hasError = false;
 String? uid;
  @override
  void initState() {
    super.initState();

    getData();
  }
  getData() async {
    try {
      uid = FirebaseAuth.instance.currentUser?.uid;
      await fetchUserHistory();
    } catch (e) {
      print("Error getting user data: $e");
      setState(() {
        _isLoading = false;
      });
    }
  }
  Future<void> fetchUserHistory() async {
    try {
      // Fetch all bookings
      var bookingDocs = await FirebaseFirestore.instance
          .collection('bookings').where('userid',isEqualTo: uid)
          .get();
      bookings = bookingDocs.docs.map((doc) => doc.data()).toList();
      print('Bookings: $bookings');

      // Fetch all payments
      var paymentDocs = await FirebaseFirestore.instance
          .collection('payments')
          .where('userId',isEqualTo: uid)
          .get();
      payments = paymentDocs.docs.map((doc) => doc.data()).toList();
      print('Payments: $payments');

      // Fetch all refund requests
      var refundDocs = await FirebaseFirestore.instance
          .collection('refund_requests')
          .where('userId',isEqualTo: uid)
          .get();
      refundRequests = refundDocs.docs.map((doc) => doc.data()).toList();
      print('Refund Requests: $refundRequests');

      // Fetch all reviews
      var reviewDocs = await FirebaseFirestore.instance
          .collection('reviews')
          .where('uid',isEqualTo: uid)
          .get();
      reviews = reviewDocs.docs.map((doc) => doc.data()).toList();
      print('Reviews: $reviews');

      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      print("Error fetching user history: $e");
      setState(() {
        _isLoading = false;
        _hasError = true;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange[100],
        title: Text('History'),
      ),
      backgroundColor:Colors.white,
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _hasError
          ? Center(child: Text('Error fetching data'))
          : SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Bookings',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: bookings.length,
                itemBuilder: (context, index) {
                  final booking = bookings[index];
                  return buildBookingItem(booking);
                },
              ),
              SizedBox(height: 20),
              Text(
                'Payments',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: payments.length,
                itemBuilder: (context, index) {
                  final payment = payments[index];
                  return buildPaymentItem(payment);
                },
              ),
              SizedBox(height: 20),
              Text(
                'Refund Requests',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: refundRequests.length,
                itemBuilder: (context, index) {
                  final refundRequest = refundRequests[index];
                  return buildRefundRequestItem(refundRequest);
                },
              ),
              SizedBox(height: 20),
              Text(
                'Reviews',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: reviews.length,
                itemBuilder: (context, index) {
                  final review = reviews[index];
                  return buildReviewItem(review);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildBookingItem(dynamic booking) {
    return ListTile(
      title: Text(booking['title'] ?? 'No Title'),
      subtitle: Text('Amount Paid: ${booking['amountPaid'] ?? 'N/A'}'),
    );
  }

  Widget buildPaymentItem(dynamic payment) {
    // return ListTile(
    //   title: Text('Date: ${payment['dateTime'] ?? 'N/A'}'),
    DateTime dateTime = (payment['dateTime'] as Timestamp).toDate();
    String formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(dateTime);

    return ListTile(
      title: Text('Date and time: $formattedDate'),
      subtitle: Text('Amount Paid: ${payment['amountPaid'] ?? 'N/A'}'),
    );
  }

  Widget buildRefundRequestItem(dynamic refundRequest) {
    return ListTile(
      title: Text('Refund Amount: ${refundRequest['refundAmount'] ?? 'N/A'}'),
      subtitle: Text('Status: ${refundRequest['status'] ?? 'N/A'}'),
    );
  }

  Widget buildReviewItem(dynamic review) {
    return ListTile(
      title: Text(review['activityTitle'] ?? 'No Title'),
      subtitle: Text(review['reviewText'] ?? 'No Review Text'),
    );
  }
}
