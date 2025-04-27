import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterclean/features/kurir/domain/entities/kurir.dart';

class KurirModel extends Kurir{
  const KurirModel({
    required super.id,
    required super.namaKurir,
    required super.email,
  });

  factory KurirModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return KurirModel(
      id: doc.id,
      namaKurir: data['namaKurir'],
      email: data['email'],
    );
  }

  Map<String,dynamic> toFireStore() {
    return {'namaKurir': namaKurir, 'email': email};
  }
}