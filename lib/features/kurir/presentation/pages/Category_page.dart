import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterclean/features/ProductCategory/data/models/category_model.dart';
import 'package:flutterclean/features/ProductCategory/presentation/bloc/category_bloc.dart';
import 'package:flutterclean/features/ProductCategory/presentation/bloc/category_state.dart';
import 'package:go_router/go_router.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Category Pages'),
        actions: [
          IconButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    TextEditingController categoryNameController =
                        TextEditingController();
                    TextEditingController descController =
                        TextEditingController();
                    return Container(
                      child: Column(
                        children: [
                          TextFormField(
                            controller: categoryNameController,
                          ),
                          TextFormField(
                            controller: descController,
                          ),
                          BlocConsumer<CategoryBloc, CategoryState>(
                            listener: (context, state) {
                              if (state is CategoryStateError) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(state.message)));
                              }
                              if (state is CategoryStateSuccess) {
                                context.pop();
                                context
                                    .read<CategoryBloc>()
                                    .add(CategoryEventGetAll());
                              }
                            },
                            builder: (context, state) {
                              return IconButton(
                                  onPressed: () {
                                    context
                                        .read<CategoryBloc>()
                                        .add(CategoryEventAdd(
                                            categoryModel: CategoryModel(
                                          id: '',
                                          categoryName:
                                              categoryNameController.text,
                                          desc: descController.text,
                                        )));
                                  },
                                  icon: state is CategoryStateLoading
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
      body: BlocConsumer<CategoryBloc, CategoryState>(
        bloc: context.read<CategoryBloc>()..add(CategoryEventGetAll()),
        listener: (context, state) {
          if (state is CategoryStateError) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          }
          if (state is CategoryStateSuccess) {
            context.read<CategoryBloc>().add(CategoryEventGetAll());
          }
        },
        builder: (context, state) {
          if (state is CategoryStateLoadedAll) {
            return ListView.builder(
              itemCount: state.categories.length,
              itemBuilder: (context, index) {
                var category = state.categories[index];

                return ListTile(
                  title: Text(category.categoryName),
                  subtitle: Text(category.desc),
                  trailing: SizedBox(
                    width: 100,
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            context
                                .read<CategoryBloc>()
                                .add(CategoryEventDelete(id: category.id));
                          },
                          icon: Icon(Icons.delete, color: Colors.red),
                        ),
                        IconButton(
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              builder: (context) {
                                TextEditingController categoryNameController =
                                    TextEditingController(
                                        text: category.categoryName);
                                TextEditingController descController =
                                    TextEditingController(text: category.desc);

                                return Padding(
                                  padding: EdgeInsets.only(
                                      bottom: MediaQuery.of(context)
                                          .viewInsets
                                          .bottom),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      TextFormField(
                                          controller: categoryNameController),
                                      TextFormField(controller: descController),
                                      BlocConsumer<CategoryBloc, CategoryState>(
                                        listener: (context, state) {
                                          if (state is CategoryStateError) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                                    content:
                                                        Text(state.message)));
                                          }
                                          if (state is CategoryStateSuccess) {
                                            context.pop();
                                            context
                                                .read<CategoryBloc>()
                                                .add(CategoryEventGetAll());
                                          }
                                        },
                                        builder: (context, state) {
                                          return IconButton(
                                            onPressed: () {
                                              context
                                                  .read<CategoryBloc>()
                                                  .add(CategoryEventEdit(
                                                    categoryModel:
                                                        CategoryModel(
                                                      id: category.id,
                                                      categoryName:
                                                          categoryNameController
                                                              .text,
                                                      desc: descController.text,
                                                    ),
                                                  ));
                                            },
                                            icon: state is CategoryStateLoading
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
                      ],
                    ),
                  ),
                );
              },
            );
          }
          if (state is CategoryStateLoading) {
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
