
import 'package:equatable/equatable.dart';
import 'package:flutterclean/features/Favorite/presentation/bloc/favorite_bloc.dart';

import '../../domain/entities/favorite.dart';

abstract class FavoriteState extends Equatable {
  void add(FavoriteEventGetAll favoriteEventGetAll) {}
}

class FavoriteInitial extends FavoriteState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class FavoriteStateLoading extends FavoriteState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class FavoriteStateError extends FavoriteState {
  final String message;

  FavoriteStateError({required this.message});
  @override
  // TODO: implement props
  List<Object?> get props => [message];
}

class FavoriteStateLoadedAll extends FavoriteState {
  final List<Favorite> favorites;

  FavoriteStateLoadedAll({required this.favorites});

  @override
  List<Object?> get props => [favorites];
}


class FavoriteStateLoaded extends FavoriteState {
  final Favorite favorite;

  FavoriteStateLoaded({required this.favorite});

  @override
  // TODO: implement props
  List<Object?> get props => [favorite];
}

class FavoriteStateSuccess extends FavoriteState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}