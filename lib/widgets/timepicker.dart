import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
class DatePickerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return EasyDateTimeLine(
      initialDate: DateTime.now(),
      onDateChange: (selectedDate) {
        // Handle selected date
      },
      activeColor: Colors.orange,
      //const Color(0xff85A389),
      dayProps: const EasyDayProps(
        borderColor: Colors.orange,
        todayHighlightStyle: TodayHighlightStyle.withBackground,
        todayHighlightColor: Color(0xfff3be98),
      ),
    );
  }
}