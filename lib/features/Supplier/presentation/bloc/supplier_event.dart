part of 'supplier_bloc.dart';

abstract class SupplierEvent extends Equatable {}

class SupplierEventAdd extends SupplierEvent {
  final SupplierModel supplierModel;

  SupplierEventAdd({required this.supplierModel});

  @override
  List<Object?> get props => [supplierModel];
}

class SupplierEventEdit extends SupplierEvent {
  final SupplierModel supplierModel;

  SupplierEventEdit({required this.supplierModel});

  @override
  List<Object?> get props => [supplierModel];
}

class SupplierEventDelete extends SupplierEvent {
  final String id;

  SupplierEventDelete({required this.id});

  @override
  List<Object?> get props => [id];
}

class SupplierEventGetAll extends SupplierEvent {
  @override
  List<Object?> get props => [];
}

class SupplierEventGetById extends SupplierEvent {
  final String id;

  SupplierEventGetById({required this.id});

  @override
  List<Object?> get props => [id];
}