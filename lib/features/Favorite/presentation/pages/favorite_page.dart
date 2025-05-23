import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterclean/features/favorite/presentation/bloc/favorite_bloc.dart';
import 'package:flutterclean/features/ProductCategory/presentation/bloc/category_bloc.dart';
import 'package:flutterclean/features/ProductCategory/presentation/bloc/category_state.dart';
import 'package:flutterclean/features/ProductType/presentation/bloc/product_type_bloc.dart';
import 'package:flutterclean/features/ProductType/presentation/bloc/product_type_state.dart';
import 'package:flutterclean/features/favorite/presentation/bloc/favorite_state.dart';
import 'package:flutterclean/features/warehouse/presentation/bloc/warehouse_bloc.dart';
import 'package:flutterclean/features/warehouse/presentation/bloc/warehouse_event.dart';
import 'package:flutterclean/features/warehouse/presentation/bloc/warehouse_state.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Pages'),
      ),
      body: BlocConsumer<FavoriteBloc, FavoriteState>(
        bloc: context.read<FavoriteBloc>()..add(FavoriteEventGetAll()),
        listener: (context, state) {
          if (state is FavoriteStateError) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          }
          if (state is FavoriteStateSuccess) {
            context.read<FavoriteBloc>().add(FavoriteEventGetAll());
          }
        },
        builder: (context, state) {
          if (state is FavoriteStateLoadedAll) {
            return ListView.builder(
              itemCount: state.favorites.length,
              itemBuilder: (context, index) {
                var favorite = state.favorites[index];

                //list favorite
                return ListTile(
                  title: Text(favorite.namaProduk),
                  subtitle: SizedBox(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('Harga: ${favorite.harga}'),
                        Text('Deskripsi: ${favorite.deskripsi}'),

                        // BlocBuilder untuk Kategori
                        if (favorite.categoryId != null &&
                            favorite.categoryId!.isNotEmpty)
                          BlocBuilder<CategoryBloc, CategoryState>(
                            bloc: context.read<CategoryBloc>()
                              ..add(
                                  CategoryEventGetById(id: favorite.categoryId!)),
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
                        if (favorite.productTypeId != null &&
                            favorite.productTypeId!.isNotEmpty)
                          BlocBuilder<ProductTypeBloc, ProductTypeState>(
                            bloc: context.read<ProductTypeBloc>()
                              ..add(ProductTypeEventGetById(
                                  id: favorite.productTypeId ?? '')),
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
                        if (favorite.warehouseId != null &&
                            favorite.warehouseId!.isNotEmpty)
                          BlocBuilder<WarehouseBloc, WarehouseState>(
                            bloc: context.read<WarehouseBloc>()
                              ..add(WarehouseEventGetById(
                                  id: favorite.warehouseId ?? '')),
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
                                .read<FavoriteBloc>()
                                .add(FavoriteEventDelete(id: favorite.id));
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
          if (state is FavoriteStateLoading) {
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
