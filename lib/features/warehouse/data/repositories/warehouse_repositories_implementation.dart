import 'package:dartz/dartz.dart';
import 'package:flutterclean/features/warehouse/data/datasources/warehouse_datasource.dart';
import 'package:flutterclean/features/warehouse/data/models/warehouse_model.dart';
import 'package:flutterclean/features/warehouse/domain/entities/warehouse.dart';
import 'package:flutterclean/features/warehouse/domain/repositories/warehouse_repositories.dart';

class WarehouseRepositoriesImplementation implements WarehouseRepositories {
  final WarehouseRemoteDatasource warehouseRemoteDataSource;

  WarehouseRepositoriesImplementation({required this.warehouseRemoteDataSource});

  
  @override
  Future<Either<Exception, void>> addWarehouse({required WarehouseModel warehouse}) async{
    try {
      final data = await warehouseRemoteDataSource.addWarehouse(warehouse: warehouse);
      return Right(data);
    } catch (e) {
      throw Left(Exception(e));
    }
  }
  
  @override
  Future<Either<Exception, void>> deleteWarehouse({required String id}) async {
    try {
      final data = await warehouseRemoteDataSource.deleteWarehouse(id: id);
      return Right(data);
    } catch (e) {
      throw Left(Exception(e));
    }
  }

  @override
  Future<Either<Exception, void>> editWarehouse(
      {required WarehouseModel warehouse}) async {
    try {
      final data = await warehouseRemoteDataSource.editWarehouse(warehouse: warehouse);
      return Right(data);
    } catch (e) {
      throw Left(Exception(e));
    }
  }

  @override
  Future<Either<Exception, List<Warehouse>>> getAllWarehouse() async {
    try {
      final data = await warehouseRemoteDataSource.getAllWarehouse();
      return Right(data);
    } catch (e) {
      throw Left(Exception(e));
    }
  }

  @override
  Future<Either<Exception, Warehouse>> getWarehouseById({required String id}) async {
    try {
      final data = await warehouseRemoteDataSource.getWarehouseById(id: id);
      return Right(data);
    } catch (e) {
      throw Left(Exception(e));
    }
  }


}