import 'dart:io';
import 'package:aventure/screens/user/zoomimage.dart';
import 'package:aventure/services/auth_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../models/user_model.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late Future<UserModel> _userFuture;
  @override
  void initState() {
    super.initState();
    _userFuture = _getUserData();
  }

  Future<UserModel> _getUserData() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    if (user != null) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('user').doc(user.uid).get();
      UserModel userData = UserModel.fromJson(userDoc);
     
      return userData;
    } else {
      throw Exception("User not logged in");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            color: Colors.orange,
          ),
          FutureBuilder<UserModel>(
            future: _userFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (snapshot.hasData) {
                UserModel userData = snapshot.data!;
                return Positioned(
                  top: 60,
                  left: 16,
                  right: 16,
                  child: Row(
                    children: [

                      GestureDetector(
                        onTap: () {
                          if (userData.imgUrl != null && userData.imgUrl!.isNotEmpty) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ImageZoomPage(imageUrl: userData.imgUrl!),
                              ),
                            );
                          }
                        },
                        child: CircleAvatar(
                          radius: 45,
                          backgroundColor: Colors.white,
                          child: userData.imgUrl != null && userData.imgUrl!.isNotEmpty
                              ? ClipOval(
                            child: Image.network(
                              userData.imgUrl!,
                              fit: BoxFit.cover,
                              width: 90,
                              height: 90,
                            ),
                          )
                              : Icon(
                            Icons.person,
                            color: Colors.orange,
                          ),
                        ),
                      ),
                      SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            userData.name!,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            userData.email!,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      IconButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/personalinfo');
                        },
                        icon: Icon(Icons.edit_outlined, color: Colors.white),
                      ),
                    ],
                  ),
                );
              } else {
                return Center(child: Text('No user data available'));
              }
            },
          ),
          Positioned(
            top: 200,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 20.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _buildListItem(
                          Icons.person_outline, "Account", '/personalinfo'), SizedBox(height: 5),
                      _buildListItem(Icons.history, "History", '/history'), SizedBox(height: 5),
                      _buildListItem(Icons.payments_outlined, "Transaction",
                          '/mypayments'), SizedBox(height: 5),
                      _buildListItem(Icons.notifications_outlined,
                          "Notifications", '/notificition'), SizedBox(height: 5),
                      // _buildListItem(
                      //     Icons.lock_reset, "Reset Password", '/forgot'), SizedBox(height: 5),
                      _buildListItem(Icons.privacy_tip_outlined,
                          "Privacy Policy", '/privacy'), SizedBox(height: 5),
                      _buildListItem(
                          Icons.description, "Terms & Conditions", '/termc'),
                      SizedBox(height: 10),
                      _buildLogoutButton(),
                      SizedBox(height: 25),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }


  Widget _buildListItem(IconData icon, String text, String route) {
    return Container(
      height: 60,
      margin: EdgeInsets.symmetric(vertical: 5.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: Colors.orange,
        ),
        title: Text(text),
        trailing: Icon(Icons.arrow_right, color: Colors.grey),
        onTap: () {
          Navigator.pushNamed(context, route);
        },
      ),
    );
  }

  Widget _buildLogoutButton() {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.orange.withOpacity(0.9),
          padding: EdgeInsets.symmetric(vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: () async {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Confirm Logout"),
                content: Text("Are you sure you want to log out?"),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Cancel"),
                  ),
                  TextButton(
                    onPressed: () async {
                      await AuthService().logout().then((value) =>
                          Navigator.pushNamedAndRemoveUntil(
                              context, '/login', (route) => false));
                    },
                    child: Text(
                      "Logout",
                    ),
                  ),
                ],
              );
            },
          );
        },
        child: Text(
          "Log Out",
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
