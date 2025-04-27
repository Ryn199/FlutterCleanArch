import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutterclean/features/Favorite/data/models/favorite_model.dart';
import 'package:flutterclean/features/Favorite/domain/usecases/favorite_usecases.dart';
import 'package:flutterclean/features/Favorite/presentation/bloc/favorite_state.dart';

part 'favorite_event.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  final FavoriteUsecasesAdd favoriteUsecasesAdd;
  final FavoriteUsecasesEdit favoriteUsecasesEdit;
  final FavoriteUsecasesDelete favoriteUsecasesDelete;
  final FavoriteUsecasesGetAll favoriteUsecasesGetAll;
  final FavoriteUsecasesGetById favoriteUsecasesGetById;
  FavoriteBloc(
      {required this.favoriteUsecasesAdd,
      required this.favoriteUsecasesEdit,
      required this.favoriteUsecasesDelete,
      required this.favoriteUsecasesGetAll,
      required this.favoriteUsecasesGetById})
      : super(FavoriteInitial()) {
    on<FavoriteEventAdd>((event, emit) async {
      emit(FavoriteStateLoading());
      final data = await favoriteUsecasesAdd.execute(favorite: event.favoriteModel);
      data.fold(
        (l) {
          emit(FavoriteStateError(message: l.toString()));
        },
        (r) {
          emit(FavoriteStateSuccess());
        },
      );
    });
    on<FavoriteEventEdit>((event, emit) async {
      emit(FavoriteStateLoading());
      final data =
          await favoriteUsecasesEdit.execute(favorite: event.favoriteModel);
      data.fold(
        (l) {
          emit(FavoriteStateError(message: l.toString()));
        },
        (r) {
          emit(FavoriteStateSuccess());
        },
      );
    });
    on<FavoriteEventDelete>((event, emit) async {
      emit(FavoriteStateLoading());
      final data = await favoriteUsecasesDelete.execute(id: event.id);
      data.fold(
        (l) {
          emit(FavoriteStateError(message: l.toString()));
        },
        (r) {
          emit(FavoriteStateSuccess());
        },
      );
    });
    on<FavoriteEventGetAll>((event, emit) async {
      emit(FavoriteStateLoading());
      final data = await favoriteUsecasesGetAll.execute();
      data.fold(
        (l) {
          emit(FavoriteStateError(message: l.toString()));
        },
        (r) {
          emit(FavoriteStateLoadedAll(favorites: r));
        },
      );
    });
    on<FavoriteEventGetById>((event, emit) async {
      emit(FavoriteStateLoading());
      final data = await favoriteUsecasesGetById.execute(id: event.id);
      data.fold(
        (l) {
          emit(FavoriteStateError(message: l.toString()));
        },
        (r) {
          emit(FavoriteStateLoaded(favorite: r));
        },
      );
    });
  }
}
