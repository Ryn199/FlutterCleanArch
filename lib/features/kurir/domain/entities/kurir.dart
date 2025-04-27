import 'package:equatable/equatable.dart';

class Kurir extends Equatable{

  final String id;
  final String namaKurir;
  final String email;

  const Kurir(
    {
      required this.id,
      required this.namaKurir,
      required this.email,
    }
  );

  @override
  List<Object?> get props => [id, namaKurir, email];
  
}