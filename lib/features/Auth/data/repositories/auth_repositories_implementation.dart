import 'package:dartz/dartz.dart';

import '../../domain/entities/users.dart';
import '../../domain/repositories/users_repositories.dart';
import '../datasources/auth_datasource.dart';

class AuthRepositoriesImplementation implements AuthRepository {
  final AuthRemoteDataSource dataSource;

  AuthRepositoriesImplementation({required this.dataSource});
  @override
  Future<Either<Exception, UserEntity>> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      final data = await dataSource.signInWithEmailAndPassword(email, password);
      return Right(data);
    } catch (e) {
      return Left(Exception(e.toString()));
    }
  }

  @override
  Future<Either<Exception, UserEntity>> signInWithGoogle() {
    throw UnimplementedError();
  }

  @override
  Future<Either<Exception, void>> signOut() {
    throw UnimplementedError();
  }

  @override
  Future<Either<Exception, UserEntity>> createUserWithEmailAndPassword(
      String name, String email, String password) async {
    try {
      final data = await dataSource.createUserWithEmailAndPassword(
          name, email, password);
      return Right(data);
    } catch (e) {
      return Left(Exception(e.toString()));
    }
  }
}
