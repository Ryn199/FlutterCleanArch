import 'package:equatable/equatable.dart';

class Favorite extends Equatable{

  final String id;
  final String produkId;

  const Favorite(
    {
      required this.id,
      required this.produkId,
    }
  );

  @override
  List<Object?> get props => [id, produkId];
  
}