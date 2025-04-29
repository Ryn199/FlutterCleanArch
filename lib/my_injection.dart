import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterclean/core/usecase/component/cubit/option_cubit.dart';
import 'package:flutterclean/features/auth/data/datasources/auth_datasource.dart';
import 'package:flutterclean/features/auth/data/repositories/auth_repositories_implementation.dart';
import 'package:flutterclean/features/auth/domain/repositories/users_repositories.dart';
import 'package:flutterclean/features/auth/domain/usecases/auth_usecase.dart';
import 'package:flutterclean/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutterclean/features/cart/data/datasources/cart_datasources.dart';
import 'package:flutterclean/features/cart/data/repositories/cart_repositories_implementation.dart';
import 'package:flutterclean/features/cart/domain/repositories/cart_repositories.dart';
import 'package:flutterclean/features/cart/domain/usecases/cart_usecases.dart';
import 'package:flutterclean/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:flutterclean/features/favorite/data/datasources/favorite_datasource.dart';
import 'package:flutterclean/features/favorite/data/repositories/favorite_repositories_implementation.dart';
import 'package:flutterclean/features/favorite/domain/repositories/favorite_repositories.dart';
import 'package:flutterclean/features/favorite/domain/usecases/favorite_usecases.dart';
import 'package:flutterclean/features/favorite/presentation/bloc/favorite_bloc.dart';
import 'package:flutterclean/features/ProductCategory/data/datasources/category_datasource.dart';
import 'package:flutterclean/features/ProductCategory/data/repositories/category_repositories_implementation.dart';
import 'package:flutterclean/features/ProductCategory/domain/repositories/category_repositories.dart';
import 'package:flutterclean/features/ProductCategory/domain/usecases/category_usecases.dart';
import 'package:flutterclean/features/ProductCategory/presentation/bloc/category_bloc.dart';
import 'package:flutterclean/features/ProductType/data/datasources/product_type_datasource.dart';
import 'package:flutterclean/features/ProductType/data/repositories/product_type_repositories_implementation.dart';
import 'package:flutterclean/features/ProductType/domain/repositories/product_type_repositories.dart';
import 'package:flutterclean/features/ProductType/domain/usecases/product_type_usecases.dart';
import 'package:flutterclean/features/ProductType/presentation/bloc/product_type_bloc.dart';
import 'package:flutterclean/features/Supplier/data/datasources/supplier_datasource.dart';
import 'package:flutterclean/features/Supplier/data/repositories/supplier_repositories_implementation.dart';
import 'package:flutterclean/features/Supplier/domain/repositories/supplier_repositories.dart';
import 'package:flutterclean/features/Supplier/domain/usecases/supplier_usecases.dart';
import 'package:flutterclean/features/Supplier/presentation/bloc/supplier_bloc.dart';
import 'package:flutterclean/features/produk/data/datasources/produk_datasource.dart';
import 'package:flutterclean/features/produk/data/repositories/produk_repo_impl.dart';
import 'package:flutterclean/features/produk/domain/repositories/produk_repositories.dart';
import 'package:flutterclean/features/produk/domain/usecases/produk_usecases.dart';
import 'package:flutterclean/features/produk/presentation/bloc/produk_bloc.dart';
import 'package:flutterclean/features/warehouse/data/datasources/warehouse_datasource.dart';
import 'package:flutterclean/features/warehouse/data/repositories/warehouse_repositories_implementation.dart';
import 'package:flutterclean/features/warehouse/domain/repositories/warehouse_repositories.dart';
import 'package:flutterclean/features/warehouse/domain/usecases/warehouse_usecases.dart';
import 'package:flutterclean/features/warehouse/presentation/bloc/warehouse_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';

