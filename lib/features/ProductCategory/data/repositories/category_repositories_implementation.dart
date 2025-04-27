import 'package:dartz/dartz.dart';
import 'package:flutterclean/features/ProductCategory/data/datasources/category_datasource.dart';
import 'package:flutterclean/features/ProductCategory/data/models/category_model.dart';
import 'package:flutterclean/features/ProductCategory/domain/entities/category.dart';
import 'package:flutterclean/features/ProductCategory/domain/repositories/category_repositories.dart';

class CategoryRepositoriesImplementation implements CategoryRepositories{
  final CategoryRemoteDatasource categoryRemoteDatasource;

  CategoryRepositoriesImplementation({required this.categoryRemoteDatasource});
  
  @override
  Future<Either<Exception, void>> addCategory({required CategoryModel category}) async{
    try {
      final data = await categoryRemoteDatasource.addCategory(category: category);
      return Right(data);
    } catch (e) {
      throw Left(Exception(e));
    }
  }
  
  @override
  Future<Either<Exception, void>> deleteCategory({required String id}) async {
    try {
      final data = await categoryRemoteDatasource.deleteCategory(id: id);
      return Right(data);
    } catch (e) {
      throw Left(Exception(e));
    }
  }

  @override
  Future<Either<Exception, void>> editCategory(
      {required CategoryModel category}) async {
    try {
      final data = await categoryRemoteDatasource.editCategory(category: category);
      return Right(data);
    } catch (e) {
      throw Left(Exception(e));
    }
  }

  @override
  Future<Either<Exception, List<Category>>> getAllCategory() async {
    try {
      final data = await categoryRemoteDatasource.getAllCategory();
      return Right(data);
    } catch (e) {
      throw Left(Exception(e));
    }
  }

  @override
  Future<Either<Exception, Category>> getCategoryById({required String id}) async {
    try {
      final data = await categoryRemoteDatasource.getCategoryById(id: id);
      return Right(data);
    } catch (e) {
      throw Left(Exception(e));
    }
  }


}