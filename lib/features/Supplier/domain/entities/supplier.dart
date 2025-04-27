import 'package:equatable/equatable.dart';

class Supplier extends Equatable{

  final String id;
  final String supplierName;
  final String address;
  final String phone;
  final String email;
  final String desc;

  const Supplier(
    {
      required this.id,
      required this.supplierName,
      required this.address,
      required this.phone,
      required this.email,
      required this.desc,
    }
  );

  @override
  List<Object?> get props => [id, supplierName, address, phone, email, desc];
  
}