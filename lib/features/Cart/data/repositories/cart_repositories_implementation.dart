import 'package:dartz/dartz.dart';
import 'package:flutterclean/features/cart/data/datasources/cart_datasources.dart';
import 'package:flutterclean/features/cart/data/models/cart_model.dart';
import 'package:flutterclean/features/cart/domain/entities/cart.dart';
import 'package:flutterclean/features/cart/domain/repositories/cart_repositories.dart';

class CartRepositoriesImplementation implements CartRepositories{
  final CartRemoteDatasource cartRemoteDatasource;

  CartRepositoriesImplementation({required this.cartRemoteDatasource});
  
  @override
  Future<Either<Exception, void>> addCart({required CartModel cart}) async{
    try {
      final data = await cartRemoteDatasource.addCart(cart: cart);
      return Right(data);
    } catch (e) {
      throw Left(Exception(e));
    }
  }
  
  @override
  Future<Either<Exception, void>> deleteCart({required String id}) async {
    try {
      final data = await cartRemoteDatasource.deleteCart(id: id);
      return Right(data);
    } catch (e) {
      throw Left(Exception(e));
    }
  }

  @override
  Future<Either<Exception, void>> editCart(
      {required CartModel cart}) async {
    try {
      final data = await cartRemoteDatasource.editCart(cart: cart);
      return Right(data);
    } catch (e) {
      throw Left(Exception(e));
    }
  }

  @override
  Future<Either<Exception, List<Cart>>> getAllCart() async {
    try {
      final data = await cartRemoteDatasource.getAllCart();
      return Right(data);
    } catch (e) {
      throw Left(Exception(e));
    }
  }

  @override
  Future<Either<Exception, Cart>> getCartById({required String id}) async {
    try {
      final data = await cartRemoteDatasource.getCartById(id: id);
      return Right(data);
    } catch (e) {
      throw Left(Exception(e));
    }
  }


}