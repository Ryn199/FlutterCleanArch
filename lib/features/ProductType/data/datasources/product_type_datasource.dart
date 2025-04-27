import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterclean/features/ProductType/data/models/product_type_model.dart';
import 'package:flutterclean/features/ProductType/domain/entities/product_type.dart';

abstract class ProductTypeRemoteDatasource {
  Future<List<ProductType>> getAllProductType();
  Future<ProductType> getProductTypeById({required String id});
  Future<void> addProductType({required ProductTypeModel productType});
  Future<void> editProductType({required ProductTypeModel productType});
  Future<void> deleteProductType({required String id});
}

class ProductTypeRemoteDatasourceImplementation
    implements ProductTypeRemoteDatasource {
  final FirebaseFirestore firebaseFirestore;

  ProductTypeRemoteDatasourceImplementation({required this.firebaseFirestore});

  @override
  Future<void> addProductType({required ProductTypeModel productType}) async {
    await firebaseFirestore
        .collection('productTypes')
        .add(productType.toFireStore());
  }
 Future<void> deleteProductType({required String id}) async {
    await firebaseFirestore.collection('productTypes').doc(id).delete();
  }

  @override
  Future<void> editProductType({required ProductTypeModel productType}) async {
    await firebaseFirestore
        .collection('productTypes')
        .doc(productType.id)
        .update(productType.toFireStore());
  }

  @override
  Future<List<ProductType>> getAllProductType() async {
    final data = await firebaseFirestore.collection('productTypes').get();
    return data.docs
        .map(
          (e) => ProductTypeModel.fromFirestore(e),
        )
        .toList();
  }

  @override
  Future<ProductType> getProductTypeById({required String id}) async {
    final data = await firebaseFirestore.collection('productTypes').doc(id).get();
    return ProductTypeModel.fromFirestore(data);
  }
}
