import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../services/auth_services.dart';
class EventManagerHome extends StatefulWidget {
  const EventManagerHome({super.key});
  @override
  State<EventManagerHome> createState() => _EventManagerHomeState();
}
class _EventManagerHomeState extends State<EventManagerHome> {
  List<Map<String, dynamic>> items = [
    {"name": "Add Banners/Offer", "icon": Icons.local_offer_outlined},
    {"name": "Add Activity", "icon": Icons.downhill_skiing_outlined},
    {"name": "View Activity", "icon": Icons.surfing_outlined,},
    {"name": "Bookings", "icon": Icons.book},
    {"name": "Generated Tickets", "icon": Icons.receipt},
    {"name": "Refunds", "icon": Icons.wallet_outlined},
    {"name": "Certificate", "icon": Icons.panorama_outlined},
    {"name": "About Us", "icon": Icons.people},
    {"name": "Profile", "icon": Icons.manage_accounts_rounded},
  ];
  List<String> routes = [
    '/addbanners',
    '/addactivity',
    '/allactivity',
    '/viewbookings',
    '/tickets',
    '/refund',
    '/certificate',
    '/abouteventer',
    '/eventerprofile',
  ];
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  var uid;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    uid = FirebaseAuth.instance.currentUser!.uid;
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Eventers Home",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: false,
        actions: [
          IconButton(
              onPressed: () async {
                await AuthService().logout().then((value) =>
                    Navigator.pushNamedAndRemoveUntil(
                        context, '/login', (route) => false));
              },
              icon: Icon(Icons.logout_outlined)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(children: [
          Expanded(
            child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 4 / 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      int adjustedIndex = index;
                      Navigator.pushNamed(
                        context,
                        routes[
                            adjustedIndex], // Navigate to the corresponding route
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.orange.withOpacity(0.1),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(items[index]['icon']),
                          SizedBox(height: 8),
                          Text(items[index]['name']),
                        ],
                      ),
                    ),
                  );
                }),
          ),
        ]),
      ),
    );
  }
}
