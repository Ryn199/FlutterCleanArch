
import 'package:equatable/equatable.dart';
import 'package:flutterclean/features/ProductCategory/presentation/bloc/category_bloc.dart';

import '../../domain/entities/category.dart';

abstract class CategoryState extends Equatable {
  void add(CategoryEventGetAll categoryEventGetAll) {}
}

class CategoryInitial extends CategoryState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class CategoryStateLoading extends CategoryState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class CategoryStateError extends CategoryState {
  final String message;

  CategoryStateError({required this.message});
  @override
  // TODO: implement props
  List<Object?> get props => [message];
}

class CategoryStateLoadedAll extends CategoryState {
  final List<Category> categories;

  CategoryStateLoadedAll({required this.categories});

  @override
  List<Object?> get props => [categories];
}


class CategoryStateLoaded extends CategoryState {
  final Category category;

  CategoryStateLoaded({required this.category});

  @override
  // TODO: implement props
  List<Object?> get props => [category];
}

class CategoryStateSuccess extends CategoryState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}