import 'package:dartz/dartz.dart';
import 'package:flutterclean/features/ProductType/data/models/product_type_model.dart';
import 'package:flutterclean/features/ProductType/domain/entities/product_type.dart';
import 'package:flutterclean/features/ProductType/domain/repositories/product_type_repositories.dart';

class ProductTypeUsecasesGetAll {
  final ProductTypeRepositories productTypeRepositories;

  ProductTypeUsecasesGetAll({required this.productTypeRepositories});

  Future<Either<Exception, List<ProductType>>> execute() async {
    return await productTypeRepositories.getAllProductType();
  }
}

class ProductTypeUsecasesGetById {
  final ProductTypeRepositories productTypeRepositories;

  ProductTypeUsecasesGetById({required this.productTypeRepositories});

  Future<Either<Exception, ProductType>> execute({required String id}) async {
    return await productTypeRepositories.getProductTypeById(id: id);
  }
}

class ProductTypeUsecasesAdd {
  final ProductTypeRepositories productTypeRepositories;

  ProductTypeUsecasesAdd({required this.productTypeRepositories});

  Future<Either<Exception, void>> execute({required ProductTypeModel productType}) async {
    return await productTypeRepositories.addProductType(productType: productType);
  }
}

class ProductTypeUsecasesEdit {
  final ProductTypeRepositories productTypeRepositories;

  ProductTypeUsecasesEdit({required this.productTypeRepositories});

  Future<Either<Exception, void>> execute({required ProductTypeModel productType}) async {
    return await productTypeRepositories.editProductType(productType: productType);
  }
}

class ProductTypeUsecasesDelete {
  final ProductTypeRepositories productTypeRepositories;

  ProductTypeUsecasesDelete({required this.productTypeRepositories});


  Future<Either<Exception, void>> execute({required String id}) async {
    return await productTypeRepositories.deleteProductType(id : id);
  }

}