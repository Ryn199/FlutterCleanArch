import 'package:equatable/equatable.dart';

class Produk extends Equatable {
  final String id;
  final String namaProduk;
  final String harga;
  final String deskripsi;
  final String categoryId;
  final String productTypeId;
  final String warehouseId;

  const Produk(
      {
      required this.id,
      required this.namaProduk,
      required this.harga,
      required this.deskripsi,
      required this.categoryId,
      required this.productTypeId,
      required this.warehouseId,
      });

  @override
  List<Object?> get props => [id, namaProduk, harga, deskripsi, categoryId, productTypeId];
}