var myinjection = GetIt.instance;
Future<void> init() async {
  myinjection.registerLazySingleton(() => FirebaseAuth.instance);
  myinjection.registerLazySingleton(() => FirebaseFirestore.instance);
  var box = await Hive.openBox('box');
  myinjection.registerLazySingleton(() => box);
  // myinjection.registerLazySingleton(() => FirebaseStorage.instance);

  //optionCubit
  myinjection.registerFactory(
    () => OptionCubit(),
  );

  /// FEATURE - AUTH
  // BLOC
  myinjection.registerFactory(
    () => AuthBloc(
      signInWithEmail: myinjection(),
      registerWithEmail: myinjection(),
    ),
  );

  // USECASE
  myinjection.registerLazySingleton(
    () => SignInWithEmail(repository: myinjection()),
  );
  myinjection.registerLazySingleton(
    () => RegisterWithEmail(repository: myinjection()),
  );

  // REPOSITORY
  myinjection.registerLazySingleton<AuthRepository>(
    () => AuthRepositoriesImplementation(dataSource: myinjection()),
  );

  // DATA SOURCE
  myinjection.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImplementation(
      firebaseAuth: myinjection<FirebaseAuth>(),
      firebaseFirestore: myinjection<FirebaseFirestore>(),
      box: myinjection(),
    ),
  );

  /// FEATURE - PRODUK
  // BLOC
  myinjection.registerFactory(
    () => ProdukBloc(
      produkUsecasesAdd: myinjection(),
      produkUsecasesDeleteProduk: myinjection(),
      produkUsecasesEditProduk: myinjection(),
      produkUsecasesGetAll: myinjection(),
      produkUsecasesGetById: myinjection(),
    ),
  );

  // USECASE
  myinjection.registerLazySingleton(
    () => ProdukUsecasesAddProduk(produkRepositories: myinjection()),
  );
  myinjection.registerLazySingleton(
    () => ProdukUsecasesDeleteProduk(produkRepositories: myinjection()),
  );
  myinjection.registerLazySingleton(
    () => ProdukUsecasesEditProduk(produkRepositories: myinjection()),
  );
  myinjection.registerLazySingleton(
    () => ProdukUsecasesGetAll(produkRepositories: myinjection()),
  );
  myinjection.registerLazySingleton(
    () => ProdukUsecasesGetById(produkRepositories: myinjection()),
  );

  // REPOSITORY
  myinjection.registerLazySingleton<ProdukRepositories>(
    () => ProdukRepoImpl(produkRemoteDataSource: myinjection()),
  );

  // DATA SOURCE
  myinjection.registerLazySingleton<ProdukRemoteDataSource>(() =>
      ProdukRemoteDataSourceImplementation(firebaseFirestore: myinjection()));

  /// FEATURE - Category
  // BLOC
  myinjection.registerFactory(
    () => CategoryBloc(
      categoryUsecasesAdd: myinjection(),
      categoryUsecasesDelete: myinjection(),
      categoryUsecasesEdit: myinjection(),
      categoryUsecasesGetAll: myinjection(),
      categoryUsecasesGetById: myinjection(),
    ),
  );

  // USECASE
  myinjection.registerLazySingleton(
    () => CategoryUsecasesAdd(categoryRepositories: myinjection()),
  );
  myinjection.registerLazySingleton(
    () => CategoryUsecasesEdit(categoryRepositories: myinjection()),
  );
  myinjection.registerLazySingleton(
    () => CategoryUsecasesDelete(categoryRepositories: myinjection()),
  );
  myinjection.registerLazySingleton(
    () => CategoryUsecasesGetAll(categoryRepositories: myinjection()),
  );
  myinjection.registerLazySingleton(
    () => CategoryUsecasesGetById(categoryRepositories: myinjection()),
  );

  // REPOSITORY
  myinjection.registerLazySingleton<CategoryRepositories>(
    () => CategoryRepositoriesImplementation(
        categoryRemoteDatasource: myinjection()),
  );

  // DATA SOURCE
  myinjection.registerLazySingleton<CategoryRemoteDatasource>(() =>
      CategoryRemoteDatasourceImplementation(firebaseFirestore: myinjection()));

  /// FEATURE - PRODUK TYPE
  // BLOC
  myinjection.registerFactory(
    () => ProductTypeBloc(
      productTypeUsecasesAdd: myinjection(),
      productTypeUsecasesDelete: myinjection(),
      productTypeUsecasesEdit: myinjection(),
      productTypeUsecasesGetAll: myinjection(),
      productTypeUsecasesGetById: myinjection(),
    ),
  );

  // USECASE
  myinjection.registerLazySingleton(
    () => ProductTypeUsecasesAdd(productTypeRepositories: myinjection()),
  );
  myinjection.registerLazySingleton(
    () => ProductTypeUsecasesEdit(productTypeRepositories: myinjection()),
  );
  myinjection.registerLazySingleton(
    () => ProductTypeUsecasesDelete(productTypeRepositories: myinjection()),
  );
  myinjection.registerLazySingleton(
    () => ProductTypeUsecasesGetAll(productTypeRepositories: myinjection()),
  );
  myinjection.registerLazySingleton(
    () => ProductTypeUsecasesGetById(productTypeRepositories: myinjection()),
  );

  // REPOSITORY
  myinjection.registerLazySingleton<ProductTypeRepositories>(
    () => ProductTypeRepositoriesImplementation(
        productTypeRemoteDataSource: myinjection()),
  );

  // DATA SOURCE
  myinjection.registerLazySingleton<ProductTypeRemoteDatasource>(() =>
      ProductTypeRemoteDatasourceImplementation(
          firebaseFirestore: myinjection()));

  /// FEATURE - WAREHOUSE
  // BLOC
  myinjection.registerFactory(
    () => WarehouseBloc(
      warehouseUsecasesAdd: myinjection(),
      warehouseUsecasesDelete: myinjection(),
      warehouseUsecasesEdit: myinjection(),
      warehouseUsecasesGetAll: myinjection(),
      warehouseUsecasesGetById: myinjection(),
    ),
  );

  // USECASE
  myinjection.registerLazySingleton(
    () => WarehouseUsecasesAdd(warehouseRepositories: myinjection()),
  );
  myinjection.registerLazySingleton(
    () => WarehouseUsecasesEdit(warehouseRepositories: myinjection()),
  );
  myinjection.registerLazySingleton(
    () => WarehouseUsecasesDelete(warehouseRepositories: myinjection()),
  );
  myinjection.registerLazySingleton(
    () => WarehouseUsecasesGetAll(warehouseRepositories: myinjection()),
  );
  myinjection.registerLazySingleton(
    () => WarehouseUsecasesGetById(warehouseRepositories: myinjection()),
  );

  // REPOSITORY
  myinjection.registerLazySingleton<WarehouseRepositories>(
    () => WarehouseRepositoriesImplementation(
        warehouseRemoteDataSource: myinjection()),
  );

  // DATA SOURCE
  myinjection.registerLazySingleton<WarehouseRemoteDatasource>(() =>
      WarehouseRemoteDatasourceImplementation(
          firebaseFirestore: myinjection()));

  /// FEATURE - SUPPLIER
  // BLOC
  myinjection.registerFactory(
    () => SupplierBloc(
      supplierUsecasesAdd: myinjection(),
      supplierUsecasesDelete: myinjection(),
      supplierUsecasesEdit: myinjection(),
      supplierUsecasesGetAll: myinjection(),
      supplierUsecasesGetById: myinjection(),
    ),
  );

  // USECASE
  myinjection.registerLazySingleton(
    () => SupplierUseCasesAdd(supplierRepositories: myinjection()),
  );
  myinjection.registerLazySingleton(
    () => SupplierUseCasesEdit(supplierRepositories: myinjection()),
  );
  myinjection.registerLazySingleton(
    () => SupplierUseCasesDelete(supplierRepositories: myinjection()),
  );
  myinjection.registerLazySingleton(
    () => SupplierUseCasesGetAll(supplierRepositories: myinjection()),
  );
  myinjection.registerLazySingleton(
    () => SupplierUseCasesGetById(supplierRepositories: myinjection()),
  );

  // REPOSITORY
  myinjection.registerLazySingleton<SupplierRepositories>(
    () => SupplierRepositoriesImplementation(
        supplierRemoteDatasource: myinjection()),
  );

  // DATA SOURCE
  myinjection.registerLazySingleton<SupplierRemoteDatasource>(() =>
      SupplierRemoteDatasourceImplementation(firebaseFirestore: myinjection()));

  /// FEATURE - FAVORITE
  // BLOC
  myinjection.registerFactory(
    () => FavoriteBloc(
      favoriteUsecasesAdd: myinjection(),
      favoriteUsecasesDelete: myinjection(),
      favoriteUsecasesEdit: myinjection(),
      favoriteUsecasesGetAll: myinjection(),
      favoriteUsecasesGetById: myinjection(),
    ),
  );

  // USECASE
  myinjection.registerLazySingleton(
    () => FavoriteUsecasesAdd(favoriteRepositories: myinjection()),
  );
  myinjection.registerLazySingleton(
    () => FavoriteUsecasesEdit(favoriteRepositories: myinjection()),
  );
  myinjection.registerLazySingleton(
    () => FavoriteUsecasesDelete(favoriteRepositories: myinjection()),
  );
  myinjection.registerLazySingleton(
    () => FavoriteUsecasesGetAll(favoriteRepositories: myinjection()),
  );
  myinjection.registerLazySingleton(
    () => FavoriteUsecasesGetById(favoriteRepositories: myinjection()),
  );

  // REPOSITORY
  myinjection.registerLazySingleton<FavoriteRepositories>(
    () => FavoriteRepositoriesImplementation(
        favoriteRemoteDatasource: myinjection()),
  );

  // DATA SOURCE
  myinjection.registerLazySingleton<FavoriteRemoteDatasource>(() =>
      FavoriteRemoteDatasourceImplementation(firebaseFirestore: myinjection()));


  /// FEATURE - CART
  // BLOC
  myinjection.registerFactory(
    () => CartBloc(
      cartUsecasesAdd: myinjection(),
      cartUsecasesDelete: myinjection(),
      cartUsecasesEdit: myinjection(),
      cartUsecasesGetAll: myinjection(),
      cartUsecasesGetById: myinjection(),
    ),
  );

  // USECASE
  myinjection.registerLazySingleton(
    () => CartUsecasesAdd(cartRepositories: myinjection()),
  );
  myinjection.registerLazySingleton(
    () => CartUsecasesEdit(cartRepositories: myinjection()),
  );
  myinjection.registerLazySingleton(
    () => CartUsecasesDelete(cartRepositories: myinjection()),
  );
  myinjection.registerLazySingleton(
    () => CartUsecasesGetAll(cartRepositories: myinjection()),
  );
  myinjection.registerLazySingleton(
    () => CartUsecasesGetById(cartRepositories: myinjection()),
  );

  // REPOSITORY
  myinjection.registerLazySingleton<CartRepositories>(
    () => CartRepositoriesImplementation(
        cartRemoteDatasource: myinjection()),
  );

  // DATA SOURCE
  myinjection.registerLazySingleton<CartRemoteDatasource>(() =>
      CartRemoteDatasourceImplementation(firebaseFirestore: myinjection()));
}
