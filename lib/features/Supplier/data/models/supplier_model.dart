import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterclean/features/Supplier/domain/entities/supplier.dart';

class SupplierModel extends Supplier{
  const SupplierModel({
    required super.id,
    required super.supplierName,
    required super.address,
    required super.email,
    required super.phone,
    required super.desc,
  });

  factory SupplierModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return SupplierModel(
      id: doc.id,
      supplierName: data['supplierName'],
      address: data['address'],
      email: data['email'],
      phone: data['phone'],
      desc: data['desc'],
    );
  }

  Map<String,dynamic> toFireStore() {
    return {'supplierName': supplierName, 'address': address, 'email': email, 'phone': phone, 'desc': desc};
  }
}