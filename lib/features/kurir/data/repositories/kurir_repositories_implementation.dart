import 'package:dartz/dartz.dart';
import 'package:flutterclean/features/kurir/data/datasources/kurir_datasource.dart';
import 'package:flutterclean/features/kurir/data/models/kurir_model.dart';
import 'package:flutterclean/features/kurir/domain/entities/kurir.dart';
import 'package:flutterclean/features/kurir/domain/repositories/kurir_repositories.dart';

class KurirRepositoriesImplementation implements KurirRepositories{
  final KurirRemoteDatasource kurirRemoteDatasource;

  KurirRepositoriesImplementation({required this.kurirRemoteDatasource});
  
  @override
  Future<Either<Exception, void>> addKurir({required KurirModel kurir}) async{
    try {
      final data = await kurirRemoteDatasource.addKurir(kurir: kurir);
      return Right(data);
    } catch (e) {
      throw Left(Exception(e));
    }
  }
  
  @override
  Future<Either<Exception, void>> deleteKurir({required String id}) async {
    try {
      final data = await kurirRemoteDatasource.deleteKurir(id: id);
      return Right(data);
    } catch (e) {
      throw Left(Exception(e));
    }
  }

  @override
  Future<Either<Exception, void>> editKurir(
      {required KurirModel kurir}) async {
    try {
      final data = await kurirRemoteDatasource.editKurir(kurir: kurir);
      return Right(data);
    } catch (e) {
      throw Left(Exception(e));
    }
  }

  @override
  Future<Either<Exception, List<Kurir>>> getAllKurir() async {
    try {
      final data = await kurirRemoteDatasource.getAllKurir();
      return Right(data);
    } catch (e) {
      throw Left(Exception(e));
    }
  }

  @override
  Future<Either<Exception, Kurir>> getKurirById({required String id}) async {
    try {
      final data = await kurirRemoteDatasource.getKurirById(id: id);
      return Right(data);
    } catch (e) {
      throw Left(Exception(e));
    }
  }


}