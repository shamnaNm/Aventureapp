import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:readmore/readmore.dart';
import 'package:aventure/models/reviewrating.dart';

class UserReviewsPage extends StatefulWidget {
  @override
  _UserReviewsPageState createState() => _UserReviewsPageState();
}

class _UserReviewsPageState extends State<UserReviewsPage> {
  var uid;
  bool _isLoading = true;
  List<GenReview> userReviews = [];

  @override
  void initState() {
    super.initState();
    getCurrentUserReviews();
  }

  Future<void> getCurrentUserReviews() async {
    try {
      uid = FirebaseAuth.instance.currentUser!.uid;
      print("Current user UID: $uid"); // Debugging line
      var reviewDocs = await FirebaseFirestore.instance
          .collection('reviews')
          .where('uid', isEqualTo: uid)
          .get();
      setState(() {
        userReviews = reviewDocs.docs.map((doc) {
          print("Fetched review: ${doc.data()}"); // Debugging line
          return GenReview.fromMap(doc.data());
        }).toList();
        _isLoading = false;
      });
    } catch (e) {
      print("Error fetching user reviews: $e");
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('My Reviews',style: TextStyle(color: Colors.white),),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
        padding: EdgeInsets.all(16.0),
        child: userReviews.isEmpty
            ? Center(child: Text('You have not generated any reviews.'))
            : ListView.builder(
          itemCount: userReviews.length,
          itemBuilder: (context, index) {
            final review = userReviews[index];
            return buildReviewItem(review);
          },
        ),
      ),
    );
  }

  Widget buildReviewItem(GenReview review) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.orange.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage("assets/img/profile.png"),
                      ),
                      SizedBox(width: 15),
                      Text(
                        review.userName,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                  PopupMenuButton<String>(
                    onSelected: (String value) {
                      if (value == 'edit') {
                        // Implement edit functionality here
                      } else if (value == 'delete') {
                        // Implement delete functionality here
                      } else if (value == 'share') {
                        // Implement share functionality here
                      }
                    },
                    itemBuilder: (BuildContext context) {
                      return [
                        PopupMenuItem(
                          value: 'edit',
                          child: Row(
                            children: [
                              Icon(Icons.edit, color: Colors.black),
                              SizedBox(width: 8),
                              Text('Edit'),
                            ],
                          ),
                        ),
                        PopupMenuItem(
                          value: 'delete',
                          child: Row(
                            children: [
                              Icon(Icons.delete, color: Colors.black),
                              SizedBox(width: 8),
                              Text('Delete'),
                            ],
                          ),
                        ),
                        PopupMenuItem(
                          value: 'share',
                          child: Row(
                            children: [
                              Icon(Icons.share, color: Colors.black),
                              SizedBox(width: 8),
                              Text('Share'),
                            ],
                          ),
                        ),
                      ];
                    },
                    icon: Icon(Icons.more_vert),
                  ),
                ],
              ),
              SizedBox(height: 15),
              Row(
                children: [
                  RatingBar.builder(
                    initialRating: review.rating,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemSize: 20.0,
                    itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {},
                    ignoreGestures: true,
                  ),
                  SizedBox(width: 10),
                  Text(
                    "${review.date.day} ${_getMonthName(review.date.month)}, ${review.date.year}",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
              SizedBox(height: 5),
              ReadMoreText(
                review.reviewText,
                trimLines: 2,
                colorClickableText: Colors.blue,
                trimMode: TrimMode.Line,
                trimCollapsedText: '...Read more',
                trimExpandedText: ' Less',
                style: TextStyle(fontSize: 14, color: Colors.black),
                moreStyle: TextStyle(fontSize: 14, color: Colors.blue),
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
  String _getMonthName(int month) {
    switch (month) {
      case 1:
        return "Jan";
      case 2:
        return "Feb";
      case 3:
        return "Mar";
      case 4:
        return "Apr";
      case 5:
        return "May";
      case 6:
        return "Jun";
      case 7:
        return "Jul";
      case 8:
        return "Aug";
      case 9:
        return "Sep";
      case 10:
        return "Oct";
      case 11:
        return "Nov";
      case 12:
        return "Dec";
      default:
        return "";
    }
  }
}
