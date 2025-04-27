import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterclean/features/Favorite/domain/entities/favorite.dart';

class FavoriteModel extends Favorite{
  const FavoriteModel({
    required super.id,
    required super.produkId
  });

  factory FavoriteModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return FavoriteModel(
      id: doc.id,
      produkId: data['produkId'],
    );
  }

  Map<String,dynamic> toFireStore() {
    return {'produkId': produkId};
  }
}