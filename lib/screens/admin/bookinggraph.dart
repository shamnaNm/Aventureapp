
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:syncfusion_flutter_charts/charts.dart';


class BookingGraph extends StatefulWidget {
  @override
  _BookingGraphState createState() => _BookingGraphState();
}

class _BookingGraphState extends State<BookingGraph> {
  List<BookingData> _chartData = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _getBookingData();
  }

  // Future<void> _getBookingData() async {
  //   var firestore = FirebaseFirestore.instance;
  //   QuerySnapshot snapshot = await firestore.collection('bookings').get();
  //
  //   Map<int, int> monthlyBookings = {};
  //
  //   snapshot.docs.forEach((doc) {
  //     Timestamp timestamp = doc['date'];
  //     DateTime date = timestamp.toDate();
  //     int month = date.month;
  //     if (monthlyBookings.containsKey(month)) {
  //       monthlyBookings[month] = monthlyBookings[month]! + 1;
  //     } else {
  //       monthlyBookings[month] = 1;
  //     }
  //   });
  //   List<BookingData> data = [];
  //   monthlyBookings.forEach((month, count) {
  //     data.add(BookingData(month: month, count: count));
  //   });
  //
  //   setState(() {
  //     _chartData = data;
  //     _isLoading = false;
  //   });
  // }
  Future<void> _getBookingData() async {
    try {
      var firestore = FirebaseFirestore.instance;
      QuerySnapshot snapshot = await firestore.collection('bookings').get();

      Map<int, int> monthlyBookings = {};

      for (var doc in snapshot.docs) {
        var timestamp = doc['date'];
        if (timestamp != null && timestamp is Timestamp) {
          DateTime date = timestamp.toDate();
          int month = date.month;
          if (monthlyBookings.containsKey(month)) {
            monthlyBookings[month] = monthlyBookings[month]! + 1;
          } else {
            monthlyBookings[month] = 1;
          }
        }
      }

      List<BookingData> data = [];
      monthlyBookings.forEach((month, count) {
        data.add(BookingData(month: month, count: count));
      });

      setState(() {
        _chartData = data;
        _isLoading = false;
      });
    } catch (e) {
      print("Error getting booking data: $e");
      setState(() {
        _isLoading = false;
      });
    }
  }

  String _getMonthName(int month) {
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return months[month - 1];
  }

  @override
  Widget build(BuildContext context) {
    return
       _isLoading
          ? Center(child: CircularProgressIndicator())
          : SfCartesianChart(
        primaryXAxis: CategoryAxis(),
        title: ChartTitle(text: 'Total Bookings Per Month'),
        legend: Legend(isVisible: false),
        tooltipBehavior: TooltipBehavior(enable: true),
        series: <CartesianSeries>[
          ColumnSeries<BookingData, String>(
            dataSource: _chartData,
            xValueMapper: (BookingData data, _) => _getMonthName(data.month),
            yValueMapper: (BookingData data, _) => data.count,
            name: 'Bookings',
            dataLabelSettings: DataLabelSettings(isVisible: true),
            pointColorMapper: (BookingData data, _) => _getColumnColor(data.month),
          )
        ],
    );
  }

  Color _getColumnColor(int month) {
    const colors = [
      Colors.red,
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.purple,
      Colors.cyan,
      Colors.yellow,
      Colors.pink,
      Colors.brown,
      Colors.teal,
      Colors.indigo,
      Colors.lime
    ];
    return colors[month - 1];
  }
}

class BookingData {
  final int month;
  final int count;

  BookingData({required this.month, required this.count});
}
