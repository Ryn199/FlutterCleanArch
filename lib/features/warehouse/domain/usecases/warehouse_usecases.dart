import 'package:dartz/dartz.dart';
import 'package:flutterclean/features/warehouse/data/models/warehouse_model.dart';
import 'package:flutterclean/features/warehouse/domain/entities/warehouse.dart';
import 'package:flutterclean/features/warehouse/domain/repositories/warehouse_repositories.dart';

class WarehouseUsecasesGetAll {
  final WarehouseRepositories warehouseRepositories;

  WarehouseUsecasesGetAll({required this.warehouseRepositories});

  Future<Either<Exception, List<Warehouse>>> execute() async {
    return await warehouseRepositories.getAllWarehouse();
  }
}

class WarehouseUsecasesGetById {
  final WarehouseRepositories warehouseRepositories;

  WarehouseUsecasesGetById({required this.warehouseRepositories});

  Future<Either<Exception, Warehouse>> execute({required String id}) async {
    return await warehouseRepositories.getWarehouseById(id: id);
  }
}

class WarehouseUsecasesAdd {
  final WarehouseRepositories warehouseRepositories;

  WarehouseUsecasesAdd({required this.warehouseRepositories});

  Future<Either<Exception, void>> execute({required WarehouseModel warehouse}) async {
    return await warehouseRepositories.addWarehouse(warehouse: warehouse);
  }
}

class WarehouseUsecasesEdit {
  final WarehouseRepositories warehouseRepositories;

  WarehouseUsecasesEdit({required this.warehouseRepositories});

  Future<Either<Exception, void>> execute({required WarehouseModel warehouse}) async {
    return await warehouseRepositories.editWarehouse(warehouse: warehouse);
  }
}

class WarehouseUsecasesDelete {
  final WarehouseRepositories warehouseRepositories;

  WarehouseUsecasesDelete({required this.warehouseRepositories});


  Future<Either<Exception, void>> execute({required String id}) async {
    return await warehouseRepositories.deleteWarehouse(id : id);
  }

}