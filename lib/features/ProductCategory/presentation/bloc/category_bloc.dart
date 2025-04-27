import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutterclean/features/ProductCategory/data/models/category_model.dart';
import 'package:flutterclean/features/ProductCategory/domain/usecases/category_usecases.dart';
import 'package:flutterclean/features/ProductCategory/presentation/bloc/category_state.dart';

part 'category_event.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryUsecasesAdd categoryUsecasesAdd;
  final CategoryUsecasesEdit categoryUsecasesEdit;
  final CategoryUsecasesDelete categoryUsecasesDelete;
  final CategoryUsecasesGetAll categoryUsecasesGetAll;
  final CategoryUsecasesGetById categoryUsecasesGetById;
  CategoryBloc(
      {required this.categoryUsecasesAdd,
      required this.categoryUsecasesEdit,
      required this.categoryUsecasesDelete,
      required this.categoryUsecasesGetAll,
      required this.categoryUsecasesGetById})
      : super(CategoryInitial()) {
    on<CategoryEventAdd>((event, emit) async {
      emit(CategoryStateLoading());
      final data = await categoryUsecasesAdd.execute(category: event.categoryModel);
      data.fold(
        (l) {
          emit(CategoryStateError(message: l.toString()));
        },
        (r) {
          emit(CategoryStateSuccess());
        },
      );
    });
    on<CategoryEventEdit>((event, emit) async {
      emit(CategoryStateLoading());
      final data =
          await categoryUsecasesEdit.execute(category: event.categoryModel);
      data.fold(
        (l) {
          emit(CategoryStateError(message: l.toString()));
        },
        (r) {
          emit(CategoryStateSuccess());
        },
      );
    });
    on<CategoryEventDelete>((event, emit) async {
      emit(CategoryStateLoading());
      final data = await categoryUsecasesDelete.execute(id: event.id);
      data.fold(
        (l) {
          emit(CategoryStateError(message: l.toString()));
        },
        (r) {
          emit(CategoryStateSuccess());
        },
      );
    });
    on<CategoryEventGetAll>((event, emit) async {
      emit(CategoryStateLoading());
      final data = await categoryUsecasesGetAll.execute();
      data.fold(
        (l) {
          emit(CategoryStateError(message: l.toString()));
        },
        (r) {
          emit(CategoryStateLoadedAll(categories: r));
        },
      );
    });
    on<CategoryEventGetById>((event, emit) async {
      emit(CategoryStateLoading());
      final data = await categoryUsecasesGetById.execute(id: event.id);
      data.fold(
        (l) {
          emit(CategoryStateError(message: l.toString()));
        },
        (r) {
          emit(CategoryStateLoaded(category: r));
        },
      );
    });
  }
}
