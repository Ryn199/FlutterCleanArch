
import 'package:equatable/equatable.dart';
import 'package:flutterclean/features/warehouse/domain/entities/warehouse.dart';
import 'package:flutterclean/features/warehouse/presentation/bloc/warehouse_event.dart';

abstract class WarehouseState extends Equatable {
  void add(WarehouseEventGetAll warehouseEventGetAll) {}
}

class WarehouseInitial extends WarehouseState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class WarehouseStateLoading extends WarehouseState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class WarehouseStateError extends WarehouseState {
  final String message;

  WarehouseStateError({required this.message});
  @override
  // TODO: implement props
  List<Object?> get props => [message];
}

class WarehouseStateLoadedAll extends WarehouseState {
  final List<Warehouse> warehouses;

  WarehouseStateLoadedAll({required this.warehouses});

  @override
  List<Object?> get props => [warehouses];
}


class WarehouseStateLoaded extends WarehouseState {
  final Warehouse warehouse;

  WarehouseStateLoaded({required this.warehouse});

  @override
  // TODO: implement props
  List<Object?> get props => [warehouse];
}

class WarehouseStateSuccess extends WarehouseState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}