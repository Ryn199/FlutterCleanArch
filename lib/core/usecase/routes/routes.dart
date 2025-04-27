import 'package:flutterclean/features/Auth/presentation/pages/login.dart';
import 'package:flutterclean/features/Auth/presentation/pages/register.dart';
import 'package:flutterclean/features/Favorite/presentation/pages/favorite_page.dart';
import 'package:flutterclean/features/ProductCategory/presentation/pages/Category_page.dart';
import 'package:flutterclean/features/ProductType/presentation/pages/product_type_page.dart';
import 'package:flutterclean/features/Supplier/presentation/pages/supplier_page.dart';
import 'package:flutterclean/features/produk/presentation/pages/produk_page.dart';
import 'package:flutterclean/features/warehouse/presentation/pages/warehouse_page.dart';
import 'package:go_router/go_router.dart';

class MyRouter {
  get router => GoRouter(
        initialLocation: '/',
        routes: [
          GoRoute(
            path: '/',
            name: 'login',
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: LoginPage()),
          ),
          GoRoute(
            path: '/register',
            name: 'register',
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: RegisterPages()),
          ),
          GoRoute(
            path: '/product',
            name: 'product',
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: ProdukPages()),
          ),
          GoRoute(
            path: '/category',
            name: 'category',
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: CategoryPage()),
          ),
          GoRoute(
            path: '/product-type',
            name: 'product-type',
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: ProductTypePage()),
          ),
          GoRoute(
            path: '/suplier',
            name: 'suplier',
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: SupplierPage()),
          ),
          GoRoute(
            path: '/warehouse',
            name: 'warehouse',
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: WarehousePage()),
          ),
          GoRoute(
            path: '/favorite',
            name: 'favorite',
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: FavoritePage()),
          ),
          // GoRoute(
          //   path: '/keranjang',
          //   name: 'keranjang',
          //   pageBuilder: (context, state) =>
          //       const NoTransitionPage(child: KeranjangPage()),
          // ),
        ],
      );
}

// class MyRouter {
//   get router => GoRouter(
//     initialLocation:
//     '/product',
//     routes: [
//       GoRoute(
//         path: '/product',
//         name: 'produk',
//         pageBuilder: (context, state) => NoTransitionPage(child: ProdukPages()),
        
//       ),
//       GoRoute(
//         path: '/category',
//         name: 'category',
//         pageBuilder: (context, state) => NoTransitionPage(child: CategoryPage()),
//       ),
//       GoRoute(
//         path: '/product_type',
//         name: 'product_type',
//         pageBuilder: (context, state) => NoTransitionPage(child: ProductTypePage()),
//       ),
//       GoRoute(
//         path: '/warehouse',
//         name: 'warehouse',
//         pageBuilder: (context, state) => NoTransitionPage(child: WarehousePage()),
//       ),
//       GoRoute(
//         path: '/supplier',
//         name: 'supplier',
//         pageBuilder: (context, state) => NoTransitionPage(child: SupplierPage()),
//       ),
//     ],
//   );
// }