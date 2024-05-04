import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../data/location_list.dart';
import '../../../widgets/activitytimelist.dart';
import '../../../widgets/datepicker.dart';
import '../../../widgets/timepicker.dart';

class ActivityEightBooking extends StatefulWidget {
  const ActivityEightBooking({super.key, required this.title});
  final String title;
  @override
  State<ActivityEightBooking> createState() => _ActivityEightBookingState();
}

class _ActivityEightBookingState extends State<ActivityEightBooking> {
  int _counter = 0;
  int _ticketsSelected = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decrementCounter() {
    setState(() {
      if (_counter > 0) {
        _counter--;
      }
    });
  }

  void _incrementTickets() {
    setState(() {
      _ticketsSelected++;
    });
  }

  void _decrementTickets() {
    setState(() {
      if (_ticketsSelected > 0) {
        _ticketsSelected--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text("Booking", style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: true,
            child: SingleChildScrollView(
              child: Container(
                color: Colors.white,
                padding: EdgeInsets.all(10),
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: Colors.grey,
                          width: 0.2,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width / 3,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            padding: EdgeInsets.all(8),
                            child: Container(
                              height:
                              300, // Fixed height for the image container
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                image: DecorationImage(
                                  image:
                                  NetworkImage(road[1].image.toString()),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          //Second and third column widgets can be added here
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Pick a Date",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Container(
                      child: DatePickerWidget(),
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Pick a Time",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 10),
                    ActivityListWidget(),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("Tickets",style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),),
                        SizedBox(width:200 ,),
                        FloatingActionButton(
                          backgroundColor: Colors.orange,
                          onPressed: _decrementTickets,
                          tooltip: 'Reduce tickets',
                          child: Icon(Icons.remove),
                        ),
                        SizedBox(width: 16.0),
                        Text('$_ticketsSelected'),
                        SizedBox(width: 16.0),
                        FloatingActionButton(
                          backgroundColor: Colors.orange,
                          onPressed: _incrementTickets,
                          tooltip: 'Add tickets',
                          child: Icon(Icons.add),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(10),
        height: 100,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'total',
              style: TextStyle(color: Colors.black),
            ),
            ElevatedButton(
              onPressed: () {
                // Add your  logic here
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                '    Next    ',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
