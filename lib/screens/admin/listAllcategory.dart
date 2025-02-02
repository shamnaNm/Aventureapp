import 'package:flutter/material.dart';
import 'package:aventure/models/category_model.dart';
import 'package:aventure/services/category_service.dart';

class CategoryListPage extends StatefulWidget {
  @override
  _CategoryListPageState createState() => _CategoryListPageState();
}

class _CategoryListPageState extends State<CategoryListPage> {
  final CategoryService _categoryService = CategoryService();

  void _deleteCategory(String id) async {
    await _categoryService.deleteCategory(id);
  }

  Future<void> _editCategory(CategoryModel category) async {
    String? newTitle = await showDialog<String?>(
      context: context,
      builder: (BuildContext context) {
        final TextEditingController _titleController = TextEditingController();
        _titleController.text = category.title ?? '';

        return AlertDialog(
          title: Text('Edit Category'),
          content: TextField(
            controller: _titleController,
            decoration: InputDecoration(labelText: 'Title'),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(null);
              },
            ),
            TextButton(
              child: Text('Save'),
              onPressed: () {
                Navigator.of(context).pop(_titleController.text);
              },
            ),
          ],
        );
      },
    );

    if (newTitle != null && newTitle.isNotEmpty) {
      category.title = newTitle;
      await _categoryService.updateCategory(category);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Category List',style: TextStyle(color: Colors.white),),
      ),
      body: StreamBuilder<List<CategoryModel>>(
        stream: _categoryService.getCategories(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          final categories = snapshot.data ?? [];

          return ListView.builder(
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final category = categories[index];
              return Container(
                margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  leading: Icon(Icons.category, color: Colors.orange),
                  title: Text(
                    category.title ?? '',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),

                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.edit, color: Colors.green),
                        onPressed: () => _editCategory(category),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _deleteCategory(category.id!),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
