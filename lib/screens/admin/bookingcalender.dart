import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BookingCalendar extends StatefulWidget {
  @override
  _BookingCalendarState createState() => _BookingCalendarState();
}

class _BookingCalendarState extends State<BookingCalendar> {
  Map<DateTime, List<Map<String, dynamic>>> _events = {};
  bool _isLoading = true;
  DateTime _selectedDay = DateTime.now();

  @override
  void initState() {
    super.initState();
    _fetchBookingData();
  }
  Future<void> _fetchBookingData() async {
    try {
      var firestore = FirebaseFirestore.instance;
      QuerySnapshot snapshot = await firestore.collection('bookings').get();

      Map<DateTime, List<Map<String, dynamic>>> events = {};
      snapshot.docs.forEach((doc) {
        if (doc['date'] != null) {
          Timestamp timestamp = doc['date'];
          DateTime date = timestamp.toDate();
          date =
              DateTime(date.year, date.month, date.day); // Normalize the date
          Map<String, dynamic> eventDetails = {
            'title': doc['title'],
            'activity': doc[
                'activityId'], // Assuming activityId is stored in the booking doc
            'category': doc['category'],
            'time': doc['time'],
          };
          if (events.containsKey(date)) {
            events[date]!.add(eventDetails);
          } else {
            events[date] = [eventDetails];
          }
        } else {
          print(
              "Document with ID ${doc.id} has a null date field."); // Debug: log documents with null date
        }
      });
      print("Events: $events"); // Debug: print the events map
      setState(() {
        _events = events;
        _isLoading = false;
      });
    } catch (e) {
      print("Error getting booking data: $e");
      setState(() {
        _isLoading = false;
      });
    }
  }
  List<Map<String, dynamic>> _getEventsForDay(DateTime day) {
    day = DateTime(day.year, day.month, day.day); // Normalize the day
    return _events[day] ?? [];
  }
  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Center(child: CircularProgressIndicator())
        : Column(

            children: [
              TableCalendar(

                  firstDay: DateTime.utc(2020, 1, 1),
                  lastDay: DateTime.utc(2030, 12, 31),
                  focusedDay: _selectedDay,
                  selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      _selectedDay = selectedDay;
                    });
                    print(
                        "Selected Day: $_selectedDay"); // Debug: print selected day
                    print(
                        "Events for selected day: ${_getEventsForDay(_selectedDay)}"); // Debug: print events for selected day
                  },
                  eventLoader: _getEventsForDay,

                  calendarStyle: CalendarStyle(
                    markersMaxCount: 1,

                    selectedDecoration: BoxDecoration(
                      color: Colors.orange,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
  SizedBox( height: 10,),
              Expanded(
                child: _buildEventList(),
              ),
            ],
          );
  }
  Widget _buildEventList() {
    final events = _getEventsForDay(_selectedDay);
    return events.isEmpty
        ? Center(child: Text('No bookings'))
        : ListView.builder(
            itemCount: events.length,
            itemBuilder: (context, index) {
              final event = events[index];
              return ListTile(
                title: Text(event['title']),
                subtitle: Text(
                  'Activityid: ${event['activity']}\nCategory: ${event['category']}\nTime: ${event['time']}',
                ),
              );
            },
          );
  }
}
