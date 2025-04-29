import 'package:dartz/dartz.dart';
import 'package:flutterclean/features/Supplier/data/datasources/supplier_datasource.dart';
import 'package:flutterclean/features/Supplier/data/models/supplier_model.dart';
import 'package:flutterclean/features/Supplier/domain/entities/supplier.dart';
import 'package:flutterclean/features/Supplier/domain/repositories/supplier_repositories.dart';

class SupplierRepositoriesImplementation implements SupplierRepositories{
  final SupplierRemoteDatasource supplierRemoteDatasource;

  SupplierRepositoriesImplementation({required this.supplierRemoteDatasource});
  
  @override
  Future<Either<Exception, void>> addSupplier({required SupplierModel supplier}) async{
    try {
      final data = await supplierRemoteDatasource.addSupplier(supplier: supplier);
      return Right(data);
    } catch (e) {
      throw Left(Exception(e));
    }
  }
  
  @override
  Future<Either<Exception, void>> deleteSupplier({required String id}) async {
    try {
      final data = await supplierRemoteDatasource.deleteSupplier(id: id);
      return Right(data);
    } catch (e) {
      throw Left(Exception(e));
    }
  }

  @override
  Future<Either<Exception, void>> editSupplier(
      {required SupplierModel supplier}) async {
    try {
      final data = await supplierRemoteDatasource.editSupplier(supplier: supplier);
      return Right(data);
    } catch (e) {
      throw Left(Exception(e));
    }
  }

  @override
  Future<Either<Exception, List<Supplier>>> getAllSupplier() async {
    try {
      final data = await supplierRemoteDatasource.getAllSupplier();
      return Right(data);
    } catch (e) {
      throw Left(Exception(e));
    }
  }

  @override
  Future<Either<Exception, Supplier>> getSupplierById({required String id}) async {
    try {
      final data = await supplierRemoteDatasource.getSupplierById(id: id);
      return Right(data);
    } catch (e) {
      throw Left(Exception(e));
    }
  }


}