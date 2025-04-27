import 'package:equatable/equatable.dart';

class ProductType extends Equatable {
  final String id;
  final String productTypeName;
  final String desc;

  const ProductType({
    required this.id,
    required this.productTypeName,
    required this.desc,
  });

  @override
  List<Object?> get props => [id, productTypeName, desc];
}
