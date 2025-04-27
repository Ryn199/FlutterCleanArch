import 'package:equatable/equatable.dart';
import 'package:flutterclean/features/ProductType/domain/entities/product_type.dart';
import 'package:flutterclean/features/ProductType/presentation/bloc/product_type_bloc.dart';

abstract class ProductTypeState extends Equatable {
  void add(ProductTypeEventGetAll productTypeEventGetAll) {}
}

class ProductTypeInitial extends ProductTypeState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ProductTypeStateLoading extends ProductTypeState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ProductTypeStateError extends ProductTypeState {
  final String message;

  ProductTypeStateError({required this.message});
  @override
  // TODO: implement props
  List<Object?> get props => [message];
}

class ProductTypeStateLoadedAll extends ProductTypeState {
  final List<ProductType> productTypes;

  ProductTypeStateLoadedAll({required this.productTypes});

  @override
  List<Object?> get props => [productTypes];
}

class ProductTypeStateLoaded extends ProductTypeState {
  final ProductType productTypes;

  ProductTypeStateLoaded({required this.productTypes});

  @override
  // TODO: implement props
  List<Object?> get props => [productTypes];
}

class ProductTypeStateSuccess extends ProductTypeState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
