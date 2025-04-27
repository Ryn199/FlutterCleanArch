import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutterclean/features/produk/data/models/produk_model.dart';
import 'package:flutterclean/features/produk/domain/entities/produk.dart';
import 'package:flutterclean/features/produk/domain/usecases/produk_usecases.dart';

part 'produk_event.dart';
part 'produk_state.dart';

class ProdukBloc extends Bloc<ProdukEvent, ProdukState> {
  final ProdukUsecasesAddProduk produkUsecasesAdd;
  final ProdukUsecasesEditProduk produkUsecasesEditProduk;
  final ProdukUsecasesDeleteProduk produkUsecasesDeleteProduk;
  final ProdukUsecasesGetAll produkUsecasesGetAll;
  final ProdukUsecasesGetById produkUsecasesGetById;
  ProdukBloc(
      {required this.produkUsecasesAdd,
      required this.produkUsecasesEditProduk,
      required this.produkUsecasesDeleteProduk,
      required this.produkUsecasesGetAll,
      required this.produkUsecasesGetById})
      : super(ProdukInitial()) {
    on<ProdukEventAdd>((event, emit) async {
      emit(ProdukStateLoading());
      final data = await produkUsecasesAdd.execute(produk: event.produkModel);
      data.fold(
        (l) {
          emit(ProdukStateError(message: l.toString()));
        },
        (r) {
          emit(ProdukStateSuccess());
        },
      );
    });
    on<ProdukEventEdit>((event, emit) async {
      emit(ProdukStateLoading());
      final data =
          await produkUsecasesEditProduk.execute(produk: event.produkModel);
      data.fold(
        (l) {
          emit(ProdukStateError(message: l.toString()));
        },
        (r) {
          emit(ProdukStateSuccess());
        },
      );
    });
    on<ProdukEventDelete>((event, emit) async {
      emit(ProdukStateLoading());
      final data = await produkUsecasesDeleteProduk.execute(id: event.id);
      data.fold(
        (l) {
          emit(ProdukStateError(message: l.toString()));
        },
        (r) {
          emit(ProdukStateSuccess());
        },
      );
    });
    on<ProdukEventGetAll>((event, emit) async {
      emit(ProdukStateLoading());
      final data = await produkUsecasesGetAll.execute();
      data.fold(
        (l) {
          emit(ProdukStateError(message: l.toString()));
        },
        (r) {
          emit(ProdukStateLoadedAll(produks: r));
        },
      );
    });
    on<ProdukEventGetById>((event, emit) async {
      emit(ProdukStateLoading());
      final data = await produkUsecasesGetById.execute(id: event.id);
      data.fold(
        (l) {
          emit(ProdukStateError(message: l.toString()));
        },
        (r) {
          emit(ProdukStateLoaded(produk: r));
        },
      );
    });
  }
}