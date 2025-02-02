//
// import 'package:aventure/screens/admin/bookingcalender.dart';
// import 'package:aventure/screens/admin/bookinggraph.dart';
// import 'package:aventure/services/auth_services.dart';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
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
//               onTap: () {
//                 Navigator.pushNamed(context, '/listbooking');
//               },
//             ),
//             ListTile(
//               selectedTileColor: Colors.orange,
//               leading: Icon(Icons.payment),
//               title: Text('Payments'),
//               onTap: () {
//                 Navigator.pushNamed(context, '/paymentdetail');
//               },
//             ),
//             ListTile(
//               selectedTileColor: Colors.orange,
//               leading: Icon(Icons.hiking_outlined),
//               title: Text('Activity'),
//               onTap: () {
//                 Navigator.pushNamed(context, '/listactivity');
//               },
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
//                   Container(
//                     decoration: BoxDecoration(
//                        color:  Colors.grey[100]
//                     ),
//                     child: BookingGraph(),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(width: 20),
//             Expanded(
//               child: Container(
//                 padding: EdgeInsets.all(20),
//                 decoration: BoxDecoration(
//                   border: Border.all(color: Colors.white),
//                 ),
//                 child: BookingCalendar(),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }



//
//
// import 'package:aventure/screens/admin/bookingcalender.dart';
// import 'package:aventure/screens/admin/bookinggraph.dart';
// import 'package:aventure/services/auth_services.dart';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
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
//                 AuthService().logout().then((value) => Navigator.pushNamedAndRemoveUntil(
//                     context, '/login', (route) => false));
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
//               onTap: () {
//                 Navigator.pushNamed(context, '/listbooking');
//               },
//             ),
//             ListTile(
//               selectedTileColor: Colors.orange,
//               leading: Icon(Icons.payment),
//               title: Text('Payments'),
//               onTap: () {
//                 Navigator.pushNamed(context, '/paymentdetail');
//               },
//             ),
//             ListTile(
//               selectedTileColor: Colors.orange,
//               leading: Icon(Icons.hiking_outlined),
//               title: Text('Activity'),
//               onTap: () {
//                 Navigator.pushNamed(context, '/listactivity');
//               },
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
//         child: LayoutBuilder(
//           builder: (context, constraints) {
//             if (constraints.maxWidth > 800) {
//               // Large screen layout
//               return Row(
//                 children: [
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.stretch,
//                       children: [
//                         Text(
//                           'Booking Trend',
//                           style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                         ),
//                         SizedBox(height: 20),
//                         Container(
//                           decoration: BoxDecoration(color: Colors.grey[100]),
//                           child: BookingGraph(),
//                         ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(width: 20),
//                   Expanded(
//                     child: Container(
//                       padding: EdgeInsets.all(20),
//                       decoration: BoxDecoration(
//                         border: Border.all(color: Colors.white),
//                       ),
//                       child: BookingCalendar(),
//                     ),
//                   ),
//                 ],
//               );
//             } else {
//               // Small screen layout
//               return Column(
//                 children: [
//                   Text(
//                     'Booking Trend',
//                     style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                   ),
//                   SizedBox(height: 20),
//                   Container(
//                     decoration: BoxDecoration(color: Colors.grey[100]),
//                     child: BookingGraph(),
//                   ),
//                   SizedBox(height: 20),
//                   Container(
//                     padding: EdgeInsets.all(20),
//                     decoration: BoxDecoration(
//                       border: Border.all(color: Colors.white),
//                     ),
//                     child: BookingCalendar(),
//                   ),
//                 ],
//               );
//             }
//           },
//         ),
//       ),
//     );
//   }
// }

import 'package:aventure/screens/admin/bookingcalender.dart';
import 'package:aventure/screens/admin/bookinggraph.dart';
import 'package:aventure/services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
              AuthService()
                  .logout()
                  .then((value) => Navigator.pushNamedAndRemoveUntil(
                  context, '/login', (route) => false));
            },
            icon: Icon(Icons.logout_outlined),
          ),
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
              leading: Icon(Icons.person_4_rounded),
              title: Text('Event Managers'),
              onTap: () {
                Navigator.pushNamed(context, '/eventmanagerpage');
              },
            ),

            ListTile(
              selectedTileColor: Colors.orange,
              leading: Icon(Icons.category_outlined),
              title: Text('Category management'),
              onTap: () {
                Navigator.pushNamed(context, '/categorymanagement');
              },
            ),
            ListTile(
              selectedTileColor: Colors.orange,
              leading: Icon(Icons.kayaking_outlined),
              title: Text('Activity'),
              onTap: () {
                Navigator.pushNamed(context, '/listactivity');
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
              leading: Icon(Icons.currency_rupee_outlined),
              title: Text('Payments'),
              onTap: () {
                Navigator.pushNamed(context, '/paymentdetail');
              },
            ),

            ListTile(
              leading: Icon(
                Icons.notifications_none_outlined,
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
              leading: Icon(Icons.receipt_long_outlined),
              title: Text('Reports'),
              onTap: () {
                Navigator.pushNamed(context, '/reports');
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(15.0),
        child: LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth > 800) {
              // Large screen layout
              return Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Booking Trend',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 20),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(color: Colors.grey[100]),
                            child: BookingGraph(),
                          ),
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
              );
            } else {
              // Small screen layout
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Text(
                      'Booking Trend',
                      style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 20),
                    Container(
                      height: 300, // Adjust height as needed
                      decoration: BoxDecoration(color: Colors.grey[100]),
                      child: BookingGraph(),
                    ),
                    SizedBox(height: 20),
                    Container(
                      height: 700, // Adjust height as needed
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                      ),
                      child: BookingCalendar(),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
