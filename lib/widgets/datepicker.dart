import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:date_time_picker_widget/date_time_picker_widget.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';

class TimePickerWidget extends StatefulWidget {
  @override
  _TimePickerWidgetState createState() => _TimePickerWidgetState();
}

class _TimePickerWidgetState extends State<TimePickerWidget> {
  String _selectedTime = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 16),
        DateTimePicker(
          type: DateTimePickerType.Time,
          timeInterval: const Duration(hours: 2),
          onTimeChanged: (time) {
            setState(() {
              _selectedTime = DateFormat('hh:mm:ss aa').format(time);
            });
          },
        ),
        const SizedBox(height: 8),
        Text(
          'Time: $_selectedTime',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}
