//
// import 'package:aventure/models/reviewrating.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:readmore/readmore.dart';
//
// class GenerateReview extends StatefulWidget {
//   final String activityTitle;
//
//   const GenerateReview({Key? key, required this.activityTitle})
//       : super(key: key);
//
//   @override
//   State<GenerateReview> createState() => _GenerateReviewState();
// }
//
// class _GenerateReviewState extends State<GenerateReview> {
//   var uid;
//   String userName = "";
//   String userImageUrl = "";
//   bool _isLoading = true;
//   double _rating = 0;
//   TextEditingController _reviewController = TextEditingController();
//   List<GenReview> reviews = [];
//
//   @override
//   void initState() {
//     super.initState();
//     getData();
//     fetchReviews();
//   }
//
//   getData() async {
//     try {
//       uid = FirebaseAuth.instance.currentUser!.uid;
//       await fetchUserDetails();
//     } catch (e) {
//       print("Error getting user data: $e");
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }
//
//   Future<void> fetchUserDetails() async {
//     try {
//       var userDoc =
//           await FirebaseFirestore.instance.collection('user').doc(uid).get();
//       if (userDoc.exists) {
//         setState(() {
//           userName = userDoc['name'];
//           userImageUrl = userDoc['imgUrl'];
//           _isLoading = false;
//         });
//       } else {
//         print("User document does not exist");
//         setState(() {
//           _isLoading = false;
//         });
//       }
//     } catch (e) {
//       print("Error fetching user details: $e");
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }
//
//   Future<void> fetchReviews() async {
//     try {
//       var reviewDocs = await FirebaseFirestore.instance
//           .collection('reviews')
//           .where('activityTitle', isEqualTo: widget.activityTitle)
//           .get();
//       setState(() {
//         reviews = reviewDocs.docs
//             .map((doc) => GenReview.fromMap(doc.data()))
//             .toList();
//       });
//     } catch (e) {
//       print("Error fetching reviews: $e");
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(),
//       body: _isLoading
//           ? Center(child: CircularProgressIndicator())
//           : Padding(
//               padding: EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'Your Rating:',
//                     style: TextStyle(fontSize: 18.0),
//                   ),
//                   SizedBox(height: 8.0),
//                   RatingBar.builder(
//                     initialRating: _rating,
//                     minRating: 1,
//                     direction: Axis.horizontal,
//                     allowHalfRating: true,
//                     itemCount: 5,
//                     itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
//                     itemBuilder: (context, _) => Icon(
//                       Icons.star,
//                       color: Colors.amber,
//                     ),
//                     onRatingUpdate: (rating) {
//                       setState(() {
//                         _rating = rating;
//                       });
//                     },
//                   ),
//                   TextFormField(
//                     controller: _reviewController,
//                     decoration: InputDecoration(labelText: 'Your Review'),
//                     maxLines: 3,
//                   ),
//                   SizedBox(height: 16.0),
//                   ElevatedButton(
//                     onPressed: userName.isEmpty ? null : () => saveReview(),
//                     child: Text('Submit Review'),
//                   ),
//                   SizedBox(height: 16.0),
//                   Expanded(
//                     child: ListView.builder(
//                       itemCount: reviews.length,
//                       itemBuilder: (context, index) {
//                         final review = reviews[index];
//                         return buildReviewItem(
//                           review,
//                           () {
//                             // Implement edit functionality here
//                           },
//                           () {
//                             // Implement delete functionality here
//                           },
//                         );
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//     );
//   }
//
//   Widget buildReviewItem(
//       GenReview review, Function() editFunction, Function() deleteFunction) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Container(
//         decoration: BoxDecoration(
//           color: Colors.orange.withOpacity(0.1),
//           borderRadius: BorderRadius.circular(12),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Column(
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Row(
//                     children: [
//                       CircleAvatar(
//                         backgroundImage: NetworkImage(userImageUrl),
//                       ),
//                       SizedBox(width: 15),
//                       Text(
//                         review.userName,
//                         style: Theme.of(context).textTheme.titleMedium,
//                       ),
//                     ],
//                   ),
//                   PopupMenuButton<String>(
//                     onSelected: (String value) {
//                       if (value == 'edit') {
//                         // Implement edit functionality here
//                       } else if (value == 'delete') {
//                         // Implement delete functionality here
//                       } else if (value == 'share') {
//                         // Implement share functionality here
//                       }
//                     },
//                     itemBuilder: (BuildContext context) {
//                       return [
//                         PopupMenuItem(
//                           value: 'edit',
//                           child: Row(
//                             children: [
//                               Icon(Icons.edit, color: Colors.black),
//                               SizedBox(width: 8),
//                               Text('Edit'),
//                             ],
//                           ),
//                         ),
//                         PopupMenuItem(
//                           value: 'delete',
//                           child: Row(
//                             children: [
//                               Icon(Icons.delete, color: Colors.black),
//                               SizedBox(width: 8),
//                               Text('Delete'),
//                             ],
//                           ),
//                         ),
//                         PopupMenuItem(
//                           value: 'share',
//                           child: Row(
//                             children: [
//                               Icon(Icons.share, color: Colors.black),
//                               SizedBox(width: 8),
//                               Text('Share'),
//                             ],
//                           ),
//                         ),
//                       ];
//                     },
//                     icon: Icon(Icons.more_vert),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 15),
//               Row(
//                 children: [
//                   RatingBar.builder(
//                     initialRating: review.rating,
//                     minRating: 1,
//                     direction: Axis.horizontal,
//                     allowHalfRating: true,
//                     itemCount: 5,
//                     itemSize: 20.0, // Adjust the size of the stars
//                     itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
//                     itemBuilder: (context, _) => Icon(
//                       Icons.star,
//                       color: Colors.amber,
//                     ),
//                     onRatingUpdate: (rating) {
//                       // Do nothing
//                     },
//                     ignoreGestures: true, // Prevent user interaction
//                   ),
//                   SizedBox(width: 10),
//                   Text(
//                     "${review.date.day} ${_getMonthName(review.date.month)}, ${review.date.year}",
//                     style: Theme.of(context).textTheme.bodySmall,
//                   ),
//                 ],
//               ),
//               SizedBox(height: 5),
//               ReadMoreText(
//                 review.reviewText,
//                 trimLines: 2,
//                 colorClickableText: Colors.blue,
//                 trimMode: TrimMode.Line,
//                 trimCollapsedText: '...Read more',
//                 trimExpandedText: ' Less',
//                 style: TextStyle(fontSize: 14, color: Colors.black),
//                 moreStyle: TextStyle(fontSize: 14, color: Colors.blue),
//               ),
//               SizedBox(height: 10),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   void saveReview() async {
//     final String reviewText = _reviewController.text.trim();
//     if (reviewText.isNotEmpty && userName.isNotEmpty) {
//       final newReview = GenReview(
//         uid: uid,
//        // userImageUrl:userImageUrl,
//         userName: userName,
//         rating: _rating,
//         reviewText: reviewText,
//         date: DateTime.now(),
//         activityTitle: widget.activityTitle, // Include the activity title
//       );
//
//       try {
//         await FirebaseFirestore.instance
//             .collection('reviews')
//             .add(newReview.toMap());
//         setState(() {
//           reviews.add(newReview);
//           _reviewController.clear();
//           _rating = 0;
//         });
//       } catch (e) {
//         print("Error saving review: $e");
//       }
//     } else {
//       print("Review text or user name is empty");
//     }
//   }
//
//   String _getMonthName(int month) {
//     switch (month) {
//       case 1:
//         return "Jan";
//       case 2:
//         return "Feb";
//       case 3:
//         return "Mar";
//       case 4:
//         return "Apr";
//       case 5:
//         return "May";
//       case 6:
//         return "Jun";
//       case 7:
//         return "Jul";
//       case 8:
//         return "Aug";
//       case 9:
//         return "Sep";
//       case 10:
//         return "Oct";
//       case 11:
//         return "Nov";
//       case 12:
//         return "Dec";
//       default:
//         return "";
//     }
//   }
// }
import 'package:aventure/models/reviewrating.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:readmore/readmore.dart';

class GenerateReview extends StatefulWidget {
  final String activityTitle;

  const GenerateReview({Key? key, required this.activityTitle})
      : super(key: key);

  @override
  State<GenerateReview> createState() => _GenerateReviewState();
}

class _GenerateReviewState extends State<GenerateReview> {
  var uid;
  String userName = "";
  String userImageUrl = "";
  bool _isLoading = true;
  double _rating = 0;
  TextEditingController _reviewController = TextEditingController();
  List<GenReview> reviews = [];

  @override
  void initState() {
    super.initState();
    getData();
    fetchReviews();
  }

  getData() async {
    try {
      uid = FirebaseAuth.instance.currentUser!.uid;
      await fetchUserDetails();
    } catch (e) {
      print("Error getting user data: $e");
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> fetchUserDetails() async {
    try {
      var userDoc =
      await FirebaseFirestore.instance.collection('user').doc(uid).get();
      if (userDoc.exists) {
        setState(() {
          userName = userDoc['name'];
          userImageUrl = userDoc['imgUrl'];
          _isLoading = false;
        });
      } else {
        print("User document does not exist");
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      print("Error fetching user details: $e");
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> fetchReviews() async {
    try {
      var reviewDocs = await FirebaseFirestore.instance
          .collection('reviews')
          .where('activityTitle', isEqualTo: widget.activityTitle)
          .get();
      setState(() {
        reviews = reviewDocs.docs
            .map((doc) => GenReview.fromMap(doc.data()))
            .toList();
      });
    } catch (e) {
      print("Error fetching reviews: $e");
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Generate Review with Rating", style: TextStyle(color: Colors.white)),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Your Rating:',
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 8.0),
            RatingBar.builder(
              initialRating: _rating,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
                setState(() {
                  _rating = rating;
                });
              },
            ),
            TextFormField(
              controller: _reviewController,
              decoration: InputDecoration(labelText: 'Your Review'),
              maxLines: 3,
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: userName.isEmpty ? null : () => saveReview(),
              child: Text('Submit Review'),
            ),
            SizedBox(height: 16.0),
            Expanded(
              child: ListView.builder(
                itemCount: reviews.length,
                itemBuilder: (context, index) {
                  final review = reviews[index];
                  return buildReviewItem(
                    review,
                        () {
                      // Implement edit functionality here
                    },
                        () {
                      // Implement delete functionality here
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildReviewItem(
      GenReview review, Function() editFunction, Function() deleteFunction) {
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
                        backgroundImage: NetworkImage(review.userImageUrl),
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
                        // PopupMenuItem(
                        //   value: 'edit',
                        //   child: Row(
                        //     children: [
                        //       Icon(Icons.edit, color: Colors.black),
                        //       SizedBox(width: 8),
                        //       Text('Edit'),
                        //     ],
                        //   ),
                        // ),
                        // PopupMenuItem(
                        //   value: 'delete',
                        //   child: Row(
                        //     children: [
                        //       Icon(Icons.delete, color: Colors.black),
                        //       SizedBox(width: 8),
                        //       Text('Delete'),
                        //     ],
                        //   ),
                        // ),
                        // PopupMenuItem(
                        //   value: 'share',
                        //   child: Row(
                        //     children: [
                        //       Icon(Icons.share, color: Colors.black),
                        //       SizedBox(width: 8),
                        //       Text('Share'),
                        //     ],
                        //   ),
                        // ),
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
                    itemSize: 20.0, // Adjust the size of the stars
                    itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {
                      // Do nothing
                    },
                    ignoreGestures: true, // Prevent user interaction
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

  void saveReview() async {
    final String reviewText = _reviewController.text.trim();
    if (reviewText.isNotEmpty && userName.isNotEmpty && _rating > 0) {
      try {
        final review = GenReview(
          userName: userName,
          rating: _rating,
          reviewText: reviewText,
          date: DateTime.now(),
          activityTitle: widget.activityTitle,
          uid: uid,
          userImageUrl: userImageUrl, // Add this field
        );

        await FirebaseFirestore.instance
            .collection('reviews')
            .add(review.toMap());

        setState(() {
          reviews.add(review);
          _reviewController.clear();
          _rating = 0;
        });
      } catch (e) {
        print("Error saving review: $e");
      }
    }
  }

  String _getMonthName(int monthNumber) {
    const months = [
      '',
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];
    return months[monthNumber];
  }
}
