import 'package:flutter/material.dart';
import 'package:aventure/models/category_model.dart';
import 'package:aventure/services/category_service.dart';
import 'package:uuid/uuid.dart';

import 'listAllcategory.dart';

class CategoryManager extends StatefulWidget {
  @override
  _CategoryManagerState createState() => _CategoryManagerState();
}

class _CategoryManagerState extends State<CategoryManager> {
  final CategoryService _categoryService = CategoryService();
  final TextEditingController _titleController = TextEditingController();

  void _addCategory() async {
    String id = Uuid().v1(); // Generate a unique ID
    String title = _titleController.text;
    if (title.isNotEmpty) {
      await _categoryService.addCategory(CategoryModel(title: title, id: id)); // Pass the generated ID
      _titleController.clear();
    }
  }

  void _navigateToActivityListPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CategoryListPage()), // Navigate to ActivityListPage
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Category Manager'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _titleController,
                    decoration: InputDecoration(
                      labelText: 'Title',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: _addCategory,
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: _navigateToActivityListPage,
            child: Text('View Category'),
          ),
        ],
      ),
    );
  }
}
