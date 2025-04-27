import 'package:dartz/dartz.dart';
import 'package:flutterclean/features/warehouse/data/models/warehouse_model.dart';
import 'package:flutterclean/features/warehouse/domain/entities/warehouse.dart';

abstract class WarehouseRepositories {
  Future<Either<Exception, List<Warehouse>>> getAllWarehouse();
  Future<Either<Exception, Warehouse>> getWarehouseById({required String id});
  Future<Either<Exception, void>> addWarehouse({required WarehouseModel warehouse});
  Future<Either<Exception, void>> editWarehouse({required WarehouseModel warehouse});
  Future<Either<Exception, void>> deleteWarehouse({required String id});
  
}