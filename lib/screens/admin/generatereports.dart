
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class GenerateReports extends StatefulWidget {
  const GenerateReports({super.key});

  @override
  State<GenerateReports> createState() => _GenerateReportsState();
}

class _GenerateReportsState extends State<GenerateReports> {
  int totalBookings = 0;
  double totalPayments = 0.0;
  String selectedMonth = DateFormat('MMMM').format(DateTime.now());
  String selectedYear = DateFormat('yyyy').format(DateTime.now());

  @override
  void initState() {
    super.initState();
    _fetchData(selectedMonth, selectedYear);
  }

  Future<void> _fetchData(String month, String year) async {
    DateTime now = DateTime.now();
    int monthNumber = DateFormat('MMMM').parse(month).month;

    QuerySnapshot bookingSnapshot = await FirebaseFirestore.instance
        .collection('bookings')
        .where('date', isGreaterThanOrEqualTo: DateTime(int.parse(year), monthNumber, 1))
        .where('date', isLessThan: DateTime(int.parse(year), monthNumber + 1, 1))
        .get();

    QuerySnapshot paymentSnapshot = await FirebaseFirestore.instance
        .collection('payments')
        .where('date', isGreaterThanOrEqualTo: DateTime(int.parse(year), monthNumber, 1))
        .where('date', isLessThan: DateTime(int.parse(year), monthNumber + 1, 1))
        .get();

    int bookings = bookingSnapshot.docs.length;
    double payments = 0.0;

    for (var doc in bookingSnapshot.docs) {
      payments += (doc.data() as Map<String, dynamic>)['amountPaid'] ?? 0;
    }

    setState(() {
      totalBookings = bookings;
      totalPayments = payments;
    });
  }

  Future<void> _generateMonthlyReport() async {
    try {
      DateTime now = DateTime.now();

      // Create a report document for the selected month
      await FirebaseFirestore.instance.collection('reports').add({
        'month': selectedMonth,
        'year': selectedYear,
        'totalBookings': totalBookings,
        'totalPayments': totalPayments,
        'createdAt': now,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Monthly report generated successfully')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to generate monthly report: $e')),
      );
    }
  }
  void _selectMonth(BuildContext context) async {
    final List<String> months = List.generate(12, (index) => DateFormat('MMMM').format(DateTime(0, index + 1)));
    final List<String> years = List.generate(10, (index) => (DateTime.now().year - index).toString());
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Month and Year'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButton<String>(
                value: selectedMonth,
                items: months.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    selectedMonth = newValue!;
                  });
                },
              ),
              DropdownButton<String>(
                value: selectedYear,
                items: years.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    selectedYear = newValue!;
                  });
                },
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                _fetchData(selectedMonth, selectedYear);
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text(
          "Reports",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.calendar_today),
            onPressed: () {
              _selectMonth(context);
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Monthly Reports',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              'Total Bookings: $totalBookings',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              'Total Payments: \$${totalPayments.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _generateMonthlyReport,
              child: Text('Generate Monthly Report'),
            ),
            SizedBox(height: 20),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('reports').snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  }

                  return ListView(
                    children: snapshot.data!.docs.map((doc) {
                      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color:Colors.orange )
                          ),
                          child: ListTile(
                            title: Text('${data['month']} ${data['year']}'),
                            subtitle: Text(
                              'Bookings: ${data['totalBookings']}, Payments: \$${data['totalPayments'].toStringAsFixed(2)}',
                            ),
                            trailing: Text(DateFormat.yMMMd().format(data['createdAt'].toDate())),
                          ),
                        ),
                      );
                    }).toList(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
