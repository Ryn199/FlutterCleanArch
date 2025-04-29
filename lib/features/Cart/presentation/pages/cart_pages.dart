import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterclean/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:flutterclean/features/ProductCategory/presentation/bloc/category_bloc.dart';
import 'package:flutterclean/features/ProductCategory/presentation/bloc/category_state.dart';
import 'package:flutterclean/features/ProductType/presentation/bloc/product_type_bloc.dart';
import 'package:flutterclean/features/ProductType/presentation/bloc/product_type_state.dart';
import 'package:flutterclean/features/cart/presentation/bloc/cart_state.dart';
import 'package:flutterclean/features/warehouse/presentation/bloc/warehouse_bloc.dart';
import 'package:flutterclean/features/warehouse/presentation/bloc/warehouse_event.dart';
import 'package:flutterclean/features/warehouse/presentation/bloc/warehouse_state.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart Pages'),
      ),
      body: BlocConsumer<CartBloc, CartState>(
        bloc: context.read<CartBloc>()..add(CartEventGetAll()),
        listener: (context, state) {
          if (state is CartStateError) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          }
          if (state is CartStateSuccess) {
            context.read<CartBloc>().add(CartEventGetAll());
          }
        },
        builder: (context, state) {
          if (state is CartStateLoadedAll) {
            return ListView.builder(
              itemCount: state.carts.length,
              itemBuilder: (context, index) {
                var cart = state.carts[index];

                //list cart
                return ListTile(
                  title: Text(cart.namaProduk),
                  subtitle: SizedBox(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('Jumlah: ${cart.quantity}'),
                        Text('Harga: ${cart.harga}'),
                        Text('Deskripsi: ${cart.deskripsi}'),

                        // BlocBuilder untuk Kategori
                        if (cart.categoryId != null &&
                            cart.categoryId!.isNotEmpty)
                          BlocBuilder<CategoryBloc, CategoryState>(
                            bloc: context.read<CategoryBloc>()
                              ..add(
                                  CategoryEventGetById(id: cart.categoryId!)),
                            builder: (context, stateCategory) {
                              if (stateCategory is CategoryStateLoaded) {
                                return Text(
                                    'Kategori: ${stateCategory.category.categoryName}');
                              } else if (stateCategory is CategoryStateError) {
                                return Text(
                                    'Kategori: ${stateCategory.message}');
                              }
                              return const Text('Kategori: Memuat...');
                            },
                          )
                        else
                          const Text('Kategori: Tidak tersedia'),

                        // Widget Jenis/ productType
                        if (cart.productTypeId != null &&
                            cart.productTypeId!.isNotEmpty)
                          BlocBuilder<ProductTypeBloc, ProductTypeState>(
                            bloc: context.read<ProductTypeBloc>()
                              ..add(ProductTypeEventGetById(
                                  id: cart.productTypeId ?? '')),
                            builder: (context, stateProductType) {
                              if (stateProductType is ProductTypeStateError) {
                                return Text(stateProductType.message);
                              }
                              if (stateProductType is ProductTypeStateLoaded) {
                                return Text('Jenis: ' +
                                    stateProductType
                                        .productTypes.productTypeName);
                              }
                              return const SizedBox();
                            },
                          )
                        else
                          const Text("Jenis: Null"),

                        // Widget Warehouse
                        if (cart.warehouseId != null &&
                            cart.warehouseId!.isNotEmpty)
                          BlocBuilder<WarehouseBloc, WarehouseState>(
                            bloc: context.read<WarehouseBloc>()
                              ..add(WarehouseEventGetById(
                                  id: cart.warehouseId ?? '')),
                            builder: (context, stateWarehouse) {
                              if (stateWarehouse is WarehouseStateError) {
                                return Text(stateWarehouse.message);
                              }
                              if (stateWarehouse is WarehouseStateLoaded) {
                                return Text('Gudang: ' +
                                    stateWarehouse.warehouse.warehouseName);
                              }
                              return const SizedBox();
                            },
                          )
                        else
                          const Text("Gudang: Null"),
                      ],
                    ),
                  ),
                  trailing: SizedBox(
                    width: 200,
                    child: Row(
                      children: [

                        //delete
                        IconButton(
                          onPressed: () {
                            context
                                .read<CartBloc>()
                                .add(CartEventDelete(id: cart.id));
                          },
                          icon: Icon(Icons.delete, color: Colors.red),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
          if (state is CartStateLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return SizedBox();
        },
      ),
    );
  }
}
