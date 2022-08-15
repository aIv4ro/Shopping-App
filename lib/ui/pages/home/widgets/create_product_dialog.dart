import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/blocs/home/home_bloc.dart';
import 'package:shopping/blocs/home/home_event.dart';

class CreateProductPopup extends StatefulWidget {
  const CreateProductPopup({super.key});

  @override
  State<StatefulWidget> createState() => CreateProductPopupState();
}

class CreateProductPopupState extends State<CreateProductPopup> {
  final _formKey = GlobalKey<FormState>();
  late final HomeBloc _bloc;
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void initState() {
    _bloc = context.read();
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _handleCancelClick() => Navigator.of(context).pop();
  void _handleAcceptClick() {
    final isFormValid = _formKey.currentState?.validate() ?? false;
    if (isFormValid) {
      final name = _nameController.text;
      final description = _descriptionController.text;
      _bloc.add(
        CreateProductEvent(name: name, description: description),
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
        TextButton(
          onPressed: _handleCancelClick,
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: _handleAcceptClick,
          child: const Text('Create'),
        ),
      ],
    );
  }
}
