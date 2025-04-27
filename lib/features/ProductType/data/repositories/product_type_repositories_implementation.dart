import 'package:dartz/dartz.dart';
import 'package:flutterclean/features/ProductType/data/datasources/product_type_datasource.dart';
import 'package:flutterclean/features/ProductType/data/models/product_type_model.dart';
import 'package:flutterclean/features/ProductType/domain/entities/product_type.dart';
import 'package:flutterclean/features/ProductType/domain/repositories/product_type_repositories.dart';

class ProductTypeRepositoriesImplementation implements ProductTypeRepositories {
  final ProductTypeRemoteDatasource productTypeRemoteDataSource;

  ProductTypeRepositoriesImplementation({required this.productTypeRemoteDataSource});
  
  @override
  Future<Either<Exception, void>> addProductType({required ProductTypeModel productType}) async{
    try {
      final data = await productTypeRemoteDataSource.addProductType(productType: productType);
      return Right(data);
    } catch (e) {
      throw Left(Exception(e));
    }
  }
  
  @override
  Future<Either<Exception, void>> deleteProductType({required String id}) async {
    try {
      final data = await productTypeRemoteDataSource.deleteProductType(id: id);
      return Right(data);
    } catch (e) {
      throw Left(Exception(e));
    }
  }

  @override
  Future<Either<Exception, void>> editProductType(
      {required ProductTypeModel productType}) async {
    try {
      final data = await productTypeRemoteDataSource.editProductType(productType: productType);
      return Right(data);
    } catch (e) {
      throw Left(Exception(e));
    }
  }

  @override
  Future<Either<Exception, List<ProductType>>> getAllProductType() async {
    try {
      final data = await productTypeRemoteDataSource.getAllProductType();
      return Right(data);
    } catch (e) {
      throw Left(Exception(e));
    }
  }

  @override
  Future<Either<Exception, ProductType>> getProductTypeById({required String id}) async {
    try {
      final data = await productTypeRemoteDataSource.getProductTypeById(id: id);
      return Right(data);
    } catch (e) {
      throw Left(Exception(e));
    }
  }


}