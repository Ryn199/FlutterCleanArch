import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterclean/features/ProductType/data/models/product_type_model.dart';
import 'package:flutterclean/features/ProductType/presentation/bloc/product_type_bloc.dart';
import 'package:flutterclean/features/ProductType/presentation/bloc/product_type_state.dart';
import 'package:go_router/go_router.dart';

class ProductTypePage extends StatelessWidget {
  const ProductTypePage({super.key});

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Type Pages'),
        actions: [
          IconButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    TextEditingController productTypeNameController =
                        TextEditingController();
                    TextEditingController descController =
                        TextEditingController();
                    return Container(
                      child: Column(
                        children: [
                          TextFormField(
                            controller: productTypeNameController,
                          ),
                          TextFormField(
                            controller: descController,
                          ),
                          BlocConsumer<ProductTypeBloc, ProductTypeState>(
                            listener: (context, state) {
                              if (state is ProductTypeStateError) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(state.message)));
                              }
                              if (state is ProductTypeStateSuccess) {
                                context.pop();
                                context
                                    .read<ProductTypeBloc>()
                                    .add(ProductTypeEventGetAll());
                              }
                            },
                            builder: (context, state) {
                              return IconButton(
                                  onPressed: () {
                                    context
                                        .read<ProductTypeBloc>()
                                        .add(ProductTypeEventAdd(
                                            productTypeModel: ProductTypeModel(
                                          id: '',
                                          productTypeName:
                                              productTypeNameController.text,
                                          desc: descController.text,
                                        )));
                                  },
                                  icon: state is ProductTypeStateLoading
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
      body: BlocConsumer<ProductTypeBloc, ProductTypeState>(
        bloc: context.read<ProductTypeBloc>()..add(ProductTypeEventGetAll()),
        listener: (context, state) {
          if (state is ProductTypeStateError) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          }
          if (state is ProductTypeStateSuccess) {
            context.read<ProductTypeBloc>().add(ProductTypeEventGetAll());
          }
        },
        builder: (context, state) {
          if (state is ProductTypeStateLoadedAll) {
            return ListView.builder(
              itemCount: state.productTypes.length,
              itemBuilder: (context, index) {
                var productType = state.productTypes[index];

                return ListTile(
                  title: Text(productType.productTypeName),
                  subtitle: Text(productType.desc),
                  trailing: SizedBox(
                    width: 100,
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            context
                                .read<ProductTypeBloc>()
                                .add(ProductTypeEventDelete(id: productType.id));
                          },
                          icon: Icon(Icons.delete, color: Colors.red),
                        ),
                        IconButton(
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              builder: (context) {
                                TextEditingController productTypeNameController =
                                    TextEditingController(
                                        text: productType.productTypeName);
                                TextEditingController descController =
                                    TextEditingController(text: productType.desc);

                                return Padding(
                                  padding: EdgeInsets.only(
                                      bottom: MediaQuery.of(context)
                                          .viewInsets
                                          .bottom),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      TextFormField(
                                          controller: productTypeNameController),
                                      TextFormField(controller: descController),
                                      BlocConsumer<ProductTypeBloc, ProductTypeState>(
                                        listener: (context, state) {
                                          if (state is ProductTypeStateError) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                                    content:
                                                        Text(state.message)));
                                          }
                                          if (state is ProductTypeStateSuccess) {
                                            context.pop();
                                            context
                                                .read<ProductTypeBloc>()
                                                .add(ProductTypeEventGetAll());
                                          }
                                        },
                                        builder: (context, state) {
                                          return IconButton(
                                            onPressed: () {
                                              context
                                                  .read<ProductTypeBloc>()
                                                  .add(ProductTypeEventEdit(
                                                    productTypeModel:
                                                        ProductTypeModel(
                                                      id: productType.id,
                                                      productTypeName:
                                                          productTypeNameController
                                                              .text,
                                                      desc: descController.text,
                                                    ),
                                                  ));
                                            },
                                            icon: state is ProductTypeStateLoading
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
          if (state is ProductTypeStateLoading) {
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
