//
// import 'package:flutter/material.dart';
// import '../models/activity_model.dart';
//
// class ActivityListWidget extends StatefulWidget {
//   final ActivityModel activity;
//   final Function(String) onTimeSelected;
//
//   ActivityListWidget({required this.activity, required this.onTimeSelected});
//
//   @override
//   _ActivityListWidgetState createState() => _ActivityListWidgetState();
// }
//
// class _ActivityListWidgetState extends State<ActivityListWidget> {
//   String? _selectedTime;
//   List<Map<String, dynamic>> schedules = [];
//
//   @override
//   void initState() {
//     super.initState();
//     _initializeSchedules();
//   }
//
//   void _initializeSchedules() {
//     if (widget.activity.schedules != null) {
//       setState(() {
//         schedules = List<Map<String, dynamic>>.from(widget.activity.schedules!);
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       shrinkWrap: true,
//       itemCount: schedules.length,
//       itemBuilder: (context, index) {
//         final schedule = schedules[index];
//         return Column(
//           children: [
//             _buildActivityTile(
//               Icons.access_time,
//               schedule['time'],
//               '${schedule['tickets']} tickets available',
//             ),
//             SizedBox(height: 5),
//           ],
//         );
//       },
//     );
//   }
//
//   Widget _buildActivityTile(IconData icon, String time, String availability) {
//     return RadioListTile<String>(
//       tileColor: Colors.orange.withOpacity(0.1),
//       title: Row(
//         children: [
//           Icon(icon),
//           SizedBox(width: 10),
//           Text(time),
//           SizedBox(width: 20),
//           Text(availability),
//         ],
//       ),
//       value: time,
//       groupValue: _selectedTime,
//       onChanged: (String? value) {
//         setState(() {
//           _selectedTime = value;
//         });
//         if (value != null) {
//           widget.onTimeSelected(value);
//         }
//       },
//       activeColor: Colors.orange, // Adjust the color of the selected radio button
//       controlAffinity: ListTileControlAffinity.trailing, // Align radio button to the trailing edge
//     );
//   }
// }
import 'package:flutter/material.dart';
import '../models/activity_model.dart';

class ActivityListWidget extends StatefulWidget {
  final ActivityModel activity;
  final Function(String) onTimeSelected;

  ActivityListWidget({required this.activity, required this.onTimeSelected});

  @override
  _ActivityListWidgetState createState() => _ActivityListWidgetState();
}

class _ActivityListWidgetState extends State<ActivityListWidget> {
  String? _selectedTime;
  List<Map<String, dynamic>> schedules = [];

  @override
  void initState() {
    super.initState();
    _initializeSchedules();
  }

  void _initializeSchedules() {
    if (widget.activity.schedules != null) {
      setState(() {
        schedules = widget.activity.schedules!.map((schedule) {
          return {
            'time': schedule['time'],
            'tickets': schedule['tickets'],
            'initialTickets': schedule['tickets'],
          };
        }).toList();
      });
    }
  }

  void _reduceTicketCount(String time) {
    setState(() {
      for (var schedule in schedules) {
        if (schedule['time'] == time && schedule['tickets'] > 0) {
          schedule['tickets']--;
          break;
        }
      }
    });
  }

  void _restoreTicketCount(String time) {
    setState(() {
      for (var schedule in schedules) {
        if (schedule['time'] == time) {
          schedule['tickets'] = schedule['initialTickets'];
          break;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: schedules.length,
      itemBuilder: (context, index) {
        final schedule = schedules[index];
        return Column(
          children: [
            _buildActivityTile(
              Icons.access_time,
              schedule['time'],
              '${schedule['tickets']} tickets available',
            ),
            SizedBox(height: 5),
          ],
        );
      },
    );
  }

  Widget _buildActivityTile(IconData icon, String time, String availability) {
    return RadioListTile<String>(
      tileColor: Colors.orange.withOpacity(0.1),
      title: Row(
        children: [
          Icon(icon),
          SizedBox(width: 10),
          Text(time),
          SizedBox(width: 20),
          Text(availability),
        ],
      ),
      value: time,
      groupValue: _selectedTime,
      onChanged: (String? value) {
        setState(() {
          if (_selectedTime != null) {
            _restoreTicketCount(_selectedTime!);
          }
          _selectedTime = value;
          if (value != null) {
            _reduceTicketCount(value);
            widget.onTimeSelected(value);
          }
        });
      },
      activeColor: Colors.orange, // Adjust the color of the selected radio button
      controlAffinity: ListTileControlAffinity.trailing, // Align radio button to the trailing edge
    );
  }
}
