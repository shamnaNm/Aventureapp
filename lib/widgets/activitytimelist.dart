import 'package:flutter/material.dart';
class ActivityListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        _buildActivityTile(Icons.access_time, '9:00 AM', '1 seat available'),
        SizedBox(height: 5), // Add space after each tile
        _buildActivityTile(Icons.access_time, '11:00 AM', '12 seats available'),
        SizedBox(height: 5), // Add space after each tile
        _buildActivityTile(Icons.access_time, '1:00 PM', '3 seats available'),
        SizedBox(height: 5), // Add space after each tile
        _buildActivityTile(Icons.access_time, '3:00 PM', '5 seats available'),
        SizedBox(height: 5), // Add space after each tile
        _buildActivityTile(Icons.access_time, '4:00 PM', '10 seats available'),
      ],
    );
  }

  Widget _buildActivityTile(IconData icon, String time, String availability) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(

           color: Colors.orange.withOpacity(0.1), // You can change the border color here
          width: 0.1, // You can adjust the border width here
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      // Set tile color to blue
      child: ListTile(

        leading: Icon(icon, size: 24), // Adjust leading icon size
        title: Text(time),
        trailing: Text(availability),
      ),
    );
  }
}
