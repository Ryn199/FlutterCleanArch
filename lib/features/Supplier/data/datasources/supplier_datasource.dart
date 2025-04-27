import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterclean/features/Supplier/data/models/supplier_model.dart';
import 'package:flutterclean/features/Supplier/domain/entities/supplier.dart';

abstract class SupplierRemoteDatasource {
  Future<List<Supplier>> getAllSupplier();
  Future<Supplier> getSupplierById({required String id});
  Future<void> addSupplier({required SupplierModel supplier});
  Future<void> editSupplier({required SupplierModel supplier});
  Future<void> deleteSupplier({required String id});
}

class SupplierRemoteDatasourceImplementation
    implements SupplierRemoteDatasource {
  final FirebaseFirestore firebaseFirestore;

  SupplierRemoteDatasourceImplementation({required this.firebaseFirestore});

  @override
  Future<void> addSupplier({required SupplierModel supplier}) async {
    await firebaseFirestore
        .collection('suppliers')
        .add(supplier.toFireStore());
  }

  @override
  Future<void> deleteSupplier({required String id}) async {
    await firebaseFirestore.collection('suppliers').doc(id).delete();
  }

  @override
  Future<void> editSupplier({required SupplierModel supplier}) async {
    await firebaseFirestore
        .collection('suppliers')
        .doc(supplier.id)
        .update(supplier.toFireStore());
  }

  @override
  Future<List<Supplier>> getAllSupplier() async {
    final data = await firebaseFirestore.collection('suppliers').get();
    return data.docs
        .map(
          (e) => SupplierModel.fromFirestore(e),
        )
        .toList();
  }

  @override
  Future<Supplier> getSupplierById({required String id}) async {
    final data = await firebaseFirestore.collection('suppliers').doc(id).get();
    return SupplierModel.fromFirestore(data);
  }
}
