import 'package:dartz/dartz.dart';
import 'package:flutterclean/features/ProductType/data/models/product_type_model.dart';
import 'package:flutterclean/features/ProductType/domain/entities/product_type.dart';

abstract class ProductTypeRepositories {
  Future<Either<Exception, List<ProductType>>> getAllProductType();
  Future<Either<Exception, ProductType>> getProductTypeById({required String id});
  Future<Either<Exception, void>> addProductType({required ProductTypeModel productType});
  Future<Either<Exception, void>> editProductType({required ProductTypeModel productType});
  Future<Either<Exception, void>> deleteProductType({required String id});
  
}