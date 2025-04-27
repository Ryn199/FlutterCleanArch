import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterclean/features/ProductCategory/data/models/category_model.dart';
import 'package:flutterclean/features/ProductCategory/domain/entities/category.dart';

abstract class CategoryRemoteDatasource {
  Future<List<Category>> getAllCategory();
  Future<Category> getCategoryById({required String id});
  Future<void> addCategory({required CategoryModel category});
  Future<void> editCategory({required CategoryModel category});
  Future<void> deleteCategory({required String id});
}

class CategoryRemoteDatasourceImplementation
    implements CategoryRemoteDatasource {
  final FirebaseFirestore firebaseFirestore;

  CategoryRemoteDatasourceImplementation({required this.firebaseFirestore});

  @override
  Future<void> addCategory({required CategoryModel category}) async {
    await firebaseFirestore
        .collection('categories')
        .add(category.toFireStore());
  }

  @override
  Future<void> deleteCategory({required String id}) async {
    await firebaseFirestore.collection('categories').doc(id).delete();
  }

  @override
  Future<void> editCategory({required CategoryModel category}) async {
    await firebaseFirestore
        .collection('categories')
        .doc(category.id)
        .update(category.toFireStore());
  }

  @override
  Future<List<Category>> getAllCategory() async {
    final data = await firebaseFirestore.collection('categories').get();
    return data.docs
        .map(
          (e) => CategoryModel.fromFirestore(e),
        )
        .toList();
  }

  @override
  Future<Category> getCategoryById({required String id}) async {
    final data = await firebaseFirestore.collection('categories').doc(id).get();
    return CategoryModel.fromFirestore(data);
  }
}
