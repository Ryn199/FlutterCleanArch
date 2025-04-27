import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterclean/core/usecase/routes/routes.dart';
import 'package:flutterclean/features/ProductCategory/presentation/bloc/category_bloc.dart';
import 'package:flutterclean/features/ProductType/presentation/bloc/product_type_bloc.dart';
import 'package:flutterclean/features/Supplier/presentation/bloc/supplier_bloc.dart';
import 'package:flutterclean/features/produk/presentation/bloc/produk_bloc.dart';
import 'package:flutterclean/features/warehouse/presentation/bloc/warehouse_bloc.dart';
import 'package:flutterclean/firebase_options.dart';
import 'package:flutterclean/my_injection.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProdukBloc>(
          create: (context) => ProdukBloc(
            produkUsecasesAdd: myinjection(),
            produkUsecasesDeleteProduk: myinjection(),
            produkUsecasesEditProduk: myinjection(),
            produkUsecasesGetAll: myinjection(),
            produkUsecasesGetById: myinjection(),
          ),
        ),
        BlocProvider<CategoryBloc>(
          create: (context) => CategoryBloc(
            categoryUsecasesAdd: myinjection(),
            categoryUsecasesDelete: myinjection(),
            categoryUsecasesEdit: myinjection(),
            categoryUsecasesGetAll: myinjection(),
            categoryUsecasesGetById: myinjection(),
          ),
        ),
        BlocProvider<ProductTypeBloc>(
          create: (context) => ProductTypeBloc(
            productTypeUsecasesAdd: myinjection(),
            productTypeUsecasesDelete: myinjection(),
            productTypeUsecasesEdit: myinjection(),
            productTypeUsecasesGetAll: myinjection(),
            productTypeUsecasesGetById: myinjection(),
          ),
        ),
        BlocProvider<WarehouseBloc>(
          create: (context) => WarehouseBloc(
            warehouseUsecasesAdd: myinjection(),
            warehouseUsecasesDelete: myinjection(),
            warehouseUsecasesEdit: myinjection(),
            warehouseUsecasesGetAll: myinjection(),
            warehouseUsecasesGetById: myinjection(),
          ),
        ),
        BlocProvider<SupplierBloc>(
          create: (context) => SupplierBloc(
            supplierUsecasesAdd: myinjection(),
            supplierUsecasesDelete: myinjection(),
            supplierUsecasesEdit: myinjection(),
            supplierUsecasesGetAll: myinjection(),
            supplierUsecasesGetById: myinjection(),
          ),
        ),
      ],
      child: MaterialApp.router(
        themeMode: ThemeMode.light,
        color: Colors.white,
        // theme: AppThemes.light,
        // darkTheme: AppTheme.dark,
        routerConfig: MyRouter().router,
        // routerDelegate: AutoRouterDelegate(router),
        // routeInformationParser: router.defaultRouteParser(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
