
import 'package:aventure/screens/admin/bookingcalender.dart';
import 'package:aventure/screens/admin/bookinggraph.dart';
import 'package:aventure/services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//
// class AdminDashboard extends StatelessWidget {
//   bool hasPendingRegistrations = false;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.orange.shade200,
//       appBar: AppBar(
//         title: Text(
//           'Admin Dashboard',
//           style: TextStyle(color: Colors.white),
//         ),
//         actions: [
//           IconButton(
//               onPressed: () async {
//                 AuthService().logout().then((value) =>
//                     Navigator.pushNamedAndRemoveUntil(
//                         context, '/login', (route) => false));
//               },
//               icon: Icon(Icons.logout_outlined))
//         ],
//       ),
//       drawer: Drawer(
//         child: ListView(
//           padding: EdgeInsets.all(5.0),
//           children: <Widget>[
//             DrawerHeader(
//               decoration: BoxDecoration(
//                 color: Colors.orange,
//               ),
//               child: Image.asset(
//                 'assets/img/aventurelogo.png',
//               ),
//             ),
//             ListTile(
//               selectedTileColor: Colors.orange,
//               leading: Icon(Icons.dashboard),
//               title: Text('Dashboard'),
//               onTap: () {
//                 Navigator.pushNamed(context, '/admin');
//               },
//             ),
//             ListTile(
//               selectedTileColor: Colors.orange,
//               leading: Icon(Icons.people),
//               title: Text('Users'),
//               onTap: () {
//                 Navigator.pushNamed(context, '/userpage');
//               },
//             ),
//             ListTile(
//               selectedTileColor: Colors.orange,
//               leading: Icon(Icons.people_alt_outlined),
//               title: Text('Event Managers'),
//               onTap: () {
//                 Navigator.pushNamed(context, '/eventmanagerpage');
//               },
//             ),
//             ListTile(
//               selectedTileColor: Colors.orange,
//               leading: Icon(Icons.people_alt_outlined),
//               title: Text('Category management'),
//               onTap: () {
//                 Navigator.pushNamed(context, '/categorymanagement');
//               },
//             ),
//             ListTile(
//               selectedTileColor: Colors.orange,
//               leading: Icon(Icons.book),
//               title: Text('Bookings'),
//               onTap: () {},
//             ),
//             ListTile(
//               selectedTileColor: Colors.orange,
//               leading: Icon(Icons.payment),
//               title: Text('Payments'),
//               onTap: () {},
//             ),
//             ListTile(
//               selectedTileColor: Colors.orange,
//               leading: Icon(Icons.hiking_outlined),
//               title: Text('Activity'),
//               onTap: () {},
//             ),
//             ListTile(
//               leading: Icon(
//                 Icons.notifications_outlined,
//                 color: hasPendingRegistrations ? Colors.red : Colors.black87,
//               ),
//               title: Text('Notification'),
//               selectedTileColor: Colors.orange,
//               onTap: () {
//                 Navigator.pushNamed(context, '/notifyaccess');
//               },
//             ),
//             ListTile(
//               selectedTileColor: Colors.orange,
//               leading: Icon(Icons.bar_chart),
//               title: Text('Reports'),
//               onTap: () {},
//             ),
//           ],
//         ),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(15.0),
//         child: Row(
//           children: [
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                   Text(
//                     'Booking Trend',
//                     style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                   ),
//                   SizedBox(height: 20),
//                   BookingGraph(),
//                 ],
//               ),
//             ),
//             SizedBox(width: 20),
//             Expanded(
//               child: BookingCalendar(),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
class AdminDashboard extends StatelessWidget {
  bool hasPendingRegistrations = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange.shade200,
      appBar: AppBar(
        title: Text(
          'Admin Dashboard',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
              onPressed: () async {
                AuthService().logout().then((value) =>
                    Navigator.pushNamedAndRemoveUntil(
                        context, '/login', (route) => false));
              },
              icon: Icon(Icons.logout_outlined))
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.all(5.0),
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.orange,
              ),
              child: Image.asset(
                'assets/img/aventurelogo.png',
              ),
            ),
            ListTile(
              selectedTileColor: Colors.orange,
              leading: Icon(Icons.dashboard),
              title: Text('Dashboard'),
              onTap: () {
                Navigator.pushNamed(context, '/admin');
              },
            ),
            ListTile(
              selectedTileColor: Colors.orange,
              leading: Icon(Icons.people),
              title: Text('Users'),
              onTap: () {
                Navigator.pushNamed(context, '/userpage');
              },
            ),
            ListTile(
              selectedTileColor: Colors.orange,
              leading: Icon(Icons.people_alt_outlined),
              title: Text('Event Managers'),
              onTap: () {
                Navigator.pushNamed(context, '/eventmanagerpage');
              },
            ),
            ListTile(
              selectedTileColor: Colors.orange,
              leading: Icon(Icons.people_alt_outlined),
              title: Text('Category management'),
              onTap: () {
                Navigator.pushNamed(context, '/categorymanagement');
              },
            ),
            ListTile(
              selectedTileColor: Colors.orange,
              leading: Icon(Icons.book),
              title: Text('Bookings'),
              onTap: () {
                Navigator.pushNamed(context, '/listbooking');
              },
            ),
            ListTile(
              selectedTileColor: Colors.orange,
              leading: Icon(Icons.payment),
              title: Text('Payments'),
              onTap: () {},
            ),
            ListTile(
              selectedTileColor: Colors.orange,
              leading: Icon(Icons.hiking_outlined),
              title: Text('Activity'),
              onTap: () {
                Navigator.pushNamed(context, '/listactivity');
              },
            ),
            ListTile(
              leading: Icon(
                Icons.notifications_outlined,
                color: hasPendingRegistrations ? Colors.red : Colors.black87,
              ),
              title: Text('Notification'),
              selectedTileColor: Colors.orange,
              onTap: () {
                Navigator.pushNamed(context, '/notifyaccess');
              },
            ),
            ListTile(
              selectedTileColor: Colors.orange,
              leading: Icon(Icons.bar_chart),
              title: Text('Reports'),
              onTap: () {},
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(15.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Booking Trend',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  Container(
                    decoration: BoxDecoration(
                       color:  Colors.grey[100]
                    ),
                    child: BookingGraph(),
                  ),
                ],
              ),
            ),
            SizedBox(width: 20),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                ),
                child: BookingCalendar(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
