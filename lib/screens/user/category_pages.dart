import 'package:flutter/material.dart';

import '../../models/location_model.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  List names = ["Water", "Mountain", "Road", "Air",];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
    child: Column(
    children: [
    Text("All Items"),
    Expanded(
    child: GridView.builder(

        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          childAspectRatio: 4/2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: 4,
        itemBuilder:(context,index){

          return Container(

                    color: Colors.red,
                    child: Center(
                      child: Text(names[index]),
                    ),
                  );
        }

    ),
      ),
   ]),), );
  }
}
