import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterclean/features/kurir/data/models/kurir_model.dart';
import 'package:flutterclean/features/kurir/domain/entities/kurir.dart';

abstract class KurirRemoteDatasource {
  Future<List<Kurir>> getAllKurir();
  Future<Kurir> getKurirById({required String id});
  Future<void> addKurir({required KurirModel kurir});
  Future<void> editKurir({required KurirModel kurir});
  Future<void> deleteKurir({required String id});
}

class KurirRemoteDatasourceImplementation
    implements KurirRemoteDatasource {
  final FirebaseFirestore firebaseFirestore;

  KurirRemoteDatasourceImplementation({required this.firebaseFirestore});

  @override
  Future<void> addKurir({required KurirModel kurir}) async {
    await firebaseFirestore
        .collection('kurirs')
        .add(kurir.toFireStore());
  }

  @override
/*************  ✨ Windsurf Command ⭐  *************/
/*******  cbc8f3d8-0a11-4372-805b-e1660428d89b  *******/
  Future<void> deleteKurir({required String id}) async {
    await firebaseFirestore.collection('kurirs').doc(id).delete();
  }

  @override
  Future<void> editKurir({required KurirModel kurir}) async {
    await firebaseFirestore
        .collection('kurirs')
        .doc(kurir.id)
        .update(kurir.toFireStore());
  }

  @override
  Future<List<Kurir>> getAllKurir() async {
    final data = await firebaseFirestore.collection('kurirs').get();
    return data.docs
        .map(
          (e) => KurirModel.fromFirestore(e),
        )
        .toList();
  }

  @override
  Future<Kurir> getKurirById({required String id}) async {
    final data = await firebaseFirestore.collection('kurirs').doc(id).get();
    return KurirModel.fromFirestore(data);
  }
}
