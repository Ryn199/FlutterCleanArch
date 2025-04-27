
import 'package:equatable/equatable.dart';
import 'package:flutterclean/features/warehouse/data/models/warehouse_model.dart';

abstract class WarehouseEvent extends Equatable {}

class WarehouseEventAdd extends WarehouseEvent {
  final WarehouseModel warehouseModel;

  WarehouseEventAdd({required this.warehouseModel});

  @override
  List<Object?> get props => [warehouseModel];
}

class WarehouseEventEdit extends WarehouseEvent {
  final WarehouseModel warehouseModel;

  WarehouseEventEdit({required this.warehouseModel});

  @override
  List<Object?> get props => [warehouseModel];
}

class WarehouseEventDelete extends WarehouseEvent {
  final String id;

  WarehouseEventDelete({required this.id});

  @override
  List<Object?> get props => [id];
}

class WarehouseEventGetAll extends WarehouseEvent {
  @override
  List<Object?> get props => [];
}

class WarehouseEventGetById extends WarehouseEvent {
  final String id;

  WarehouseEventGetById({required this.id});

  @override
  List<Object?> get props => [id];
}