import 'package:dartz/dartz.dart';
import 'package:flutterclean/features/Favorite/data/models/favorite_model.dart';
import 'package:flutterclean/features/Favorite/domain/entities/favorite.dart';


abstract class FavoriteRepositories {
  Future<Either<Exception, List<Favorite>>> getAllFavorite();
  Future<Either<Exception, Favorite>> getFavoriteById({required String id});
  Future<Either<Exception, void>> addFavorite({required FavoriteModel favorite});
  Future<Either<Exception, void>> editFavorite({required FavoriteModel favorite});
  Future<Either<Exception, void>> deleteFavorite({required String id});
  
}