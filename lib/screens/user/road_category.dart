import 'package:flutter/material.dart';

import '../../data/location_list.dart';
class RoadCatogoryPage extends StatefulWidget {
  const RoadCatogoryPage({super.key});

  @override
  State<RoadCatogoryPage> createState() => _RoadCatogoryPageState();
}

class _RoadCatogoryPageState extends State<RoadCatogoryPage> {

  List<bool> isAddedToWishlistr = List.generate(road.length, (index) => false);

  List<String> routes = [

    '/activity7',
    '/activity8',
    '/activity9',

  ]; // List


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text("Road Activities",style: TextStyle(color: Colors.white),),
      ),
      body:  Container(
        padding: EdgeInsets.all(20),
        height: double.infinity,
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            childAspectRatio: 3/2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),

          itemCount: road.length,
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
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 2,
                      offset: Offset(
                          0, 1), // changes position of shadow
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                             road[index].image.toString()),
                        ),
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
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            Column(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "${road[index].title}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  Row( children: [
                                    Icon(Icons.location_pin),
                                    Text("${road[index].location}"),],),
                                ]),
                            SizedBox(height: 8),
                            Column(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "\$${road[index].price}",
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
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isAddedToWishlistr[index] = !isAddedToWishlistr[index];
                        });
                        // Add your logic to add this activity to the wishlist
                      },
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(260.0, 10.0, 10.0, 10.0),
                        child: Icon(
                          isAddedToWishlistr[index] ? Icons.favorite :   Icons.favorite_border,
                          color: isAddedToWishlistr[index] ? Colors.red : Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),


    );
  }
}
