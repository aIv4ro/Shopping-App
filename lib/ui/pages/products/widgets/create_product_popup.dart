import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/blocs/products_bloc/products_bloc.dart';
import 'package:shopping/blocs/products_bloc/products_event.dart';
import 'package:shopping/blocs/products_bloc/products_state.dart';

class CreateProductPopup extends StatefulWidget {
  const CreateProductPopup({super.key});

  @override
  State<StatefulWidget> createState() => CreateProductPopupState();
}

class CreateProductPopupState extends State<CreateProductPopup> {
  final _formKey = GlobalKey<FormState>();
  late final ProductsBloc _bloc;
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void initState() {
    _bloc = context.read();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _handleCancelClick() => Navigator.of(context).pop();
  void _handleCreateClick() {
    final isFormValid = _formKey.currentState?.validate() ?? false;
    if (isFormValid) {
      final name = _nameController.text;
      final description = _descriptionController.text;
      _bloc.add(
        CreateProductEvent(
          name: name,
          description: description.isEmpty ? null : description,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Create Product'),
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
                  onPressed: _handleCreateClick,
                  child: const Text('Create'),
                ),
              ],
            );
          },
        )
      ],
    );
  }
}
