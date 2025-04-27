import 'package:dartz/dartz.dart';
import 'package:flutterclean/features/kurir/data/models/kurir_model.dart';
import 'package:flutterclean/features/kurir/domain/entities/kurir.dart';

abstract class KurirRepositories {
  Future<Either<Exception, List<Kurir>>> getAllKurir();
  Future<Either<Exception, Kurir>> getKurirById({required String id});
  Future<Either<Exception, void>> addKurir({required KurirModel kurir});
  Future<Either<Exception, void>> editKurir({required KurirModel kurir});
  Future<Either<Exception, void>> deleteKurir({required String id});
  
}