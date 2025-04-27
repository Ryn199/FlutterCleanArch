import 'package:bloc/bloc.dart';
import 'package:flutterclean/features/warehouse/domain/usecases/warehouse_usecases.dart';
import 'package:flutterclean/features/warehouse/presentation/bloc/warehouse_event.dart';
import 'package:flutterclean/features/warehouse/presentation/bloc/warehouse_state.dart';


class WarehouseBloc extends Bloc<WarehouseEvent, WarehouseState> {
  final WarehouseUsecasesAdd warehouseUsecasesAdd;
  final WarehouseUsecasesEdit warehouseUsecasesEdit;
  final WarehouseUsecasesDelete warehouseUsecasesDelete;
  final WarehouseUsecasesGetAll warehouseUsecasesGetAll;
  final WarehouseUsecasesGetById warehouseUsecasesGetById;
  WarehouseBloc(
      {required this.warehouseUsecasesAdd,
      required this.warehouseUsecasesEdit,
      required this.warehouseUsecasesDelete,
      required this.warehouseUsecasesGetAll,
      required this.warehouseUsecasesGetById})
      : super(WarehouseInitial()) {
    on<WarehouseEventAdd>((event, emit) async {
      emit(WarehouseStateLoading());
      final data = await warehouseUsecasesAdd.execute(warehouse: event.warehouseModel);
      data.fold(
        (l) {
          emit(WarehouseStateError(message: l.toString()));
        },
        (r) {
          emit(WarehouseStateSuccess());
        },
      );
    });
    on<WarehouseEventEdit>((event, emit) async {
      emit(WarehouseStateLoading());
      final data =
          await warehouseUsecasesEdit.execute(warehouse: event.warehouseModel);
      data.fold(
        (l) {
          emit(WarehouseStateError(message: l.toString()));
        },
        (r) {
          emit(WarehouseStateSuccess());
        },
      );
    });
    on<WarehouseEventDelete>((event, emit) async {
      emit(WarehouseStateLoading());
      final data = await warehouseUsecasesDelete.execute(id: event.id);
      data.fold(
        (l) {
          emit(WarehouseStateError(message: l.toString()));
        },
        (r) {
          emit(WarehouseStateSuccess());
        },
      );
    });
    on<WarehouseEventGetAll>((event, emit) async {
      emit(WarehouseStateLoading());
      final data = await warehouseUsecasesGetAll.execute();
      data.fold(
        (l) {
          emit(WarehouseStateError(message: l.toString()));
        },
        (r) {
          emit(WarehouseStateLoadedAll(warehouses: r));
        },
      );
    });
    on<WarehouseEventGetById>((event, emit) async {
      emit(WarehouseStateLoading());
      final data = await warehouseUsecasesGetById.execute(id: event.id);
      data.fold(
        (l) {
          emit(WarehouseStateError(message: l.toString()));
        },
        (r) {
          emit(WarehouseStateLoaded(warehouse: r));
        },
      );
    });
  }
}
