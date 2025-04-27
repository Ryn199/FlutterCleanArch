import 'package:clean_flutter/features/category_product/presentation/bloc/category_bloc.dart';
import 'package:clean_flutter/features/gudang/presentation/bloc/gudang_bloc.dart';
import 'package:clean_flutter/features/product/data/models/product_model.dart';
import 'package:clean_flutter/features/product/domain/entities/product.dart';
import 'package:clean_flutter/features/product/presentation/bloc/product_bloc.dart';
import 'package:clean_flutter/features/type_product/presentation/bloc/type_product_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ProdukPages extends StatelessWidget {
  const ProdukPages({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Produk Pages'),
        actions: [
          IconButton(
              onPressed: () {
                showProdukFormModal(context);
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: BlocConsumer<ProdukBloc, ProdukState>(
        bloc: context.read<ProdukBloc>()..add(ProdukEventGetAll()),
        listener: (context, state) {
          if (state is ProdukStateError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
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
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        children: [
                          ListTile(
                            title: Text(produk.namaProduk),
                            subtitle: Text(produk.harga),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    showProdukFormModal(context,
                                        produk: produk);
                                  },
                                  icon: const Icon(Icons.edit),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () {
                                    context
                                        .read<ProdukBloc>()
                                        .add(ProdukEventDelete(id: produk.id));
                                  },
                                ),
                              ],
                            ),
                          ),
                          //widget category
                          produk.categoryId != null &&
                                  produk.categoryId!.isNotEmpty
                              ? BlocBuilder<CategoryBloc, CategoryState>(
                                  bloc: context.read<CategoryBloc>()
                                    ..add(CategoryEventGetById(
                                        id: produk.categoryId ??
                                            '')), //get category berdasarkan produk -> categoryid
                                  builder: (context, statecategory) {
                                    if (statecategory is CategoryStateError) {
                                      return Text(statecategory.message);
                                    }
                                    if (statecategory is CategoryStateLoaded) {
                                      return Text(
                                          statecategory.category.namaCat);
                                    }
                                    return const SizedBox();
                                  },
                                )
                              : const SizedBox(),
                          // Widget Jenis
                          produk.typeId != null && produk.typeId!.isNotEmpty
                              ? BlocBuilder<TypeBloc, TypeProductState>(
                                  bloc: context.read<TypeBloc>()
                                    ..add(TypeEventGetById(
                                        id: produk.typeId ?? '')),
                                  builder: (context, statetype) {
                                    if (statetype is TypeProductStateError) {
                                      return Text(statetype.message);
                                    }
                                    if (statetype is TypeProductStateLoaded) {
                                      return Text(statetype.type.namatype);
                                    }
                                    return const SizedBox();
                                  },
                                )
                              : const SizedBox(),
                          // Widget Gudang
                          produk.gudangId != null && produk.gudangId!.isNotEmpty
                              ? BlocBuilder<GudangBloc, GudangState>(
                                  bloc: context.read<GudangBloc>()
                                    ..add(GudangEventGetById(
                                        id: produk.gudangId ?? '')),
                                  builder: (context, stategudang) {
                                    if (stategudang is GudangStateLoaded) {
                                      return Text(
                                          stategudang.gudang.namaGudang);
                                    }
                                    if (stategudang is GudangStateError) {
                                      return Text(stategudang.message);
                                    }
                                    return const SizedBox();
                                  },
                                )
                              : const SizedBox()
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
          if (state is ProdukStateLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }

  // Membuat variabel produk yang mengambil type dari entitas produk untuk menampung kiriman produk seperti di edit
  void showProdukFormModal(BuildContext context, {Produk? produk}) {
    // merekam isi data yang dikirim oleh edit berdasarkan struktur entitas Produk
    final isEdit = produk != null;
    final namaProdukController =
        TextEditingController(text: produk?.namaProduk ?? '');
    // final categoryIdController =
    //     TextEditingController(text: produk?.categoryId ?? '');
    // final typeIdController = TextEditingController(text: produk?.typeId ?? '');
    // final GudangIdController =
    //     TextEditingController(text: produk?.gudangId ?? '');
    final hargaProdukController =
        TextEditingController(text: produk?.harga ?? '');
    final deskripsiProdukController =
        TextEditingController(text: produk?.deskripsi ?? '');

    showDialog(
      // Struktur UI Modal
      context: context,
      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Text(isEdit ? 'Edit Produk' : 'Tambah Produk'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: namaProdukController,
                  decoration: const InputDecoration(
                    labelText: 'Nama Produk',
                    border: OutlineInputBorder(),
                  ),
                ),

                // DropdownMenu(dropdownMenuEntries: <dropdownMenuEntries<Color>>[
                //   DropdownMenuEntry(value: value, label: label)
                // ])
                SizedBox(
                  width: 500,
                  child: TextFormField(
                    controller: hargaProdukController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: const InputDecoration(
                      labelText: 'Harga Produk',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                TextFormField(
                  controller: deskripsiProdukController,
                  decoration: const InputDecoration(
                    labelText: 'Deskripsi Produk',
                    border: OutlineInputBorder(),
                  ),
                ),
                BlocConsumer<ProdukBloc, ProdukState>(
                  listener: (context, state) {
                    if (state is ProdukStateError) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(state.message)),
                      );
                    }
                    if (state is ProdukStateSuccess) {
                      context.pop();
                      context.read<ProdukBloc>().add(ProdukEventGetAll());
                    }
                  },
                  builder: (context, state) {
                    return IconButton(
                      onPressed: () {
                        if (isEdit == true) {
                          final model = ProdukModel(
                              id: produk!.id,
                              namaProduk: namaProdukController.text,
                              harga: hargaProdukController.text,
                              deskripsi: deskripsiProdukController.text,
                              updatedAt: DateTime.now());
                          context
                              .read<ProdukBloc>()
                              .add(ProdukEventEdit(produkModel: model));
                        } else {
                          final model = ProdukModel(
                              id: '',
                              namaProduk: namaProdukController.text,
                              harga: hargaProdukController.text,
                              deskripsi: deskripsiProdukController.text,
                              createdAt: DateTime.now(),
                              updatedAt: DateTime.now());
                          context
                              .read<ProdukBloc>()
                              .add(ProdukEventAdd(produkModel: model));
                        }
                      },
                      icon: state is ProdukStateLoading
                          ? const Text('Loading...')
                          : const Icon(Icons.save),
                    );
                  },
                ),
              ],
            ),
          ),
        );
        // return Padding(
        //   padding: const EdgeInsets.all(15),
        //   child: Column(
        //     mainAxisSize: MainAxisSize.min,
      },
    );
  }
}