import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutterclean/features/ProductType/data/models/product_type_model.dart';
import 'package:flutterclean/features/ProductType/domain/usecases/product_type_usecases.dart';
import 'package:flutterclean/features/ProductType/presentation/bloc/product_type_state.dart';

part 'product_type_event.dart';

class ProductTypeBloc extends Bloc<ProductTypeEvent, ProductTypeState> {
  final ProductTypeUsecasesAdd productTypeUsecasesAdd;
  final ProductTypeUsecasesEdit productTypeUsecasesEdit;
  final ProductTypeUsecasesDelete productTypeUsecasesDelete;
  final ProductTypeUsecasesGetAll productTypeUsecasesGetAll;
  final ProductTypeUsecasesGetById productTypeUsecasesGetById;
  ProductTypeBloc(
      {required this.productTypeUsecasesAdd,
      required this.productTypeUsecasesEdit,
      required this.productTypeUsecasesDelete,
      required this.productTypeUsecasesGetAll,
      required this.productTypeUsecasesGetById})
      : super(ProductTypeInitial()) {
    on<ProductTypeEventAdd>((event, emit) async {
      emit(ProductTypeStateLoading());
      final data = await productTypeUsecasesAdd.execute(productType: event.productTypeModel);
      data.fold(
        (l) {
          emit(ProductTypeStateError(message: l.toString()));
        },
        (r) {
          emit(ProductTypeStateSuccess());
        },
      );
    });
    on<ProductTypeEventEdit>((event, emit) async {
      emit(ProductTypeStateLoading());
      final data =
          await productTypeUsecasesEdit.execute(productType: event.productTypeModel);
      data.fold(
        (l) {
          emit(ProductTypeStateError(message: l.toString()));
        },
        (r) {
          emit(ProductTypeStateSuccess());
        },
      );
    });
    on<ProductTypeEventDelete>((event, emit) async {
      emit(ProductTypeStateLoading());
      final data = await productTypeUsecasesDelete.execute(id: event.id);
      data.fold(
        (l) {
          emit(ProductTypeStateError(message: l.toString()));
        },
        (r) {
          emit(ProductTypeStateSuccess());
        },
      );
    });
    on<ProductTypeEventGetAll>((event, emit) async {
      emit(ProductTypeStateLoading());
      final data = await productTypeUsecasesGetAll.execute();
      data.fold(
        (l) {
          emit(ProductTypeStateError(message: l.toString()));
        },
        (r) {
          emit(ProductTypeStateLoadedAll(productTypes: r));
        },
      );
    });
    on<ProductTypeEventGetById>((event, emit) async {
      emit(ProductTypeStateLoading());
      final data = await productTypeUsecasesGetById.execute(id: event.id);
      data.fold(
        (l) {
          emit(ProductTypeStateError(message: l.toString()));
        },
        (r) {
          emit(ProductTypeStateLoaded(productTypes: r));
        },
      );
    });
  }
}
