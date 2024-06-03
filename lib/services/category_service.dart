import 'package:aventure/models/category_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

import 'package:uuid/uuid.dart';

class CategoryService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final CollectionReference _categoriesCollection =
  FirebaseFirestore.instance.collection('categories');

  // Add a new category
  Future<void> addCategory(CategoryModel category) async {
    try {
      String categoryId = Uuid().v4(); // Generate a unique ID
      await _categoriesCollection.doc(categoryId).set({
        'id': categoryId,
        'title': category.title,
        // Other fields can be added here if needed
      });
    } catch (e) {
      throw Exception("Failed to add category: $e");
    }
  }

  // Update an existing category
  Future<void> updateCategory(CategoryModel category) async {
    try {
      await _categoriesCollection.doc(category.id).update(category.toMap());
    } catch (e) {
      throw Exception("Failed to update category: $e");
    }
  }

  // Delete a category by id
  Future<void> deleteCategory(String categoryId) async {
    try {
      await _categoriesCollection.doc(categoryId).delete();
    } catch (e) {
      throw Exception("Failed to delete category: $e");
    }
  }

  // Get a stream of categories (optional, for real-time updates)
  Stream<List<CategoryModel>> getCategories() {
    return _categoriesCollection.snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => CategoryModel.fromDocumentSnapshot(doc))
          .toList();
    });
  }
}
