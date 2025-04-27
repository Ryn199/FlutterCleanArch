
import 'package:equatable/equatable.dart';
import 'package:flutterclean/features/Supplier/presentation/bloc/supplier_bloc.dart';

import '../../domain/entities/supplier.dart';

abstract class SupplierState extends Equatable {
  void add(SupplierEventGetAll supplierEventGetAll) {}
}

class SupplierInitial extends SupplierState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class SupplierStateLoading extends SupplierState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class SupplierStateError extends SupplierState {
  final String message;

  SupplierStateError({required this.message});
  @override
  // TODO: implement props
  List<Object?> get props => [message];
}

class SupplierStateLoadedAll extends SupplierState {
  final List<Supplier> suppliers;

  SupplierStateLoadedAll({required this.suppliers});

  @override
  List<Object?> get props => [suppliers];
}


class SupplierStateLoaded extends SupplierState {
  final Supplier suppliers;

  SupplierStateLoaded({required this.suppliers});

  @override
  // TODO: implement props
  List<Object?> get props => [suppliers];
}

class SupplierStateSuccess extends SupplierState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}