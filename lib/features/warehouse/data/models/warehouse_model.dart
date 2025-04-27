

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterclean/features/warehouse/domain/entities/warehouse.dart';

class WarehouseModel extends Warehouse{
  const WarehouseModel({
    required super.id,
    required super.warehouseName,
    required super.address,
    required super.capacity,
    required super.desc,
  });

  factory WarehouseModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return WarehouseModel(
      id: doc.id,
      warehouseName: data['warehouseName'],
      address: data['address'],
      capacity: data['capacity'],
      desc: data['desc'],
    );
  }

  Map<String,dynamic> toFireStore() {
    return {'warehouseName': warehouseName, 'address': address, 'capacity': capacity, 'desc': desc};
  }
}