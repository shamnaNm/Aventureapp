import 'package:aventure/models/activity_model.dart';
import 'package:aventure/models/reviewrating.dart';
import 'package:aventure/screens/user/generatereview.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:readmore/readmore.dart';
import '../../rating/activity1rating.dart';
import '../../rating/userRevieWcard.dart';
import '../../rating/view_reviews.dart';
import '../../widgets/rating_progressindicator.dart';
import 'Activity_Booking.dart';
class ActivityPage extends StatefulWidget {
  final ActivityModel activity;
  const ActivityPage({super.key, required this.activity});
  @override
  State<ActivityPage> createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  List<GenReview> reviews = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchReviews();
  }

  // Future<void> fetchReviews() async {
  //   try {
  //     var reviewDocs = await FirebaseFirestore.instance
  //         .collection('reviews')
  //         .where('activityTitle', isEqualTo: widget.activity.title)
  //         .get();
  //     print("Number of reviews: ${reviewDocs.docs.length}");
  //     setState(() {
  //       reviews = reviewDocs.docs
  //           .map((doc) => GenReview.fromMap(doc.data()))
  //           .toList();
  //       _isLoading = false;
  //     });
  //   } catch (e) {
  //     print("Error fetching reviews: $e");
  //     setState(() {
  //       _isLoading = false;
  //     });
  //   }
  // }
  Future<void> fetchReviews() async {
    try {
      var reviewDocs = await FirebaseFirestore.instance
          .collection('reviews')
          .where('activityTitle', isEqualTo: widget.activity.title)
          .get();
      print("Number of reviews: ${reviewDocs.docs.length}");
      setState(() {
        reviews = reviewDocs.docs
            .map((doc) => GenReview.fromMap(doc.data()))
            .toList();
        _isLoading = false;
      });
    } catch (e) {
      print("Error fetching reviews: $e");
      setState(() {
        _isLoading = false;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    final activity = widget.activity;
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              height: 300,
              child: Stack(
                children: [
                  SizedBox(
                    height: 300,
                    child: Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(1),
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: NetworkImage(activity.image!),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 260,
                    left: 220,
                    right: 0,
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        "${activity.eventer} Eventers",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          fontStyle: FontStyle.italic,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    activity.title!,
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    activity.description!,
                    style: TextStyle(color: Colors.black),
                  ),
                  SizedBox(height: 15),
                  Text(
                    "Details",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 15),
                  buildInfoTile(Icons.timelapse, "Duration",
                      "About ${activity.duration} hr"),
                  SizedBox(height: 5),
                  buildInfoTile(Icons.monitor_weight_outlined,
                      "Weight restrictions", "${activity.weight}kg"),
                  SizedBox(height: 5),
                  buildInfoTile(Icons.waves_sharp, "Height above sea level",
                      "${activity.sealevel}m"),
                  SizedBox(height: 15),
                  Text(
                    "Review",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 15),
                  InkWell(
                    // onTap: () {
                    //   Navigator.pushNamed(context, '/activityreview');
                    // },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.orange.withOpacity(0.1),
                      ),
                      padding: EdgeInsets.all(20),
                      child: UserReviewCrd(),
                    ),
                  ),
                  _isLoading
                      ? Center(child: CircularProgressIndicator())
                      : ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: reviews.length,
                    itemBuilder: (context, index) {
                      final review = reviews[index];
                      return buildReviewItem(review);
                    },
                  ),

                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.orange)),
                    child: ListTile(
                      leading: Text("Add Review..."),
                      trailing: Icon(Icons.add),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                GenerateReview(activityTitle: activity.title!),
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: 100,
        decoration: BoxDecoration(
          color: Colors.orange.withOpacity(0.8),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Rs.${activity.price}\n/per Person",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  // Add your booking logic here
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ActivityBooking(
                        activity: activity,
                      ),
                    ),
                  );

                  // Get.to(() => ActivityBooking(activity: activity));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'Book Now',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange.withOpacity(0.8),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
//
  Widget buildInfoTile(IconData icon, String title, String trailing) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        trailing: Text(trailing),
      ),
    );
  }
//
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
                      if (value == 'share') {
                        // Implement edit functionality here
                      }
                    },
                    itemBuilder: (BuildContext context) {
                      return [

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
