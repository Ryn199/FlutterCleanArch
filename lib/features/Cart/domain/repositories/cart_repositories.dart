import 'package:dartz/dartz.dart';
import 'package:flutterclean/features/cart/data/models/cart_model.dart';
import 'package:flutterclean/features/cart/domain/entities/cart.dart';


abstract class CartRepositories {
  Future<Either<Exception, List<Cart>>> getAllCart();
  Future<Either<Exception, Cart>> getCartById({required String id});
  Future<Either<Exception, void>> addCart({required CartModel cart});
  Future<Either<Exception, void>> editCart({required CartModel cart});
  Future<Either<Exception, void>> deleteCart({required String id});
  
}