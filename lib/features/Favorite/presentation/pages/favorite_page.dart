import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterclean/features/Favorite/presentation/bloc/favorite_bloc.dart';
import 'package:flutterclean/features/Favorite/presentation/bloc/favorite_state.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite'),
      ),
      body: BlocBuilder<FavoriteBloc, FavoriteState>(
        builder: (context, state) {
          if (state is FavoriteStateLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is FavoriteStateLoadedAll) {
            final favorites = state.favorites;
            if (favorites.isEmpty) {
              return Center(child: Text('Belum ada favorite.'));
            }
            return ListView.builder(
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                final favorite = favorites[index];
                return ListTile(
                  title: Text(favorite.produkId),
                );
              },
            );
          } else if (state is FavoriteStateError) {
            return Center(child: Text('Error: ${state.message}'));
          }
          return Center(child: Text('Belum ada data.'));
        },
      ),
    );
  }
}
