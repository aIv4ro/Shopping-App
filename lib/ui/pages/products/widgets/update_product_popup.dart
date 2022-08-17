import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/blocs/products_bloc/products_bloc.dart';
import 'package:shopping/blocs/products_bloc/products_event.dart';
import 'package:shopping/blocs/products_bloc/products_state.dart';
import 'package:shopping/domain/entities/product_entity.dart';
import 'package:shopping/utils/validations.dart';

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
  final _unitController = TextEditingController();
  final _incrementController = TextEditingController();

  @override
  void initState() {
    _bloc = context.read();
    _nameController.text = widget.product.name;
    _descriptionController.text = widget.product.description ?? '';
    _unitController.text = widget.product.unit;
    _incrementController.text = widget.product.increment.toString();
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
      final unit = _unitController.text;
      final increment = _incrementController.text;

      _bloc.add(
        UpdateProductEvent(
          product: Product(
            id: widget.product.id,
            name: name,
            description: description.isEmpty ? null : description,
            unit: unit,
            increment: double.parse(increment),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Update Product'),
      scrollable: true,
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
            const SizedBox(height: 10),
            TextFormField(
              controller: _unitController,
              decoration: const InputDecoration(
                labelText: 'Unit',
              ),
              validator: EmptyValidator().validate,
              autovalidateMode: AutovalidateMode.onUserInteraction,
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _incrementController,
              decoration: const InputDecoration(
                labelText: 'Increment',
              ),
              validator: NumberValidator().validate,
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
