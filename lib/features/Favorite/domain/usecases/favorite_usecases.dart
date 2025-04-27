import 'package:dartz/dartz.dart';
import 'package:flutterclean/features/Favorite/data/models/favorite_model.dart';
import 'package:flutterclean/features/Favorite/domain/entities/favorite.dart';
import 'package:flutterclean/features/Favorite/domain/repositories/favorite_repositories.dart';

class FavoriteUsecasesGetAll {
  final FavoriteRepositories favoriteRepositories;

  FavoriteUsecasesGetAll({required this.favoriteRepositories});

  Future<Either<Exception, List<Favorite>>> execute() async {
    return await favoriteRepositories.getAllFavorite();
  }
}

class FavoriteUsecasesGetById {
  final FavoriteRepositories favoriteRepositories;

  FavoriteUsecasesGetById({required this.favoriteRepositories});

  Future<Either<Exception, Favorite>> execute({required String id}) async {
    return await favoriteRepositories.getFavoriteById(id: id);
  }
}

class FavoriteUsecasesAdd {
  final FavoriteRepositories favoriteRepositories;

  FavoriteUsecasesAdd({required this.favoriteRepositories});

  Future<Either<Exception, void>> execute({required FavoriteModel favorite}) async {
    return await favoriteRepositories.addFavorite(favorite: favorite);
  }
}

class FavoriteUsecasesEdit {
  final FavoriteRepositories favoriteRepositories;

  FavoriteUsecasesEdit({required this.favoriteRepositories});

  Future<Either<Exception, void>> execute({required FavoriteModel favorite}) async {
    return await favoriteRepositories.editFavorite(favorite: favorite);
  }
}

class FavoriteUsecasesDelete {
  final FavoriteRepositories favoriteRepositories;

  FavoriteUsecasesDelete({required this.favoriteRepositories});

  Future<Either<Exception, void>> execute({required String id}) async {
    return await favoriteRepositories.deleteFavorite(id : id);
  }

}