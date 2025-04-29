import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterclean/features/cart/data/models/cart_model.dart';
import 'package:flutterclean/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:flutterclean/features/cart/presentation/bloc/cart_state.dart';
import 'package:flutterclean/features/favorite/data/models/favorite_model.dart';
import 'package:flutterclean/features/favorite/presentation/bloc/favorite_bloc.dart';
import 'package:flutterclean/features/ProductCategory/presentation/bloc/category_bloc.dart';
import 'package:flutterclean/features/ProductCategory/presentation/bloc/category_state.dart';
import 'package:flutterclean/features/ProductType/presentation/bloc/product_type_bloc.dart';
import 'package:flutterclean/features/ProductType/presentation/bloc/product_type_state.dart';
import 'package:flutterclean/features/produk/data/models/produk_model.dart';
import 'package:flutterclean/features/produk/presentation/bloc/produk_bloc.dart';
import 'package:flutterclean/features/warehouse/presentation/bloc/warehouse_bloc.dart';
import 'package:flutterclean/features/warehouse/presentation/bloc/warehouse_event.dart';
import 'package:flutterclean/features/warehouse/presentation/bloc/warehouse_state.dart';
import 'package:go_router/go_router.dart';

class ProdukPages extends StatelessWidget {
  const ProdukPages({super.key});

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Produk Pages'),
        actions: [
          IconButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    TextEditingController namaProdukController =
                        TextEditingController();
                    TextEditingController hargaProdukController =
                        TextEditingController();
                    TextEditingController deskripsiProdukController =
                        TextEditingController();
                    String? selectedCategoryIdValue;
                    String? selectedProductTypeIdValue;
                    String? selectedWarehouseIdValue;
                    // TextEditingController productTypeIdController =
                    //     TextEditingController();
                    // TextEditingController warehouseIdController =
                    //     TextEditingController();

                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ListView(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: namaProdukController,
                            decoration: const InputDecoration(
                                labelText: "Nama Produk",
                                border: OutlineInputBorder()),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: hargaProdukController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                                labelText: "Harga Produk",
                                border: OutlineInputBorder()),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: deskripsiProdukController,
                            decoration: const InputDecoration(
                                labelText: "Deskripsi Produk",
                                border: OutlineInputBorder()),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          //DROPDOWN CATEGORY
                          BlocBuilder<CategoryBloc, CategoryState>(
                              bloc: context.read<CategoryBloc>()
                                ..add(CategoryEventGetAll()),
                              builder: (context, state) {
                                if (state is CategoryStateLoadedAll) {
                                  return DropdownButtonFormField<String>(
                                    value: state.categories.first.id,
                                    items: state.categories
                                        .map((e) => DropdownMenuItem(
                                              value: e.id,
                                              child: Text(e.categoryName),
                                            ))
                                        .toList(),
                                    onChanged: (value) {
                                      selectedCategoryIdValue = value;
                                    },
                                  );
                                }
                                return Container();
                              }),
                          SizedBox(
                            height: 10,
                          ),
                          //DROPDOWN ProductType
                          BlocBuilder<ProductTypeBloc, ProductTypeState>(
                              bloc: context.read<ProductTypeBloc>()
                                ..add(ProductTypeEventGetAll()),
                              builder: (context, state) {
                                if (state is ProductTypeStateLoadedAll) {
                                  return DropdownButtonFormField<String>(
                                    value: state.productTypes.first.id,
                                    items: state.productTypes
                                        .map((e) => DropdownMenuItem(
                                              value: e.id,
                                              child: Text(e.productTypeName),
                                            ))
                                        .toList(),
                                    onChanged: (value) {
                                      selectedProductTypeIdValue = value;
                                    },
                                  );
                                }
                                return Container();
                              }),
                          SizedBox(
                            height: 10,
                          ),
                          //DROPDOWN WAREHOUSES
                          BlocBuilder<WarehouseBloc, WarehouseState>(
                              bloc: context.read<WarehouseBloc>()
                                ..add(WarehouseEventGetAll()),
                              builder: (context, state) {
                                if (state is WarehouseStateLoadedAll) {
                                  return DropdownButtonFormField<String>(
                                    value: state.warehouses.first.id,
                                    items: state.warehouses
                                        .map((e) => DropdownMenuItem(
                                              value: e.id,
                                              child: Text(e.warehouseName),
                                            ))
                                        .toList(),
                                    onChanged: (value) {
                                      selectedWarehouseIdValue = value;
                                    },
                                  );
                                }
                                return Container();
                              }),
                          SizedBox(
                            height: 10,
                          ),
                          BlocConsumer<ProdukBloc, ProdukState>(
                            listener: (context, state) {
                              if (state is ProdukStateError) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(state.message)));
                              }
                              if (state is ProdukStateSuccess) {
                                context.pop();
                                context
                                    .read<ProdukBloc>()
                                    .add(ProdukEventGetAll());
                              }
                            },
                            builder: (context, state) {
                              return IconButton(
                                  onPressed: () {
                                    context
                                        .read<ProdukBloc>()
                                        .add(ProdukEventAdd(
                                            produkModel: ProdukModel(
                                          id: '',
                                          namaProduk: namaProdukController.text,
                                          harga: hargaProdukController.text,
                                          deskripsi:
                                              deskripsiProdukController.text,
                                          categoryId: selectedCategoryIdValue
                                              .toString(),
                                          productTypeId:
                                              selectedProductTypeIdValue
                                                  .toString(),
                                          warehouseId: selectedWarehouseIdValue
                                              .toString(),
                                        )));
                                  },
                                  icon: state is ProdukStateLoading
                                      ? Text('Loading...')
                                      : Icon(Icons.save));
                            },
                          )
                        ],
                      ),
                    );
                  },
                );
              },
              icon: Icon(Icons.plus_one))
        ],
      ),
      body: BlocConsumer<ProdukBloc, ProdukState>(
        bloc: context.read<ProdukBloc>()..add(ProdukEventGetAll()),
        listener: (context, state) {
          if (state is ProdukStateError) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          }
          if (state is ProdukStateSuccess) {
            context.read<ProdukBloc>().add(ProdukEventGetAll());
          }
        },
        builder: (context, state) {
          if (state is ProdukStateLoadedAll) {
            return ListView.builder(
              itemCount: state.produks.length,
              itemBuilder: (context, index) {
                var produk = state.produks[index];

                //list produk
                return ListTile(
                  title: Text(produk.namaProduk),
                  subtitle: SizedBox(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('Harga: ${produk.harga}'),
                        Text('Deskripsi: ${produk.deskripsi}'),

                        // BlocBuilder untuk Kategori
                        if (produk.categoryId != null &&
                            produk.categoryId!.isNotEmpty)
                          BlocBuilder<CategoryBloc, CategoryState>(
                            bloc: context.read<CategoryBloc>()
                              ..add(
                                  CategoryEventGetById(id: produk.categoryId!)),
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
                        if (produk.productTypeId != null &&
                            produk.productTypeId!.isNotEmpty)
                          BlocBuilder<ProductTypeBloc, ProductTypeState>(
                            bloc: context.read<ProductTypeBloc>()
                              ..add(ProductTypeEventGetById(
                                  id: produk.productTypeId ?? '')),
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
                        if (produk.warehouseId != null &&
                            produk.warehouseId!.isNotEmpty)
                          BlocBuilder<WarehouseBloc, WarehouseState>(
                            bloc: context.read<WarehouseBloc>()
                              ..add(WarehouseEventGetById(
                                  id: produk.warehouseId ?? '')),
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
                                .read<ProdukBloc>()
                                .add(ProdukEventDelete(id: produk.id));
                          },
                          icon: Icon(Icons.delete, color: Colors.red),
                        ),

                        //edit modal
                        IconButton(
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              builder: (context) {
                                TextEditingController namaProdukController =
                                    TextEditingController(
                                        text: produk.namaProduk);
                                TextEditingController hargaProdukController =
                                    TextEditingController(text: produk.harga);
                                TextEditingController
                                    deskripsiProdukController =
                                    TextEditingController(
                                        text: produk.deskripsi);
                                TextEditingController categoryIdController =
                                    TextEditingController(
                                        text: produk.categoryId);
                                TextEditingController productTypeIdController =
                                    TextEditingController(
                                        text: produk.productTypeId);
                                TextEditingController warehouseIdController =
                                    TextEditingController(
                                        text: produk.warehouseId);
                                return Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text("Nama Produk"),
                                      TextFormField(
                                          controller: namaProdukController),
                                      Text("Harga Produk"),
                                      TextFormField(
                                          controller: hargaProdukController,
                                          keyboardType: TextInputType.number),
                                      Text("Deskripsi Produk"),
                                      TextFormField(
                                          controller:
                                              deskripsiProdukController),
                                      Text("Id Kategori Produk"),
                                      TextFormField(
                                          controller: categoryIdController),
                                      Text("Id Jenis Produk"),
                                      TextFormField(
                                          controller: productTypeIdController),
                                      Text("Id Gudang"),
                                      TextFormField(
                                          controller: warehouseIdController),
                                      BlocConsumer<ProdukBloc, ProdukState>(
                                        listener: (context, state) {
                                          if (state is ProdukStateError) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                                    content:
                                                        Text(state.message)));
                                          }
                                          if (state is ProdukStateSuccess) {
                                            namaProdukController.clear();
                                            hargaProdukController.clear();
                                            deskripsiProdukController.clear();
                                            categoryIdController.clear();
                                            productTypeIdController.clear();
                                            warehouseIdController.clear();

                                            context.pop();
                                            context
                                                .read<ProdukBloc>()
                                                .add(ProdukEventGetAll());
                                          }
                                        },
                                        builder: (context, state) {
                                          return IconButton(
                                            onPressed: () {
                                              context
                                                  .read<ProdukBloc>()
                                                  .add(ProdukEventEdit(
                                                    produkModel: ProdukModel(
                                                      id: produk.id,
                                                      namaProduk:
                                                          namaProdukController
                                                              .text,
                                                      harga:
                                                          hargaProdukController
                                                              .text,
                                                      deskripsi:
                                                          deskripsiProdukController
                                                              .text,
                                                      categoryId:
                                                          categoryIdController
                                                              .text,
                                                      productTypeId:
                                                          productTypeIdController
                                                              .text,
                                                      warehouseId:
                                                          warehouseIdController
                                                              .text,
                                                    ),
                                                  ));
                                            },
                                            icon: state is ProdukStateLoading
                                                ? CircularProgressIndicator()
                                                : Icon(Icons.save),
                                          );
                                        },
                                      )
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                          icon: Icon(Icons.edit),
                        ),

                        //tambah ke favorite
                        IconButton(
                          icon: Icon(Icons.favorite_border),
                          onPressed: () {
                            final favoriteModel = FavoriteModel(
                              id: '',
                              produkId: produk.id,
                              namaProduk: produk.namaProduk,
                              harga: produk.harga,
                              deskripsi: produk.deskripsi,
                              categoryId: produk.categoryId,
                              productTypeId: produk.productTypeId,
                              warehouseId: produk.warehouseId,
                            );
                            context.read<FavoriteBloc>().add(
                                FavoriteEventAdd(favoriteModel: favoriteModel));
                          },
                        ),
                        //tambah kereanjang
                        IconButton(
                          icon: Icon(Icons.plus_one_outlined),
                          onPressed: () {
                            final cartModel = CartModel(
                              id: '',
                              produkId: produk.id,
                              quantity: '1',
                              namaProduk: produk.namaProduk,
                              harga: produk.harga,
                              deskripsi: produk.deskripsi,
                              categoryId: produk.categoryId,
                              productTypeId: produk.productTypeId,
                              warehouseId: produk.warehouseId,
                            );
                            context
                                .read<CartBloc>()
                                .add(CartEventAdd(cartModel: cartModel));
                          },
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          }
          if (state is ProdukStateLoading) {
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
