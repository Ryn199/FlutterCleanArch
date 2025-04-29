import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterclean/features/cart/domain/entities/cart.dart';

class CartModel extends Cart {
  const CartModel(
      {required super.id,
      required super.produkId,
      required super.quantity,
      required super.namaProduk,
      required super.harga,
      required super.deskripsi,
      required super.categoryId,
      required super.productTypeId,
      required super.warehouseId});

  factory CartModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return CartModel(
      id: doc.id,
      produkId: data['produkId'],
      quantity: data['quantity'],
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
      'quantity': quantity,
      'namaProduk': namaProduk,
      'harga': harga,
      'deskripsi': deskripsi,
      'categoryId': categoryId,
      'productTypeId': productTypeId,
      'warehouseId': warehouseId
    };
  }
}
