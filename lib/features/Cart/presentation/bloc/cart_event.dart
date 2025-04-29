part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {}

class CartEventAdd extends CartEvent {
  final CartModel cartModel;

  CartEventAdd({required this.cartModel});

  @override
  List<Object?> get props => [cartModel];
}

class CartEventEdit extends CartEvent {
  final CartModel cartModel;

  CartEventEdit({required this.cartModel});

  @override
  List<Object?> get props => [cartModel];
}

class CartEventDelete extends CartEvent {
  final String id;

  CartEventDelete({required this.id});

  @override
  List<Object?> get props => [id];
}

class CartEventGetAll extends CartEvent {
  @override
  List<Object?> get props => [];
}

class CartEventGetById extends CartEvent {
  final String id;

  CartEventGetById({required this.id});

  @override
  List<Object?> get props => [id];
}