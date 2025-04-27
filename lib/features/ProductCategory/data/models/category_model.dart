import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterclean/features/ProductCategory/domain/entities/category.dart';

class CategoryModel extends Category{
  const CategoryModel({
    required super.id,
    required super.categoryName,
    required super.desc,
  });

  factory CategoryModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return CategoryModel(
      id: doc.id,
      categoryName: data['categoryName'],
      desc: data['desc'],
    );
  }

  Map<String,dynamic> toFireStore() {
    return {'categoryName': categoryName, 'desc': desc};
  }
}