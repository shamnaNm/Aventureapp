import 'dart:async';
import 'package:aventure/models/wishlist%20model.dart';
import 'package:aventure/screens/user/activity.dart';
import 'package:aventure/services/category_service.dart';
import 'package:aventure/widgets/mapwidget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../models/category_model.dart';
import '../../models/activity_model.dart';
import '../../models/user_model.dart';
import '../../widgets/sliderhomebanner.dart';
class ExplorePage extends StatefulWidget {
  const ExplorePage({Key? key}) : super(key: key);
  @override
  State<ExplorePage> createState() => _ExplorePageState();
}
class _ExplorePageState extends State<ExplorePage> {
  final CategoryService _categoryService = CategoryService();
  TextEditingController _searchController = TextEditingController();
  UserModel? currentUser;
  List<WishlistModel> wishlist = [];
  @override
  void initState() {
    super.initState();
    getData();
    _fetchCurrentUser();
    _fetchWishlist();
  }
  var uid;


  getData() async {
    uid = FirebaseAuth.instance.currentUser!.uid;
    setState(() {});
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

  void addToWishlist(ActivityModel activity) {
    WishlistModel wishlistItem = WishlistModel(
      activityId: activity.id,
      title: activity.title,
      location: activity.location,
      price: activity.price,
      image: activity.image,
      category: activity.category,
      userId: FirebaseAuth.instance.currentUser!.uid,
    );

    FirebaseFirestore.instance
        .collection('wishlist')
        .add(wishlistItem.toMap())
        .then((_) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Activity added to wishlist'),
      ));
      setState(() {
        wishlist.add(wishlistItem);
      });
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to add activity to wishlist: $error'),
      ));
    });
  }

  void removeFromWishlist(ActivityModel activity) {
    FirebaseFirestore.instance
        .collection('wishlist')
        .where('userId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .where('activityId', isEqualTo: activity.id)
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        doc.reference.delete();
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Activity removed from wishlist'),
      ));
      setState(() {
        wishlist.removeWhere((item) => item.activityId == activity.id);
      });
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to remove activity from wishlist: $error'),
      ));
    });
  }

  bool isActivityInWishlist(ActivityModel activity) {
    return wishlist.any((item) => item.activityId == activity.id);
  }

  int selectedCategoryIndex = 0;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<CategoryModel>> _fetchCategories() async {
    QuerySnapshot snapshot = await _firestore.collection('categories').get();
    return snapshot.docs
        .map((doc) => CategoryModel.fromDocumentSnapshot(doc))
        .toList();
  }

  Future<List<ActivityModel>> _fetchActivities(
      String categoryTitle, String searchQuery) async {
    QuerySnapshot snapshot;

    if (categoryTitle == "All Activities") {
      snapshot = await _firestore.collection('activities').get();
    } else {
      snapshot = await _firestore
          .collection('activities')
          .where('category', isEqualTo: categoryTitle)
          .get();
    }

    List<ActivityModel> activities =
        snapshot.docs.map((doc) => ActivityModel.fromSnapshot(doc)).toList();

    // Apply search filter if searchQuery is not empty
    if (searchQuery.isNotEmpty) {
      activities = activities
          .where((activity) =>
              activity.title!.toLowerCase().contains(searchQuery.toLowerCase()))
          .toList();
    }

    return activities;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.orange),
        toolbarHeight: 100,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Find your favourite \nactivity",
              style: TextStyle(
                color: Colors.black,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage(
                    'assets/img/profile.png', // Replace with actual image asset
                  ),
                ),
                SizedBox(height: 5),
                if (currentUser != null)
                  Text(
                    currentUser!.name ?? 'Guest',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: EdgeInsets.all(20),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                TextField(
                  controller: _searchController,
                  onChanged: (_) {
                    setState(() {});
                  },
                  decoration: InputDecoration(
                    hintText: 'Search Activity...',
                    hintStyle: TextStyle(color: Colors.black),
                    suffixIcon: Icon(
                      Iconsax.search_normal_1,
                      color: Colors.black,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.grey.withOpacity(0.4)),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: Colors.orange),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 12.0,
                      horizontal: 16.0,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Category",
                      style: TextStyle(
                        color: Colors.orange.withOpacity(0.8),
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          "See All",
                          style: TextStyle(
                            color: Colors.orange.withOpacity(0.8),
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(
                          Icons.arrow_forward,
                          color: Colors.orange,
                        )
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                FutureBuilder<List<CategoryModel>>(
                  future: _fetchCategories(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(child: Text('No categories available'));
                    }
                    final categoryList = [
                      CategoryModel(
                          title:
                              "All Activities"), // Add the "All Activities" category
                      ...snapshot.data!,
                    ];
                    return Column(
                      children: [
                        Container(
                          height: 45,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: categoryList.length,
                            itemBuilder: (context, index) {
                              final category = categoryList[index];
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedCategoryIndex = index;
                                  });
                                },
                                child: Card(
                                  color: selectedCategoryIndex == index
                                      ? Colors.orange
                                      : null,
                                  child: Container(
                                    width: 130,
                                    height: 50,
                                    child: Center(
                                      child: Text(
                                        category.title!,
                                        style: TextStyle(
                                          color: selectedCategoryIndex == index
                                              ? Colors.white
                                              : Colors.orange,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        FutureBuilder<List<ActivityModel>>(
                          future: _fetchActivities(
                              categoryList[selectedCategoryIndex].title!,
                              _searchController.text),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(child: CircularProgressIndicator());
                            } else if (snapshot.hasError) {
                              return Center(
                                  child: Text('Error: ${snapshot.error}'));
                            } else if (!snapshot.hasData ||
                                snapshot.data!.isEmpty) {
                              return Center(
                                  child: Text('No activities available'));
                            }
                            final activityList = snapshot.data!;
                            return ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: activityList.length,
                              itemBuilder: (context, index) {
                                final activity = activityList[index];
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ActivityPage(
                                          activity: activity,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    margin: EdgeInsets.all(10),
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
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image:
                                                  NetworkImage(activity.image!),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          top: 8,
                                          right: 8,
                                          child: IconButton(
                                            icon: Icon(
                                              Icons.favorite_outlined,
                                              color:
                                                  isActivityInWishlist(activity)
                                                      ? Colors.red
                                                      : Colors.white,
                                            ),
                                            onPressed: () {
                                              if (isActivityInWishlist(
                                                  activity)) {
                                                removeFromWishlist(activity);
                                              } else {
                                                addToWishlist(activity);
                                              }
                                            },
                                          ),
                                        ),
                                        Positioned(
                                          bottom: 0,
                                          left: 0,
                                          right: 0,
                                          child: Container(
                                            padding: EdgeInsets.all(8),
                                            color:
                                                Colors.white.withOpacity(0.8),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      activity.title!,
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                    Row(
                                                      children: [

                                                           Icon( Icons.location_pin,),
                                                        Text(
                                                            activity.location!),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    Text(
                                                      "Rs.${activity.price}",
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
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
                                );
                              },
                            );
                          },
                        ),
                      ],
                    );
                  },
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
