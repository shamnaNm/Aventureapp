
import 'package:flutter/material.dart';

import '../../data/category_list.dart';
import '../../data/location_list.dart';
import '../../models/category_model.dart';
import '../../models/location_model.dart';
import '../../models/wishlist_model.dart';
import '../../widgets/sliderhomebanner.dart';
import 'category_pages.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({Key? key}) : super(key: key);

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  List<bool> isAddedToWishlist = List.generate(water.length, (index) => false);

  TextEditingController _searchController = TextEditingController();
  int selectedCategoryIndex = -1;
  final Map<String, List<LocationModel>> categoryImages = {
    "Water": water,
    "Mountain": mountain,
    "Road": road,
    "Air": air,
    "Valley": [], // Add images for the Valley category if available
  };
  
  List<String> routes = [
    '/activity1',
    '/activity2',
    '/activity3',
    '/activity4',
    '/activity5',
    '/activity6',
    '/activity7',
    '/activity8',
    '/activity9',
    '/activity10',
    '/activity11',
    '/activity12',
  ]; // List of routes corresponding to each image

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.orange),
        toolbarHeight: 80,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Find your favourite \nactivity",
              style: TextStyle(
                color: Colors.orange.withOpacity(0.8),
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        //Color(0xffeae2b7),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: CircleAvatar(
              radius: 30,
              backgroundImage: AssetImage(
                  'assets/img/profile.png'), // Replace with actual image asset
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: EdgeInsets.all(20),
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search Activity...',
                      hintStyle: TextStyle(color: Colors.orange),
                      suffixIcon: Icon(
                        Icons.search,
                        color: Colors.orange,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.grey.withOpacity(0.4)),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                            color: Colors.orange), // Border color when focused
                      ),
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 12.0, horizontal: 16.0),
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
                            fontWeight: FontWeight.w700),
                      ),
                      Row(
                        children: [
                          Text("See All",
                              style: TextStyle(
                                  color: Colors.orange.withOpacity(0.8),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700)),
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
                  Container(
                    height: 45,

                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: categoryList.length,
                      itemBuilder: (context, index) {
                        final CategoryModel category = categoryList[index];
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
                                  category.title.toString(),
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
                  Container(
                    child:  MyPromoSlider(banners: ['assets/img/banner.png','assets/img/banner.png','assets/img/banner.png'],),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text("On Watersport"),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    height: 200,
                    child: ListView.builder(
                      itemExtent: 300,
                      scrollDirection: Axis.horizontal,
                      itemCount: water.length,
                      itemBuilder: (context, index) {
                        final adjustedIndex = index;
                        return GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              routes[adjustedIndex],
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
                                      image: AssetImage(water[index].image.toString()),
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
                                                "${water[index].title}",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                ),
                                              ),
                                              Row( children: [
                                              Icon(Icons.location_pin),
                                              Text("${water[index].location}"),],),
                                            ]),
                                        SizedBox(height: 8),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "\$${water[index].price}",
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
                                      isAddedToWishlist[index] = !isAddedToWishlist[index];
                                    });
                                    // Add your logic to add this activity to the wishlist
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(240.0, 10.0, 10.0, 10.0),
                                    child: Icon(
                                      isAddedToWishlist[index] ? Icons.favorite :   Icons.favorite_border,
                                      color: isAddedToWishlist[index] ? Colors.red : Colors.white,
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
                  SizedBox(
                    height: 20,
                  ),
                  Text("On mountain"),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    height: 200,
                    child: ListView.builder(
                      itemExtent: 300,
                      scrollDirection: Axis.horizontal,
                      itemCount: mountain.length,
                      itemBuilder: (context, index) {
                        final adjustedIndex = water.length + index;
                        return GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              routes[adjustedIndex],
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
                                      image: AssetImage(mountain[index].image.toString()),
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
                                                "${mountain[index].title}",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                ),
                                              ),
                                              Row( children: [
                                                Icon(Icons.location_pin),
                                                Text("${mountain[index].location}"),],),
                                            ]),
                                        SizedBox(height: 8),
                                        Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "\$${mountain[index].price}",
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
                                    // Add your logic to add this activity to the wishlist
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(240.0, 10.0, 10.0, 10.0),
                                    child: Icon(
                                      Icons.favorite_border,
                                      color: Colors.white,
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
                  SizedBox(
                    height: 20,
                  ),
                  Text("On road"),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    height: 200,
                    child: ListView.builder(
                      itemExtent: 300,
                      scrollDirection: Axis.horizontal,
                      itemCount: road.length,
                      itemBuilder: (context, index) {
                        final adjustedIndex = water.length + mountain.length + index;
                        return GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              routes[adjustedIndex],
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
                                    // Add your logic to add this activity to the wishlist
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(240.0, 10.0, 10.0, 10.0),
                                    child: Icon(
                                      Icons.favorite_border,
                                      color: Colors.white,
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
                  SizedBox(
                    height: 20,
                  ),
                  Text("On air"),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    height: 200,
                    child: ListView.builder(
                      itemExtent: 300,
                      scrollDirection: Axis.horizontal,
                      itemCount: air.length,
                      itemBuilder: (context, index) {
                        final adjustedIndex =
                            water.length + mountain.length + road.length + index;
                        return GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              routes[adjustedIndex],
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
                                      image: AssetImage(air[index].image.toString()),
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
                                                "${air[index].title}",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                ),
                                              ),
                                              Row( children: [
                                                Icon(Icons.location_pin),
                                                Text("${air[index].location}"),],),
                                            ]),
                                        SizedBox(height: 8),
                                        Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "\$${air[index].price}",
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
                                    // Add your logic to add this activity to the wishlist
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(240.0, 10.0, 10.0, 10.0),
                                    child: Icon(
                                      Icons.favorite_border,
                                      color: Colors.white,
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
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
