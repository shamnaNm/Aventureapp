import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../data/location_list.dart';
import '../../../rating/userRevieWcard.dart';

import '../../../rating/view_reviews.dart';
import 'Activity_Booking.dart';

class ActivityPage extends StatefulWidget {
  const ActivityPage({super.key});

  @override
  State<ActivityPage> createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  List<String> reviews = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: ListView.builder(
                        itemExtent: 300,
                        itemCount: 1,
                        itemBuilder: (context, index) {
                          return Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(1),
                                image: DecorationImage(
                                    fit: BoxFit.fill,
                                  image: AssetImage(water[0].image.toString()),)),
                          );
                        }),
                  ),
                  Positioned(
                    top: 300,
                    left: 0,
                    right: 0,
                    child: Container(
                      padding: EdgeInsets.all(10),
                      height: 800,
                      width: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                        color: Colors.white,
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                "${water[0].title}",
                                style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "${water[0].description}",
                                style: TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              Text("Details",
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black)),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),

                          Container(
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            // Set the background color of the container
                            child: ListTile(
                              leading: Icon(Icons.timelapse),
                              title: Text("Duration"),
                              trailing: Text("About ${water[0].duration} hr"),
                            ),
                          ),

                          SizedBox(
                            height: 5,
                          ),

                          Container(
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            // Set the background color of the container
                            child: ListTile(
                              leading: Icon(Icons.monitor_weight_outlined),
                              title: Text("Weight restrictions"),
                              trailing: Text("${water[0].duration}"),
                            ),
                          ),

                          SizedBox(
                            height: 5,
                          ),

                          Container(
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            // Set the background color of the container
                            child: ListTile(
                              leading: Icon(Icons.waves_sharp),
                              title: Text("Height above sea level"),
                              trailing: Text("${water[0].duration}"),
                            ),
                          ),

                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              Text("Reviews",
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black)),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Column(
                            children: [
                              InkWell(
                                onTap: () async {
                                  final newReview = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ActivityReviewPage(),
                                    ),
                                  );
                                  if (newReview != null) {
                                    setState(() {
                                      reviews.add(newReview);
                                    });
                                  }
                                },
                                child:
                                   Column(
                                     children: [
                                       Container

                                         (
                                           decoration:BoxDecoration(
                                             borderRadius: BorderRadius.circular(15),color: Colors.orange.withOpacity(0.1),
                                           ),
                                           padding: EdgeInsets.all(20),
                                           child: UserReviewCrd(),
                                        ),

                                     ],
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
                "\$${water[0].price}\n/per Person",
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
                      builder: (context) => ActivityBooking(title: ''),
                    ),
                  );
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
}