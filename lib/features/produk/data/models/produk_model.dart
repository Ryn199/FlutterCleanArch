import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterclean/features/produk/domain/entities/produk.dart';

class ProdukModel extends Produk {
  const ProdukModel({
    required super.id,
    required super.namaProduk,
    required super.harga,
    required super.deskripsi,
    required super.categoryId,
    required super.productTypeId,
    required super.warehouseId,
  });

  factory ProdukModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return ProdukModel(
      id: doc.id,
      namaProduk: data['namaProduk'],
      harga: data['harga'],
      deskripsi: data['deskripsi'],
      categoryId: data['categoryId'],
      productTypeId: data['productTypeId'],
      warehouseId: data['warehouseId'],
    );
  }

  Map<String, dynamic> toFireStore() {
    return {
      'namaProduk': namaProduk,
      'harga': harga,
      'deskripsi': deskripsi,
      'categoryId': categoryId,
      'productTypeId': productTypeId,
      'warehouseId': warehouseId
    };
  }
}
