import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterclean/features/Favorite/presentation/bloc/favorite_bloc.dart';
import 'package:flutterclean/features/Favorite/presentation/bloc/favorite_state.dart';
import 'package:flutterclean/features/produk/domain/entities/produk.dart';
import 'package:flutterclean/features/produk/presentation/bloc/produk_bloc.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  void initState() {
    super.initState();
    // pas buka page, ambil semua favorite
    context.read<FavoriteBloc>().add(FavoriteEventGetAll());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Produk'),
      ),
      body: BlocBuilder<FavoriteBloc, FavoriteState>(
        builder: (context, state) {
          if (state is FavoriteStateLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is FavoriteStateLoadedAll) {
            final favorites = state.favorites;

            if (favorites.isEmpty) {
              return const Center(child: Text('Belum ada produk di favorite'));
            }

            return ListView.builder(
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                final favorite = favorites[index];

                return BlocProvider(
                  create: (context) => context.read<ProdukBloc>()..add(
                    ProdukEventGetById(id: favorite.produkId),
                  ),
                  child: BlocBuilder<ProdukBloc, ProdukState>(
                    builder: (context, productState) {
                      if (productState is ProdukStateLoading) {
                        return const ListTile(
                          title: Text('Loading produk...'),
                        );
                      } else if (productState is ProdukStateLoaded) {
                        final Produk product = productState.produk;
                        return ListTile(
                          title: Text(product.namaProduk),
                          subtitle: Text('Harga: Rp ${product.harga}'),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              context.read<FavoriteBloc>().add(
                                FavoriteEventDelete(id: favorite.id),
                              );
                            },
                          ),
                        );
                      } else if (productState is ProdukStateError) {
                        return ListTile(
                          title: Text('Gagal load produk (${productState.message})'),
                        );
                      } else {
                        return const SizedBox.shrink();
                      }
                    },
                  ),
                );
              },
            );
          } else if (state is FavoriteStateError) {
            return Center(child: Text('Error: ${state.message}'));
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
