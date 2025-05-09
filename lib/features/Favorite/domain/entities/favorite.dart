import 'package:equatable/equatable.dart';

class Favorite extends Equatable {
  final String id;
  final String produkId;
  final String namaProduk;
  final String harga;
  final String deskripsi;
  final String categoryId;
  final String productTypeId;
  final String warehouseId;

  const Favorite({
    required this.id,
    required this.produkId,
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
        namaProduk,
        harga,
        deskripsi,
        categoryId,
        productTypeId,
        warehouseId
      ];
}
