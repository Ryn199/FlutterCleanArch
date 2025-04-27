import 'package:dartz/dartz.dart';
import 'package:flutterclean/features/Favorite/data/datasources/favorite_datasource.dart';
import 'package:flutterclean/features/Favorite/data/models/favorite_model.dart';
import 'package:flutterclean/features/Favorite/domain/entities/favorite.dart';
import 'package:flutterclean/features/Favorite/domain/repositories/favorite_repositories.dart';

class FavoriteRepositoriesImplementation implements FavoriteRepositories{
  final FavoriteRemoteDatasource favoriteRemoteDatasource;

  FavoriteRepositoriesImplementation({required this.favoriteRemoteDatasource});
  
  @override
  Future<Either<Exception, void>> addFavorite({required FavoriteModel favorite}) async{
    try {
      final data = await favoriteRemoteDatasource.addFavorite(favorite: favorite);
      return Right(data);
    } catch (e) {
      throw Left(Exception(e));
    }
  }
  
  @override
  Future<Either<Exception, void>> deleteFavorite({required String id}) async {
    try {
      final data = await favoriteRemoteDatasource.deleteFavorite(id: id);
      return Right(data);
    } catch (e) {
      throw Left(Exception(e));
    }
  }

  @override
  Future<Either<Exception, void>> editFavorite(
      {required FavoriteModel favorite}) async {
    try {
      final data = await favoriteRemoteDatasource.editFavorite(favorite: favorite);
      return Right(data);
    } catch (e) {
      throw Left(Exception(e));
    }
  }

  @override
  Future<Either<Exception, List<Favorite>>> getAllFavorite() async {
    try {
      final data = await favoriteRemoteDatasource.getAllFavorite();
      return Right(data);
    } catch (e) {
      throw Left(Exception(e));
    }
  }

  @override
  Future<Either<Exception, Favorite>> getFavoriteById({required String id}) async {
    try {
      final data = await favoriteRemoteDatasource.getFavoriteById(id: id);
      return Right(data);
    } catch (e) {
      throw Left(Exception(e));
    }
  }


}