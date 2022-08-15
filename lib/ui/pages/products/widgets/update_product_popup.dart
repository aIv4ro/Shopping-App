import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/blocs/products_bloc/products_bloc.dart';
import 'package:shopping/blocs/products_bloc/products_event.dart';
import 'package:shopping/blocs/products_bloc/products_state.dart';
import 'package:shopping/domain/entities/product_entity.dart';

class UpdateProductPopup extends StatefulWidget {
  const UpdateProductPopup({super.key, required this.product});
  final Product product;

  @override
  State<StatefulWidget> createState() => UpdateProductPopupState();
}

class UpdateProductPopupState extends State<UpdateProductPopup> {
  final _formKey = GlobalKey<FormState>();
  late final ProductsBloc _bloc;
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void initState() {
    _bloc = context.read();
    _nameController.text = widget.product.name;
    _descriptionController.text = widget.product.description ?? '';
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _handleCancelClick() => Navigator.of(context).pop();
  void _handleUpdateClick() {
    final isFormValid = _formKey.currentState?.validate() ?? false;
    if (isFormValid) {
      final name = _nameController.text;
      final description = _descriptionController.text;
      _bloc.add(
        UpdateProductEvent(
          product: Product(
            id: widget.product.id,
            name: name,
            description: description,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Update Product'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Name',
              ),
              validator: (value) => value != null && value.isNotEmpty
                  ? null
                  : "Name can't be empty",
              autovalidateMode: AutovalidateMode.onUserInteraction,
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'Description',
              ),
              autovalidateMode: AutovalidateMode.onUserInteraction,
            ),
          ],
        ),
      ),
      actions: [
        BlocBuilder<ProductsBloc, ProductsState>(
          builder: (context, state) {
            if (state.status == ProductsStatus.updatingProduct) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: _handleCancelClick,
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: _handleUpdateClick,
                  child: const Text('Update'),
                ),
              ],
            );
          },
        )
      ],
    );
  }
}
