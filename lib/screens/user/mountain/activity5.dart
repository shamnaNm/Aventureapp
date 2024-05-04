import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../data/location_list.dart';

import '../water/Activity_Booking.dart';
import '../water/activity_two_booking.dart';
import 'booking_five.dart';


class ActivityFivePage extends StatefulWidget {
  const ActivityFivePage({super.key});

  @override
  State<ActivityFivePage> createState() => _ActivityFivePageState();
}

class _ActivityFivePageState extends State<ActivityFivePage> {
  List<String> reviews = [
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body:
      CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: true,
            child:Container(
              height: double.infinity,
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
                                    image: AssetImage(
                                        mountain[1].image.toString()))),
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
                                "${mountain[1].title}",
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
                                "${mountain[1].description}",
                                style: TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5,
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
                            height: 5,
                          ),
                          //
                          // ListTile(
                          //   leading: Icon(Icons.timelapse),
                          //   title: Text("Duration"),
                          //   trailing: Text("About ${mountain[1].duration} hr"),
                          // ),
                          // SizedBox(
                          //   height: 5,
                          // ),
                          // ListTile(
                          //
                          //   leading: Icon(Icons.monitor_weight_outlined),
                          //   title: Text("Weight restrictions"),
                          //   trailing: Text("${mountain[1].duration}"),
                          // ),
                          // SizedBox(
                          //   height: 5,
                          // ),
                          // ListTile(
                          //   leading: Icon(Icons.waves_sharp),
                          //   title: Text("Height above sea level"),
                          //   trailing: Text("${mountain[1].duration}"),
                          // ),
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
                            height: 5,
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
                          Column(
                            children: [
                              Container(
                                color: Colors.orange,
                                height: 180,
                              ),

                            ],
                          )

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
          color: Colors.white,
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
                "\$${mountain[1].price}\n/per Person",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  // Add your booking logic here
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ActivityFiveBooking(title: ''),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
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
                    color: Colors.white,
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