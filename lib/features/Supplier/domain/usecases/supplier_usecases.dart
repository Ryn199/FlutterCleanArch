import 'package:dartz/dartz.dart';
import 'package:flutterclean/features/Supplier/data/models/supplier_model.dart';
import 'package:flutterclean/features/Supplier/domain/entities/supplier.dart';
import 'package:flutterclean/features/Supplier/domain/repositories/supplier_repositories.dart';

class SupplierUseCasesGetAll {
  final SupplierRepositories supplierRepositories;

  SupplierUseCasesGetAll({required this.supplierRepositories});

  Future<Either<Exception, List<Supplier>>> execute() async {
    return await supplierRepositories.getAllSupplier();
  }
}

class SupplierUseCasesGetById {
  final SupplierRepositories supplierRepositories;

  SupplierUseCasesGetById({required this.supplierRepositories});

  Future<Either<Exception, Supplier>> execute({required String id}) async {
    return await supplierRepositories.getSupplierById(id: id);
  }
}

class SupplierUseCasesAdd {
  final SupplierRepositories supplierRepositories;

  SupplierUseCasesAdd({required this.supplierRepositories});

  Future<Either<Exception, void>> execute({required SupplierModel supplier}) async {
    return await supplierRepositories.addSupplier(supplier: supplier);
  }
}

class SupplierUseCasesEdit {
  final SupplierRepositories supplierRepositories;

  SupplierUseCasesEdit({required this.supplierRepositories});

  Future<Either<Exception, void>> execute({required SupplierModel supplier}) async {
    return await supplierRepositories.editSupplier(supplier: supplier);
  }
}

class SupplierUseCasesDelete {
  final SupplierRepositories supplierRepositories;

  SupplierUseCasesDelete({required this.supplierRepositories});

  Future<Either<Exception, void>> execute({required String id}) async {
    return await supplierRepositories.deleteSupplier(id : id);
  }

}