import 'package:dartz/dartz.dart';
import 'package:flutterclean/features/ProductCategory/data/models/category_model.dart';
import 'package:flutterclean/features/ProductCategory/domain/entities/category.dart';

abstract class CategoryRepositories {
  Future<Either<Exception, List<Category>>> getAllCategory();
  Future<Either<Exception, Category>> getCategoryById({required String id});
  Future<Either<Exception, void>> addCategory({required CategoryModel category});
  Future<Either<Exception, void>> editCategory({required CategoryModel category});
  Future<Either<Exception, void>> deleteCategory({required String id});
  
}