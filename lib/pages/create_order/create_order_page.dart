import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shopping/bloc/create_order/create_order_bloc.dart';
import 'package:shopping/bloc/create_order/create_order_event.dart';
import 'package:shopping/bloc/create_order/create_order_state.dart';
import 'package:shopping/utils/validations.dart';
import 'package:shopping/widgets/expandable_fab.dart';
import 'package:shopping/widgets/search_field.dart';

const users = [
  'Alvaro',
  'Rodrigo',
  'Andres',
  'Carlos',
  'Sergio',
  'Pepe',
  'Maximiliano',
  'Jose',
  'Alvaro',
  'Rodrigo',
  'Andres',
  'Carlos',
  'Sergio',
  'Pepe',
  'Maximiliano',
  'Jose',
  'Alvaro',
  'Rodrigo',
  'Andres',
  'Carlos',
  'Sergio',
  'Pepe',
  'Maximiliano',
  'Jose',
  'Alvaro',
  'Rodrigo',
  'Andres',
  'Carlos',
  'Sergio',
  'Pepe',
  'Maximiliano',
  'Jose'
];

class CreateOrderPage extends StatefulWidget {
  const CreateOrderPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => CreateOrderPageState();
}

class CreateOrderPageState extends State<CreateOrderPage> {
  final formKey = GlobalKey<FormState>();
  final dateController = TextEditingController();
  final userController = TextEditingController();
  late final CreateOrderBloc _bloc;
  String? itemSelected;

  @override
  void initState() {
    super.initState();
    _bloc = context.read();
  }

  @override
  void dispose() {
    dateController.dispose();
    userController.dispose();
    super.dispose();
  }

  void _handleCreateProductPressed() {
    showDialog(
      context: context,
      builder: (context) {
        return _buildCreateProductPopup();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Order'),
      ),
      floatingActionButton: ExpandableFab(
        distance: 100,
        children: [
          ActionButton(
            icon: const Icon(Icons.shopping_basket_outlined),
            onPressed: () {},
            tooltip: 'Add Products',
          ),
          ActionButton(
            icon: const Icon(Icons.add),
            onPressed: _handleCreateProductPressed,
            tooltip: 'Create Product',
          ),
          ActionButton(
            icon: const Icon(Icons.check),
            onPressed: () {},
            tooltip: 'Create order',
          ),
        ],
      ),
      body: BlocListener<CreateOrderBloc, CreateOrderState>(
        listener: (context, state) {
          if(state.status == CreateOrderStatus.productCreated) {
            Navigator.of(context).pop();
          }
        },
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                SearchField<String>(
                  items: users,
                  labelText: 'Send to...',
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  match: (item, input) => item.contains(input),
                  buildItem: (item) {
                    return Container(
                      padding: const EdgeInsets.all(20),
                      width: double.infinity,
                      child: Text(item),
                    );
                  },
                  onItemSelected: (item) => itemSelected = item,
                  controller: userController,
                  itemSelectedString: (item) => item,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Date',
                      prefixIcon: Icon(Icons.calendar_today),
                    ),
                    controller: dateController,
                    readOnly: true,
                    onTap: () async {
                      final pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(const Duration(days: 365)),
                      );

                      if (pickedDate != null) {
                        final formatter = DateFormat.yMMMMEEEEd();
                        final dateFormatted = formatter.format(pickedDate);

                        dateController.text = dateFormatted;
                      }
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                BlocBuilder<CreateOrderBloc, CreateOrderState>(
                  builder: (context, state) {
                    return Column(
                      children: state.products.map((product) {
                        return ListTile(
                          title: Text(product.name),
                        );
                      }).toList(),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCreateProductPopup() {
    final nameController = TextEditingController();
    final descriptionController = TextEditingController();
    final productFormKey = GlobalKey<FormState>();

    return AlertDialog(
      title: const Text('Create Product'),
      content: Form(
        key: productFormKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Product name',
                ),
                controller: nameController,
                validator: ProductNameValidation().validate,
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Flexible(
              child: TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Description',
                ),
                controller: descriptionController,
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            final validationResult = productFormKey.currentState?.validate();

            if(validationResult != null && !validationResult) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Error, check fields'))
              );
            }

            _bloc.add(CreateProductEvent(name: nameController.text, description: descriptionController.text));
          },
          child: const Text('Accept'),
        ),
      ],
    );
  }
}
