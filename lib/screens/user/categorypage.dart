
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:aventure/models/category_model.dart';
import 'package:aventure/screens/user/cat_activitypage.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({Key? key}) : super(key: key);
  @override
  _CategoriesPageState createState() => _CategoriesPageState();
}
class _CategoriesPageState extends State<CategoriesPage> {
  late Future<List<CategoryModel>> _categoryFuture;
  @override
  void initState() {
    super.initState();
    _categoryFuture = fetchCategories();
  }
  Future<List<CategoryModel>> fetchCategories() async {
    try {
      QuerySnapshot querySnapshot =
      await FirebaseFirestore.instance.collection('categories').get();
      return querySnapshot.docs
          .map((doc) => CategoryModel.fromDocumentSnapshot(doc))
          .toList();
    } catch (e) {
      print('Error fetching categories: $e');
      throw Exception('Failed to fetch categories');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Categories',style: TextStyle(color: Colors.white),),
      ),
      body: FutureBuilder<List<CategoryModel>>(
        future: _categoryFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 4 / 2,
                  crossAxisCount: 2, // Number of columns
                  crossAxisSpacing: 10.0, // Spacing between columns
                  mainAxisSpacing: 10.0, // Spacing between rows
                ),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final category = snapshot.data![index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CategoryActivitiesPage(
                            title: category.title ?? '', // Assuming title is a field in CategoryModel
                          ),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Center(
                        child: Text(category.title ?? ''),
                      ),
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}
