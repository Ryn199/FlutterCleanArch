import 'package:dartz/dartz.dart';
import 'package:flutterclean/features/cart/domain/repositories/cart_repositories.dart';
import 'package:flutterclean/features/cart/data/models/cart_model.dart';
import 'package:flutterclean/features/cart/domain/entities/cart.dart';

class CartUsecasesGetAll {
  final CartRepositories cartRepositories;

  CartUsecasesGetAll({required this.cartRepositories});

  Future<Either<Exception, List<Cart>>> execute() async {
    return await cartRepositories.getAllCart();
  }
}

class CartUsecasesGetById {
  final CartRepositories cartRepositories;

  CartUsecasesGetById({required this.cartRepositories});

  Future<Either<Exception, Cart>> execute({required String id}) async {
    return await cartRepositories.getCartById(id: id);
  }
}

class CartUsecasesAdd {
  final CartRepositories cartRepositories;

  CartUsecasesAdd({required this.cartRepositories});

  Future<Either<Exception, void>> execute({required CartModel cart}) async {
    return await cartRepositories.addCart(cart: cart);
  }
}

class CartUsecasesEdit {
  final CartRepositories cartRepositories;

  CartUsecasesEdit({required this.cartRepositories});

  Future<Either<Exception, void>> execute({required CartModel cart}) async {
    return await cartRepositories.editCart(cart: cart);
  }
}

class CartUsecasesDelete {
  final CartRepositories cartRepositories;

  CartUsecasesDelete({required this.cartRepositories});

  Future<Either<Exception, void>> execute({required String id}) async {
    return await cartRepositories.deleteCart(id : id);
  }

}