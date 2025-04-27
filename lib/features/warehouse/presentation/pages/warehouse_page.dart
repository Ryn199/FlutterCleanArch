import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterclean/features/warehouse/data/models/warehouse_model.dart';
import 'package:flutterclean/features/warehouse/presentation/bloc/warehouse_bloc.dart';
import 'package:flutterclean/features/warehouse/presentation/bloc/warehouse_event.dart';
import 'package:flutterclean/features/warehouse/presentation/bloc/warehouse_state.dart';
import 'package:go_router/go_router.dart';

class WarehousePage extends StatelessWidget {
  const WarehousePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Warehouse Pages'),
        actions: [
          IconButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    TextEditingController warehouseNameController =
                        TextEditingController();
                    TextEditingController addressController =
                        TextEditingController();
                    TextEditingController capacityController =
                        TextEditingController();
                    TextEditingController descController =
                        TextEditingController();
                    return Container(
                      child: Column(
                        children: [
                          TextFormField(
                            controller: warehouseNameController,
                          ),
                          TextFormField(
                            controller: addressController,
                          ),
                          TextFormField(
                            controller: capacityController,
                          ),
                          TextFormField(
                            controller: descController,
                          ),
                          BlocConsumer<WarehouseBloc, WarehouseState>(
                            listener: (context, state) {
                              if (state is WarehouseStateError) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(state.message)));
                              }
                              if (state is WarehouseStateSuccess) {
                                context.pop();
                                context
                                    .read<WarehouseBloc>()
                                    .add(WarehouseEventGetAll());
                              }
                            },
                            builder: (context, state) {
                              return IconButton(
                                  onPressed: () {
                                    context
                                        .read<WarehouseBloc>()
                                        .add(WarehouseEventAdd(
                                            warehouseModel: WarehouseModel(
                                          id: '',
                                          warehouseName:
                                              warehouseNameController.text,
                                          address: addressController.text,
                                          capacity: capacityController.text,
                                          desc: descController.text,
                                        )));
                                  },
                                  icon: state is WarehouseStateLoading
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
      body: BlocConsumer<WarehouseBloc, WarehouseState>(
        bloc: context.read<WarehouseBloc>()..add(WarehouseEventGetAll()),
        listener: (context, state) {
          if (state is WarehouseStateError) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          }
          if (state is WarehouseStateSuccess) {
            context.read<WarehouseBloc>().add(WarehouseEventGetAll());
          }
        },
        builder: (context, state) {
          if (state is WarehouseStateLoadedAll) {
            return ListView.builder(
              itemCount: state.warehouses.length,
              itemBuilder: (context, index) {
                var warehouse = state.warehouses[index];

                return ListTile(
                  title: Text(warehouse.warehouseName),
                  subtitle: Text(warehouse.desc),
                  trailing: SizedBox(
                    width: 100,
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            context
                                .read<WarehouseBloc>()
                                .add(WarehouseEventDelete(id: warehouse.id));
                          },
                          icon: Icon(Icons.delete, color: Colors.red),
                        ),
                        IconButton(
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              builder: (context) {
                                TextEditingController warehouseNameController =
                                    TextEditingController();
                                TextEditingController addressController =
                                    TextEditingController();
                                TextEditingController capacityController =
                                    TextEditingController();
                                TextEditingController descController =
                                    TextEditingController();

                                return Padding(
                                  padding: EdgeInsets.only(
                                      bottom: MediaQuery.of(context)
                                          .viewInsets
                                          .bottom),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      TextFormField(
                                        controller: warehouseNameController,
                                      ),
                                      TextFormField(
                                        controller: addressController,
                                      ),
                                      TextFormField(
                                        controller: capacityController,
                                      ),
                                      TextFormField(
                                        controller: descController,
                                      ),
                                      BlocConsumer<WarehouseBloc,
                                          WarehouseState>(
                                        listener: (context, state) {
                                          if (state is WarehouseStateError) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                                    content:
                                                        Text(state.message)));
                                          }
                                          if (state is WarehouseStateSuccess) {
                                            context.pop();
                                            context
                                                .read<WarehouseBloc>()
                                                .add(WarehouseEventGetAll());
                                          }
                                        },
                                        builder: (context, state) {
                                          return IconButton(
                                            onPressed: () {
                                              context
                                                  .read<WarehouseBloc>()
                                                  .add(WarehouseEventEdit(
                                                    warehouseModel:
                                                        WarehouseModel(
                                                      id: warehouse.id,
                                                      warehouseName: warehouseNameController.text,
                                                      address: addressController.text,
                                                      capacity: capacityController.text,
                                                      desc: descController.text,
                                                    ),
                                                  ));
                                            },
                                            icon: state is WarehouseStateLoading
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
          if (state is WarehouseStateLoading) {
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
