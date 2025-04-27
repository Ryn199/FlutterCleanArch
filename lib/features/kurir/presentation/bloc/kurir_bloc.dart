import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutterclean/features/kurir/data/models/kurir_model.dart';
import 'package:flutterclean/features/kurir/domain/usecases/kurir_usecases.dart';
import 'package:flutterclean/features/kurir/presentation/bloc/kurir_state.dart';

part 'kurir_event.dart';

class KurirBloc extends Bloc<KurirEvent, KurirState> {
  final KurirUsecasesAdd kurirUsecasesAdd;
  final KurirUsecasesEdit kurirUsecasesEdit;
  final KurirUsecasesDelete kurirUsecasesDelete;
  final KurirUsecasesGetAll kurirUsecasesGetAll;
  final KurirUsecasesGetById kurirUsecasesGetById;
  KurirBloc(
      {required this.kurirUsecasesAdd,
      required this.kurirUsecasesEdit,
      required this.kurirUsecasesDelete,
      required this.kurirUsecasesGetAll,
      required this.kurirUsecasesGetById})
      : super(KurirInitial()) {
    on<KurirEventAdd>((event, emit) async {
      emit(KurirStateLoading());
      final data = await kurirUsecasesAdd.execute(kurir: event.kurirModel);
      data.fold(
        (l) {
          emit(KurirStateError(message: l.toString()));
        },
        (r) {
          emit(KurirStateSuccess());
        },
      );
    });
    on<KurirEventEdit>((event, emit) async {
      emit(KurirStateLoading());
      final data =
          await kurirUsecasesEdit.execute(kurir: event.kurirModel);
      data.fold(
        (l) {
          emit(KurirStateError(message: l.toString()));
        },
        (r) {
          emit(KurirStateSuccess());
        },
      );
    });
    on<KurirEventDelete>((event, emit) async {
      emit(KurirStateLoading());
      final data = await kurirUsecasesDelete.execute(id: event.id);
      data.fold(
        (l) {
          emit(KurirStateError(message: l.toString()));
        },
        (r) {
          emit(KurirStateSuccess());
        },
      );
    });
    on<KurirEventGetAll>((event, emit) async {
      emit(KurirStateLoading());
      final data = await kurirUsecasesGetAll.execute();
      data.fold(
        (l) {
          emit(KurirStateError(message: l.toString()));
        },
        (r) {
          emit(KurirStateLoadedAll(kurirs: r));
        },
      );
    });
    on<KurirEventGetById>((event, emit) async {
      emit(KurirStateLoading());
      final data = await kurirUsecasesGetById.execute(id: event.id);
      data.fold(
        (l) {
          emit(KurirStateError(message: l.toString()));
        },
        (r) {
          emit(KurirStateLoaded(kurir: r));
        },
      );
    });
  }
}
