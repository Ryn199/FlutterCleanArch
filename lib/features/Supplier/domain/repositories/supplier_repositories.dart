import 'package:dartz/dartz.dart';
import 'package:flutterclean/features/Supplier/data/models/supplier_model.dart';
import 'package:flutterclean/features/Supplier/domain/entities/supplier.dart';

abstract class SupplierRepositories {
  Future<Either<Exception, List<Supplier>>> getAllSupplier();
  Future<Either<Exception, Supplier>> getSupplierById({required String id});
  Future<Either<Exception, void>> addSupplier({required SupplierModel supplier});
  Future<Either<Exception, void>> editSupplier({required SupplierModel supplier});
  Future<Either<Exception, void>> deleteSupplier({required String id});
  
}