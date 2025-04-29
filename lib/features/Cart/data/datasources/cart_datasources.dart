import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterclean/features/cart/data/models/cart_model.dart';
import 'package:flutterclean/features/cart/domain/entities/cart.dart';
import 'package:flutterclean/my_injection.dart';
import 'package:hive_flutter/hive_flutter.dart';

abstract class CartRemoteDatasource {
  Future<List<Cart>> getAllCart();
  Future<Cart> getCartById({required String id});
  Future<void> addCart({required CartModel cart});
  Future<void> editCart({required CartModel cart});
  Future<void> deleteCart({required String id});
}

class CartRemoteDatasourceImplementation implements CartRemoteDatasource {
  final FirebaseFirestore firebaseFirestore;
  final users = myinjection<Box>();

  CartRemoteDatasourceImplementation({required this.firebaseFirestore});

  @override
  Future<void> addCart({required CartModel cart}) async {
    final cartCollection = firebaseFirestore
        .collection('users')
        .doc(users.get('uid'))
        .collection('carts');

    final isProdukExist =
        await cartCollection.where('produkId', isEqualTo: cart.produkId).get();

    if (isProdukExist.docs.isEmpty) {
      // Kalau belum ada, tambah produk baru dengan quantity = 1
      await cartCollection.add({
        ...cart.toFireStore(),
        'quantity': '1', // tetap string karena lu simpan string
      });
    } else {
      // Kalau sudah ada, update quantity
      final docId = isProdukExist.docs.first.id;
      final quantityString =
          isProdukExist.docs.first.data()['quantity'] as String? ?? '0';
      final currentQuantity = int.tryParse(quantityString) ?? 0;

      await cartCollection.doc(docId).update({
        'quantity': (currentQuantity + 1).toString(), // tetap simpan string
      });
    }
  }

  @override
  Future<void> deleteCart({required String id}) async {
    await firebaseFirestore
        .collection('users')
        .doc(users.get('uid'))
        .collection('carts')
        .doc(id)
        .delete();
  }

  @override
  Future<void> editCart({required CartModel cart}) async {
    await firebaseFirestore
        .collection('carts')
        .doc(cart.id)
        .update(cart.toFireStore());
  }

  @override
  Future<List<Cart>> getAllCart() async {
    final data = await firebaseFirestore
        .collection('users')
        .doc(users.get('uid'))
        .collection('carts')
        .get();
    return data.docs
        .map(
          (e) => CartModel.fromFirestore(e),
        )
        .toList();
  }

  @override
  Future<Cart> getCartById({required String id}) async {
    final data = await firebaseFirestore.collection('carts').doc(id).get();
    return CartModel.fromFirestore(data);
  }
}
