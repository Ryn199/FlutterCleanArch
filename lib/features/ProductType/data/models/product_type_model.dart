

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterclean/features/ProductType/domain/entities/product_type.dart';

class ProductTypeModel extends ProductType{
  const ProductTypeModel({
    required super.id,
    required super.productTypeName,
    required super.desc,
  });

  factory ProductTypeModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return ProductTypeModel(
      id: doc.id,
      productTypeName: data['productTypeName'],
      desc: data['desc'],
    );
  }

  Map<String,dynamic> toFireStore() {
    return {'productTypeName': productTypeName, 'desc': desc};
  }
}