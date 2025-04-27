import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterclean/features/Favorite/data/models/favorite_model.dart';
import 'package:flutterclean/features/Favorite/domain/entities/favorite.dart';

abstract class FavoriteRemoteDatasource {
  Future<List<Favorite>> getAllFavorite();
  Future<Favorite> getFavoriteById({required String id});
  Future<void> addFavorite({required FavoriteModel favorite});
  Future<void> editFavorite({required FavoriteModel favorite});
  Future<void> deleteFavorite({required String id});
}

class FavoriteRemoteDatasourceImplementation
    implements FavoriteRemoteDatasource {
  final FirebaseFirestore firebaseFirestore;

  FavoriteRemoteDatasourceImplementation({required this.firebaseFirestore});

  @override
  Future<void> addFavorite({required FavoriteModel favorite}) async {
    await firebaseFirestore
        .collection('favorites')
        .add(favorite.toFireStore());
  }

  @override
  Future<void> deleteFavorite({required String id}) async {
    await firebaseFirestore.collection('favorites').doc(id).delete();
  }

  @override
  Future<void> editFavorite({required FavoriteModel favorite}) async {
    await firebaseFirestore
        .collection('favorites')
        .doc(favorite.id)
        .update(favorite.toFireStore());
  }

  @override
  Future<List<Favorite>> getAllFavorite() async {
    final data = await firebaseFirestore.collection('favorites').get();
    return data.docs
        .map(
          (e) => FavoriteModel.fromFirestore(e),
        )
        .toList();
  }

  @override
  Future<Favorite> getFavoriteById({required String id}) async {
    final data = await firebaseFirestore.collection('favorites').doc(id).get();
    return FavoriteModel.fromFirestore(data);
  }
}



//  Future<void> addFavorite({required FavoriteModel favorite}) async {
//     try {
//       // Cek apakah sudah ada produk dengan ID yang sama
//       final querySnapshot = await firebaseFirestore
//           .collection('favorites')
//           .where('productId',
//               isEqualTo:
//                   favorite.produkId)
//           .get();

//       if (querySnapshot.docs.isEmpty) {
//         // tambah kalo belum ada
//         await firebaseFirestore
//             .collection('favorites')
//             .add(favorite.toFireStore());
//       } else {
//         // udah ada, kasi error
//         throw Exception('Produk sudah ada di favorite');
//       }
//     } catch (e) {
//       //elseelse
//       throw Exception('Error menambahkan ke favorite: $e');
//     }
//   }