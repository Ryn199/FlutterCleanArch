import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutterclean/features/Supplier/data/models/supplier_model.dart';
import 'package:flutterclean/features/Supplier/domain/usecases/supplier_usecases.dart';
import 'package:flutterclean/features/Supplier/presentation/bloc/supplier_state.dart';

part 'supplier_event.dart';

class SupplierBloc extends Bloc<SupplierEvent, SupplierState> {
  final SupplierUseCasesAdd supplierUsecasesAdd;
  final SupplierUseCasesEdit supplierUsecasesEdit;
  final SupplierUseCasesDelete supplierUsecasesDelete;
  final SupplierUseCasesGetAll supplierUsecasesGetAll;
  final SupplierUseCasesGetById supplierUsecasesGetById;
  SupplierBloc(
      {required this.supplierUsecasesAdd,
      required this.supplierUsecasesEdit,
      required this.supplierUsecasesDelete,
      required this.supplierUsecasesGetAll,
      required this.supplierUsecasesGetById})
      : super(SupplierInitial()) {
    on<SupplierEventAdd>((event, emit) async {
      emit(SupplierStateLoading());
      final data = await supplierUsecasesAdd.execute(supplier: event.supplierModel);
      data.fold(
        (l) {
          emit(SupplierStateError(message: l.toString()));
        },
        (r) {
          emit(SupplierStateSuccess());
        },
      );
    });
    on<SupplierEventEdit>((event, emit) async {
      emit(SupplierStateLoading());
      final data =
          await supplierUsecasesEdit.execute(supplier: event.supplierModel);
      data.fold(
        (l) {
          emit(SupplierStateError(message: l.toString()));
        },
        (r) {
          emit(SupplierStateSuccess());
        },
      );
    });
    on<SupplierEventDelete>((event, emit) async {
      emit(SupplierStateLoading());
      final data = await supplierUsecasesDelete.execute(id: event.id);
      data.fold(
        (l) {
          emit(SupplierStateError(message: l.toString()));
        },
        (r) {
          emit(SupplierStateSuccess());
        },
      );
    });
    on<SupplierEventGetAll>((event, emit) async {
      emit(SupplierStateLoading());
      final data = await supplierUsecasesGetAll.execute();
      data.fold(
        (l) {
          emit(SupplierStateError(message: l.toString()));
        },
        (r) {
          emit(SupplierStateLoadedAll(suppliers: r));
        },
      );
    });
    on<SupplierEventGetById>((event, emit) async {
      emit(SupplierStateLoading());
      final data = await supplierUsecasesGetById.execute(id: event.id);
      data.fold(
        (l) {
          emit(SupplierStateError(message: l.toString()));
        },
        (r) {
          emit(SupplierStateLoaded(suppliers: r));
        },
      );
    });
  }
}
