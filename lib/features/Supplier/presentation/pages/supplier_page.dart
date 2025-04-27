import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterclean/features/Supplier/data/models/supplier_model.dart';
import 'package:flutterclean/features/Supplier/presentation/bloc/supplier_bloc.dart';
import 'package:flutterclean/features/Supplier/presentation/bloc/supplier_state.dart';
import 'package:go_router/go_router.dart';

class SupplierPage extends StatelessWidget {
  const SupplierPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Supplier Pages'),
        actions: [
          IconButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    TextEditingController supplierNameController =
                        TextEditingController();
                    TextEditingController addressController =
                        TextEditingController();
                    TextEditingController emailController =
                        TextEditingController();
                    TextEditingController phoneController =
                        TextEditingController();
                    TextEditingController descController =
                        TextEditingController();
                    return Container(
                      child: ListView(
                        children: [
                          Text("Nama Supplier"),
                          TextFormField(
                            controller: supplierNameController,
                          ),
                          Text("Alamat Supplier"),
                          TextFormField(
                            controller: addressController,
                          ),
                          Text("Email Supplier"),
                          TextFormField(
                            controller: emailController,
                          ),
                          Text("Nomor Hp Supplier"),
                          TextFormField(
                            controller: phoneController,
                          ),
                          Text("Deskripsi"),
                          TextFormField(
                            controller: descController,
                          ),
                          BlocConsumer<SupplierBloc, SupplierState>(
                            listener: (context, state) {
                              if (state is SupplierStateError) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(state.message)));
                              }
                              if (state is SupplierStateSuccess) {
                                context.pop();
                                context
                                    .read<SupplierBloc>()
                                    .add(SupplierEventGetAll());
                              }
                            },
                            builder: (context, state) {
                              return IconButton(
                                  onPressed: () {
                                    context
                                        .read<SupplierBloc>()
                                        .add(SupplierEventAdd(
                                            supplierModel: SupplierModel(
                                          id: '',
                                          supplierName: supplierNameController.text,
                                          address: addressController.text,
                                          email: emailController.text,
                                          phone: phoneController.text,
                                          desc: descController.text,
                                        )));
                                  },
                                  icon: state is SupplierStateLoading
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
      body: BlocConsumer<SupplierBloc, SupplierState>(
        bloc: context.read<SupplierBloc>()..add(SupplierEventGetAll()),
        listener: (context, state) {
          if (state is SupplierStateError) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          }
          if (state is SupplierStateSuccess) {
            context.read<SupplierBloc>().add(SupplierEventGetAll());
          }
        },
        builder: (context, state) {
          if (state is SupplierStateLoadedAll) {
            return ListView.builder(
              itemCount: state.suppliers.length,
              itemBuilder: (context, index) {
                var supplier = state.suppliers[index];

                return ListTile(
                  title: Text(supplier.supplierName),
                  subtitle: Text(supplier.email),
                  trailing: SizedBox(
                    width: 100,
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            context
                                .read<SupplierBloc>()
                                .add(SupplierEventDelete(id: supplier.id));
                          },
                          icon: Icon(Icons.delete, color: Colors.red),
                        ),
                        IconButton(
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              builder: (context) {
                                TextEditingController supplierNameController =
                                    TextEditingController(text: supplier.supplierName);
                                TextEditingController addressController =
                                    TextEditingController(text: supplier.address);
                                TextEditingController emailController=
                                    TextEditingController(text: supplier.email);
                                TextEditingController phoneController =
                                    TextEditingController(text: supplier.phone);
                                TextEditingController descController =
                                    TextEditingController(text: supplier.desc);

                                return Padding(
                                  padding: EdgeInsets.only(
                                      bottom: MediaQuery.of(context)
                                          .viewInsets
                                          .bottom),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text("Nama Supplier"),
                                      TextFormField(controller: supplierNameController,),
                                      Text("Alamat Supplier"),
                                      TextFormField(controller: addressController),
                                      Text("Email Supplier"),
                                      TextFormField(controller: emailController),
                                      Text("Nomor Telepon Supplier"),
                                      TextFormField(controller: phoneController),
                                      Text("Deskripsi"),
                                      TextFormField(controller: descController),
                                      BlocConsumer<SupplierBloc, SupplierState>(
                                        listener: (context, state) {
                                          if (state is SupplierStateError) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                                    content:
                                                        Text(state.message)));
                                          }
                                          if (state is SupplierStateSuccess) {
                                            context.pop();
                                            context
                                                .read<SupplierBloc>()
                                                .add(SupplierEventGetAll());
                                          }
                                        },
                                        builder: (context, state) {
                                          return IconButton(
                                            onPressed: () {
                                              context
                                                  .read<SupplierBloc>()
                                                  .add(SupplierEventEdit(
                                                    supplierModel:
                                                        SupplierModel(
                                                      id: supplier.id,
                                                      supplierName: supplierNameController.text,
                                                      address: addressController.text,
                                                      email: emailController.text,
                                                      phone: phoneController.text,
                                                      desc: descController.text,
                                                    ),
                                                  ));
                                            },
                                            icon: state is SupplierStateLoading
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
          if (state is SupplierStateLoading) {
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
