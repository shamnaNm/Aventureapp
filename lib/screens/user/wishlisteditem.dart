
import 'package:aventure/models/activity_model.dart';
import 'package:aventure/models/wishlist%20model.dart';

import 'package:aventure/screens/user/activity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class WishlistPage extends StatefulWidget {
  const WishlistPage({Key? key}) : super(key: key);

  @override
  _WishlistPageState createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  late List<WishlistModel> wishlist = [];

  var uid;


  getData() async {
    uid = FirebaseAuth.instance.currentUser!.uid;
    setState(() {});
  }
  @override
  void initState() {
    super.initState();
    getData();
    _fetchWishlist();
  }

  Future<void> _fetchWishlist() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        QuerySnapshot wishlistSnapshot = await FirebaseFirestore.instance
            .collection('wishlist')
            .where('userId', isEqualTo: user.uid)
            .get();
        setState(() {
          wishlist = wishlistSnapshot.docs
              .map((doc) => WishlistModel.fromSnapshot(doc))
              .toList();
        });
      }
    } catch (e) {
      print('Error fetching wishlist: $e');
    }
  }

  Future<void> _removeFromWishlist(String wishlistItemId) async {
    try {
      await FirebaseFirestore.instance
          .collection('wishlist')
          .doc(wishlistItemId)
          .delete();
      setState(() {
        wishlist.removeWhere((item) => item.id == wishlistItemId);
      });
    } catch (e) {
      print('Error removing from wishlist: $e');
    }
  }

  Future<ActivityModel?> _fetchActivity(String activityId) async {
    try {
      DocumentSnapshot activitySnapshot = await FirebaseFirestore.instance
          .collection('activities')
          .doc(activityId)
          .get();
      if (activitySnapshot.exists) {
        return ActivityModel.fromSnapshot(activitySnapshot);
      }
    } catch (e) {
      print('Error fetching activity: $e');
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Wishlist',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: wishlist.isEmpty
          ? Center(
        child: Text('Your wishlist is empty.'),
      )
          : ListView.builder(
        itemCount: wishlist.length,
        itemBuilder: (context, index) {
          WishlistModel item = wishlist[index];
          return FutureBuilder<ActivityModel?>(
            future: _fetchActivity(item.activityId!), // Assuming activityId is a field in WishlistModel
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError || !snapshot.hasData) {
                return Center(child: Text('Error loading activity'));
              }
              ActivityModel? activity = snapshot.data;

              if (activity == null) {
                return Center(child: Text('Activity not found'));
              }

              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ActivityPage(activity: activity),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 2,
                          offset: Offset(0, 1),
                        ),
                      ],
                    ),
                    child: Stack(
                      children: [
                        Container(
                          width: double.infinity,
                          height: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(item.image ?? ''),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 8,
                          right: 8,
                          child: IconButton(
                            icon: Icon(
                              Icons.favorite,
                              color: Colors.red,
                            ),
                            onPressed: () {
                              _removeFromWishlist(item.id ?? '');
                            },
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            padding: EdgeInsets.all(8),
                            color: Colors.white.withOpacity(0.8),
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.title ?? '',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Icon(Icons.location_pin),
                                        Text(item.location ?? ''),
                                      ],
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      "Rs.${item.price ?? ''}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      "/per Person",
                                      style: TextStyle(
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
