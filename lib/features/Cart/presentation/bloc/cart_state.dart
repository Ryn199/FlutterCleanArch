
import 'package:equatable/equatable.dart';
import 'package:flutterclean/features/cart/presentation/bloc/cart_bloc.dart';

import '../../domain/entities/cart.dart';

abstract class CartState extends Equatable {
  void add(CartEventGetAll cartEventGetAll) {}
}

class CartInitial extends CartState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class CartStateLoading extends CartState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class CartStateError extends CartState {
  final String message;

  CartStateError({required this.message});
  @override
  // TODO: implement props
  List<Object?> get props => [message];
}

class CartStateLoadedAll extends CartState {
  final List<Cart> carts;

  CartStateLoadedAll({required this.carts});

  @override
  List<Object?> get props => [carts];
}


class CartStateLoaded extends CartState {
  final Cart cart;

  CartStateLoaded({required this.cart});

  @override
  // TODO: implement props
  List<Object?> get props => [cart];
}

class CartStateSuccess extends CartState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}