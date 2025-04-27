import 'package:equatable/equatable.dart';

class Warehouse extends Equatable {
  final String id;
  final String warehouseName;
  final String address;
  final String capacity;
  final String desc;

  const Warehouse({
    required this.id,
    required this.warehouseName,
    required this.address,
    required this.capacity,
    required this.desc,
  });

  @override
  List<Object?> get props => [id, warehouseName,address, capacity, desc];
}
