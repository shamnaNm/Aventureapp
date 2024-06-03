// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:aventure/screens/user/explore_page.dart';
// import 'package:flutter/widgets.dart';
//
// import '../../models/user_model.dart';
//
// class HomePage extends StatefulWidget {
//   const HomePage({super.key});
//   @override
//   State<HomePage> createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//   UserModel? currentUser;
//
//   @override
//   void initState() {
//     super.initState();
//     _fetchCurrentUser();
//   }
//
//   Future<void> _fetchCurrentUser() async {
//     try {
//       User? user = FirebaseAuth.instance.currentUser;
//       if (user != null) {
//         DocumentSnapshot userDoc = await FirebaseFirestore.instance
//             .collection('user')
//             .doc(user.uid)
//             .get();
//         setState(() {
//           currentUser = UserModel.fromFirestore(userDoc);
//         });
//       }
//     } catch (e) {
//       print('Error fetching user data: $e');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         title: Text(
//             "${currentUser!.name}'s Home",
//           style: TextStyle(color: Colors.white,fontStyle: FontStyle.italic),
//         ),
//       ),
//       body: Container(
//         padding: EdgeInsets.all(20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             currentUser != null
//                 ? RichText(
//                     text: TextSpan(
//                       style: TextStyle(
//                         color: Colors.black,
//                         fontSize: 22,
//                       ),
//                       children: [
//                         TextSpan(
//                           text: "Welcome ", style: TextStyle(fontSize: 28, color: Colors.orange,fontWeight: FontWeight.bold),
//                         ),
//                         TextSpan(
//                           text: "${currentUser!.name} !",
//                           style: TextStyle(fontSize: 28, color: Colors.orange,fontWeight: FontWeight.bold),
//                         ),
//                         // WidgetSpan(
//                         //   child: Padding(
//                         //     padding: const EdgeInsets.only(left: 8.0),
//                         //     child: Text(
//                         //       '👋',
//                         //       style:
//                         //           TextStyle(fontSize: 30, color: Colors.orange),
//                         //     ),
//                         //   ),
//                         // ),
//                       ],
//                     ),
//                   )
//                 : Center(child: CircularProgressIndicator()),
//             SizedBox(height: 20),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 GestureDetector(
//                   onTap: () {
//                     Navigator.pushNamed(context, '/explore');
//                   },
//                   child: Container(
//                     height: 100,
//                     width: 150,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(20),
//                       color: Colors.orange.withOpacity(0.1),
//                     ),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Icon(Icons.explore, size: 40),
//                         SizedBox(height: 10),
//                         Text('Explore'),
//                       ],
//                     ),
//                   ),
//                 ),
//                 GestureDetector(
//                   onTap: () {
//                     Navigator.pushNamed(context, '/category');
//                   },
//                   child: Container(
//                     height: 100,
//                     width: 150,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(20),
//                       color: Colors.orange.withOpacity(0.1),
//                     ),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Icon(Icons.category, size: 40),
//                         SizedBox(height: 10),
//                         Text('Category'),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: 10),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 GestureDetector(
//                   onTap: () {
//                     Navigator.pushNamed(context, '/reviewuser');
//                   },
//                   child: Container(
//                     height: 100,
//                     width: 150,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(20),
//                       color: Colors.orange.withOpacity(0.1),
//                     ),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Icon(Icons.rate_review, size: 40),
//                         SizedBox(height: 10),
//                         Text('Reviews & feedback'),
//                       ],
//                     ),
//                   ),
//                 ),
//                 GestureDetector(
//                   onTap: () {
//                   //  Navigator.pushNamed(context, '/bookinglist'); // Add navigation for payments
//                   },
//                   child: Container(
//                     height: 100,
//                     width: 150,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(20),
//                       color: Colors.orange.withOpacity(0.1),
//                     ),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Icon(Icons.payment, size: 40),
//                         SizedBox(height: 10),
//                         Text('Bookings'),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: 10),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//     GestureDetector(
//     onTap: () {
//     Navigator.pushNamed(context, '/ticketlist'); // Add navigation for payments
//                   },
//                   child: Container(
//                     height: 100,
//                     width: 150,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(20),
//                       color: Colors.orange.withOpacity(0.1),
//                     ),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Icon(Icons.newspaper_outlined, size: 40),
//                         SizedBox(height: 10),
//                         Text('Tickets'),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:aventure/models/user_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  UserModel? currentUser;

  @override
  void initState() {
    super.initState();
    _fetchCurrentUser();
  }

  Future<void> _fetchCurrentUser() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('user')
            .doc(user.uid)
            .get();
        setState(() {
          currentUser = UserModel.fromFirestore(userDoc);
        });
      }
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: currentUser == null
            ? Text('Loading...')
            : Text(
          "${currentUser!.name}'s Home",
          style: TextStyle(color: Colors.white, fontStyle: FontStyle.italic),
        ),
      ),
      body: currentUser == null
          ? Center(child: CircularProgressIndicator())
          : Container(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            RichText(
              text: TextSpan(
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                ),
                children: [
                  TextSpan(
                    text: "Welcome ",
                    style: TextStyle(
                      fontSize: 28,
                      color: Colors.orange,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: "${currentUser!.name}!",
                    style: TextStyle(
                      fontSize: 28,
                      color: Colors.orange,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/explore');
                  },
                  child: Container(
                    height: 100,
                    width: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.orange.withOpacity(0.1),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.explore, size: 40),
                        SizedBox(height: 10),
                        Text('Explore'),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/category');
                  },
                  child: Container(
                    height: 100,
                    width: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.orange.withOpacity(0.1),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.category, size: 40),
                        SizedBox(height: 10),
                        Text('Category'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/reviewuser');
                  },
                  child: Container(
                    height: 100,
                    width: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.orange.withOpacity(0.1),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.rate_review, size: 40),
                        SizedBox(height: 10),
                        Text('Reviews & feedback'),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/mybookings'); // Add navigation for payments
                  },
                  child: Container(
                    height: 100,
                    width: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.orange.withOpacity(0.1),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.payment, size: 40),
                        SizedBox(height: 10),
                        Text('Bookings'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/ticketlist'); // Add navigation for payments
                  },
                  child: Container(
                    height: 100,
                    width: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.orange.withOpacity(0.1),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.newspaper_outlined, size: 40),
                        SizedBox(height: 10),
                        Text('Tickets'),
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
