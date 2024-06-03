import 'package:aventure/screens/user/cat_activitypage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:aventure/models/category_model.dart';
import 'package:aventure/screens/user/allcategoryactivity.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({Key? key}) : super(key: key);

  @override
  _CategoriesPageState createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  late List<CategoryModel> categories = [];

  @override
  void initState() {
    super.initState();
    _fetchCategoriesById();
  }
  //
  // Future<void> _fetchCategories() async {
  //   try {
  //     QuerySnapshot categorySnapshot =
  //     await FirebaseFirestore.instance.collection('categories').get();
  //     setState(() {
  //       categories = categorySnapshot.docs
  //           .map((doc) => CategoryModel.fromDocumentSnapshot(doc))
  //           .toList();
  //     });
  //   } catch (e) {
  //     print('Error fetching categories: $e');
  //   }
  // }
  Future<void> _fetchCategoriesById() async {
    try {
      QuerySnapshot categorySnapshot = await FirebaseFirestore.instance.collection('categories').get();
      setState(() {
        categories = categorySnapshot.docs.map((doc) => CategoryModel.fromDocumentSnapshot(doc)).toList();
      });
    } catch (e) {
      print('Error fetching categories: $e');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Categories',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: categories.isEmpty
          ? Center(
        child: CircularProgressIndicator(),
      )
          : GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        padding: EdgeInsets.all(10),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          CategoryModel category = categories[index];
          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => CategoryActivitiesPage(
                    categoryId: category.id!,
                    categoryTitle: category.title!,
                  ),
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey[200],
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 2,
                    offset: Offset(0, 1),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  category.title ?? '',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}