import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutterclean/features/cart/data/models/cart_model.dart';
import 'package:flutterclean/features/cart/domain/usecases/cart_usecases.dart';
import 'package:flutterclean/features/cart/presentation/bloc/cart_state.dart';

part 'cart_event.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartUsecasesAdd cartUsecasesAdd;
  final CartUsecasesEdit cartUsecasesEdit;
  final CartUsecasesDelete cartUsecasesDelete;
  final CartUsecasesGetAll cartUsecasesGetAll;
  final CartUsecasesGetById cartUsecasesGetById;
  CartBloc(
      {required this.cartUsecasesAdd,
      required this.cartUsecasesEdit,
      required this.cartUsecasesDelete,
      required this.cartUsecasesGetAll,
      required this.cartUsecasesGetById})
      : super(CartInitial()) {
    on<CartEventAdd>((event, emit) async {
      emit(CartStateLoading());
      final data = await cartUsecasesAdd.execute(cart: event.cartModel);
      data.fold(
        (l) {
          emit(CartStateError(message: l.toString()));
        },
        (r) {
          emit(CartStateSuccess());
        },
      );
    });
    on<CartEventEdit>((event, emit) async {
      emit(CartStateLoading());
      final data =
          await cartUsecasesEdit.execute(cart: event.cartModel);
      data.fold(
        (l) {
          emit(CartStateError(message: l.toString()));
        },
        (r) {
          emit(CartStateSuccess());
        },
      );
    });
    on<CartEventDelete>((event, emit) async {
      emit(CartStateLoading());
      final data = await cartUsecasesDelete.execute(id: event.id);
      data.fold(
        (l) {
          emit(CartStateError(message: l.toString()));
        },
        (r) {
          emit(CartStateSuccess());
        },
      );
    });
    on<CartEventGetAll>((event, emit) async {
      emit(CartStateLoading());
      final data = await cartUsecasesGetAll.execute();
      data.fold(
        (l) {
          emit(CartStateError(message: l.toString()));
        },
        (r) {
          emit(CartStateLoadedAll(carts: r));
        },
      );
    });
    on<CartEventGetById>((event, emit) async {
      emit(CartStateLoading());
      final data = await cartUsecasesGetById.execute(id: event.id);
      data.fold(
        (l) {
          emit(CartStateError(message: l.toString()));
        },
        (r) {
          emit(CartStateLoaded(cart: r));
        },
      );
    });
  }
}
