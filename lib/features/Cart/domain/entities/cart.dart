import 'package:equatable/equatable.dart';

class Cart extends Equatable {
  final String id;
  final String produkId;
  final String quantity;
  final String namaProduk;
  final String harga;
  final String deskripsi;
  final String categoryId;
  final String productTypeId;
  final String warehouseId;

  const Cart({
    required this.id,
    required this.produkId,
    required this.quantity,
    required this.namaProduk,
    required this.harga,
    required this.deskripsi,
    required this.categoryId,
    required this.productTypeId,
    required this.warehouseId,
  });

  @override
  List<Object?> get props => [
        id,
        produkId,
        quantity,
        namaProduk,
        harga,
        deskripsi,
        categoryId,
        productTypeId,
        warehouseId
      ];
}
