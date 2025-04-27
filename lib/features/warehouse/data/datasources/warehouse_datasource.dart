import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterclean/features/warehouse/data/models/warehouse_model.dart';
import 'package:flutterclean/features/warehouse/domain/entities/warehouse.dart';


abstract class WarehouseRemoteDatasource {
  Future<List<Warehouse>> getAllWarehouse();
  Future<Warehouse> getWarehouseById({required String id});
  Future<void> addWarehouse({required WarehouseModel warehouse});
  Future<void> editWarehouse({required WarehouseModel warehouse});
  Future<void> deleteWarehouse({required String id});
}

class WarehouseRemoteDatasourceImplementation
    implements WarehouseRemoteDatasource {
  final FirebaseFirestore firebaseFirestore;

  WarehouseRemoteDatasourceImplementation({required this.firebaseFirestore});

  @override
  Future<void> addWarehouse({required WarehouseModel warehouse}) async {
    await firebaseFirestore
        .collection('warehouses')
        .add(warehouse.toFireStore());
  }
 Future<void> deleteWarehouse({required String id}) async {
    await firebaseFirestore.collection('warehouses').doc(id).delete();
  }

  @override
  Future<void> editWarehouse({required WarehouseModel warehouse}) async {
    await firebaseFirestore
        .collection('warehouses')
        .doc(warehouse.id)
        .update(warehouse.toFireStore());
  }

  @override
  Future<List<Warehouse>> getAllWarehouse() async {
    final data = await firebaseFirestore.collection('warehouses').get();
    return data.docs
        .map(
          (e) => WarehouseModel.fromFirestore(e),
        )
        .toList();
  }

  @override
  Future<Warehouse> getWarehouseById({required String id}) async {
    final data = await firebaseFirestore.collection('warehouses').doc(id).get();
    return WarehouseModel.fromFirestore(data);
  }
}
