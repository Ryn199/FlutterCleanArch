import 'package:dartz/dartz.dart';
import 'package:flutterclean/features/ProductCategory/data/models/category_model.dart';
import 'package:flutterclean/features/ProductCategory/domain/entities/category.dart';
import 'package:flutterclean/features/ProductCategory/domain/repositories/category_repositories.dart';

class CategoryUsecasesGetAll {
  final CategoryRepositories categoryRepositories;

  CategoryUsecasesGetAll({required this.categoryRepositories});

  Future<Either<Exception, List<Category>>> execute() async {
    return await categoryRepositories.getAllCategory();
  }
}

class CategoryUsecasesGetById {
  final CategoryRepositories categoryRepositories;

  CategoryUsecasesGetById({required this.categoryRepositories});

  Future<Either<Exception, Category>> execute({required String id}) async {
    return await categoryRepositories.getCategoryById(id: id);
  }
}

class CategoryUsecasesAdd {
  final CategoryRepositories categoryRepositories;

  CategoryUsecasesAdd({required this.categoryRepositories});

  Future<Either<Exception, void>> execute({required CategoryModel category}) async {
    return await categoryRepositories.addCategory(category: category);
  }
}

class CategoryUsecasesEdit {
  final CategoryRepositories categoryRepositories;

  CategoryUsecasesEdit({required this.categoryRepositories});

  Future<Either<Exception, void>> execute({required CategoryModel category}) async {
    return await categoryRepositories.editCategory(category: category);
  }
}

class CategoryUsecasesDelete {
  final CategoryRepositories categoryRepositories;

  CategoryUsecasesDelete({required this.categoryRepositories});

  Future<Either<Exception, void>> execute({required String id}) async {
    return await categoryRepositories.deleteCategory(id : id);
  }

}