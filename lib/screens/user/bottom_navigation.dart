
import 'package:aventure/screens/user/notification.dart';
import 'package:aventure/screens/user/profile.dart';
import 'package:aventure/screens/user/usercertificates.dart';
import 'package:aventure/screens/user/wishlisteditem.dart';
import 'package:aventure/services/auth_services.dart';
import 'package:flutter/material.dart';


import 'explore_page.dart';
import 'home_page.dart';

class BottomNavigationPage extends StatefulWidget {
  const BottomNavigationPage({super.key});

  @override
  State<BottomNavigationPage> createState() => _BottomNavigationPageState();
}

class _BottomNavigationPageState extends State<BottomNavigationPage> {

  int _selectedIndex=0;

  List<Widget> _widgetOptions=[

    HomePage(),
    ExplorePage(),
    ProfilePage(),
    WishlistPage(),
    UserCertificatesPage(),

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: BottomNavigationBar(
              selectedItemColor: Colors.black,
              unselectedItemColor: Colors.white,
              showSelectedLabels:false,

              onTap: (value){
                setState(() {
                  _selectedIndex=value;
                });
              },
              currentIndex:_selectedIndex,
              backgroundColor: Colors.orange,

              items: [
                BottomNavigationBarItem(icon: Icon(Icons.home),label: "Home", backgroundColor: Colors.orange,),
                BottomNavigationBarItem(icon: Icon(Icons.explore),label: "Explore", backgroundColor: Colors.orange,),
                BottomNavigationBarItem(icon: Icon(Icons.person),label: "Profile", backgroundColor: Colors.orange,),
                BottomNavigationBarItem(icon: Icon(Icons.favorite_border),label: "wish", backgroundColor: Colors.orange,),
                BottomNavigationBarItem(icon: Icon(Icons.receipt),label: "Certificates", backgroundColor: Colors.orange,),
              ],

            ),
          ),
        ),

        body: _widgetOptions.elementAt(_selectedIndex)
    );
  }
}

