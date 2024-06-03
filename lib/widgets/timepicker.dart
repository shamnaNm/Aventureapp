// import 'package:easy_date_timeline/easy_date_timeline.dart';
// import 'package:flutter/material.dart';
//
// class DatePickerWidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return EasyDateTimeLine(
//       initialDate: DateTime.now(),
//       onDateChange: (_selectedDate) {
//         // Check if the selected date is a Sunday (weekday == 7)
//         if (_selectedDate.weekday == DateTime.sunday) {
//           // Show a message or handle it as per your requirement
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(
//               content: Text('Sundays are not available for booking.'),
//             ),
//           );
//           // Optionally, you can also reset to a valid date or not proceed further
//         } else {
//           // Handle selected date
//           print("Selected Date: $_selectedDate");
//           // Your booking logic here
//         }
//       },
//       activeColor: Colors.orange,
//       dayProps: const EasyDayProps(
//         borderColor: Colors.orange,
//         todayHighlightStyle: TodayHighlightStyle.withBackground,
//         todayHighlightColor: Color(0xfff3be98),
//       ),
//     );
//   }
// }
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';

class DatePickerWidget extends StatelessWidget {
  final Function(DateTime) onDateSelected;

  DatePickerWidget({required this.onDateSelected});

  @override
  Widget build(BuildContext context) {
    return EasyDateTimeLine(
      initialDate: DateTime.now(),
      onDateChange: (_selectedDate) {
        if (_selectedDate.weekday == DateTime.sunday) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Sundays are not available for booking.'),
            ),
          );
        } else {
          onDateSelected(_selectedDate);
          print("Selected Date: $_selectedDate");
        }
      },
      activeColor: Colors.orange,
      dayProps: const EasyDayProps(
        borderColor: Colors.orange,
        todayHighlightStyle: TodayHighlightStyle.withBackground,
        todayHighlightColor: Color(0xfff3be98),
      ),
    );
  }
}
