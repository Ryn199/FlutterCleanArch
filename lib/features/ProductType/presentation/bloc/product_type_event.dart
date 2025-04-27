part of 'product_type_bloc.dart';

abstract class ProductTypeEvent extends Equatable {}

class ProductTypeEventAdd extends ProductTypeEvent {
  final ProductTypeModel productTypeModel;

  ProductTypeEventAdd({required this.productTypeModel});

  @override
  List<Object?> get props => [productTypeModel];
}

class ProductTypeEventEdit extends ProductTypeEvent {
  final ProductTypeModel productTypeModel;

  ProductTypeEventEdit({required this.productTypeModel});

  @override
  List<Object?> get props => [productTypeModel];
}

class ProductTypeEventDelete extends ProductTypeEvent {
  final String id;

  ProductTypeEventDelete({required this.id});

  @override
  List<Object?> get props => [id];
}

class ProductTypeEventGetAll extends ProductTypeEvent {
  @override
  List<Object?> get props => [];
}

class ProductTypeEventGetById extends ProductTypeEvent {
  final String id;

  ProductTypeEventGetById({required this.id});

  @override
  List<Object?> get props => [id];
}