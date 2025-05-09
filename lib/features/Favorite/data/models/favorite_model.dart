import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterclean/features/favorite/domain/entities/favorite.dart';

class FavoriteModel extends Favorite {
  const FavoriteModel(
      {required super.id,
      required super.produkId,
      required super.namaProduk,
      required super.harga,
      required super.deskripsi,
      required super.categoryId,
      required super.productTypeId,
      required super.warehouseId});

  factory FavoriteModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return FavoriteModel(
      id: doc.id,
      produkId: data['produkId'],
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
      'produkId': produkId,
      'namaProduk': namaProduk,
      'harga': harga,
      'deskripsi': deskripsi,
      'categoryId': categoryId,
      'productTypeId': productTypeId,
      'warehouseId': warehouseId
    };
  }
}
