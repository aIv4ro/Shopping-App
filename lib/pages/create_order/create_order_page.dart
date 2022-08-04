import 'package:backdrop/backdrop.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shopping/bloc/create_order/create_order_bloc.dart';
import 'package:shopping/bloc/create_order/create_order_event.dart';
import 'package:shopping/bloc/create_order/create_order_state.dart';
import 'package:shopping/models/user_model.dart';
import 'package:shopping/pages/create_order/widgets/order_product_item.dart';
import 'package:shopping/pages/create_order/widgets/product_item.dart';
import 'package:shopping/utils/validations.dart';
import 'package:shopping/widgets/expandable_fab.dart';
import 'package:shopping/widgets/search_field.dart';

class CreateOrderPage extends StatefulWidget {
  const CreateOrderPage({super.key});

  @override
  State<StatefulWidget> createState() => CreateOrderPageState();
}

class CreateOrderPageState extends State<CreateOrderPage> {
  final formKey = GlobalKey<FormState>();
  final dateController = TextEditingController();
  final userController = TextEditingController();
  late final CreateOrderBloc _bloc;
  User? itemSelected;

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

  Future<void> _showDateTimePicker() async {
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
  }

  @override
  Widget build(BuildContext context) {
    return BackdropScaffold(
      frontLayerActiveFactor: .9,
      revealBackLayerAtStart: true,
      backLayerBackgroundColor: Theme.of(context).colorScheme.onPrimary,
      frontLayerBackgroundColor: const Color(0xFFf5ebe0),
      appBar: AppBar(
        title: const Text('Create Order'),
        actions: const [
          BackdropToggleButton(
            icon: AnimatedIcons.menu_close,
          )
        ],
      ),
      subHeader: Padding(
        padding: const EdgeInsets.all(10),
        child: Text(
          'Products',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      floatingActionButton: ExpandableFab(
        distance: 100,
        children: [
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
      backLayer: _buildBackLayer(),
      frontLayer: _buildFrontLayer(),
    );
  }

  Widget _buildBackLayer() {
    return BlocListener<CreateOrderBloc, CreateOrderState>(
      listener: (context, state) {
        if (state.status == CreateOrderStatus.productCreated) {
          Navigator.of(context).pop();
        }
      },
      child: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              BlocBuilder<CreateOrderBloc, CreateOrderState>(
                buildWhen: (previous, current) {
                  return previous.users != current.users;
                },
                builder: (context, state) {
                  return SearchField<User>(
                    items: state.users,
                    labelText: 'Send to...',
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    match: (item, input) => item.fullName
                        .toLowerCase()
                        .contains(input.toLowerCase()),
                    buildItem: (item) {
                      return Container(
                        padding: const EdgeInsets.all(20),
                        width: double.infinity,
                        child: Text(item.fullName),
                      );
                    },
                    onItemSelected: (item) => itemSelected = item,
                    controller: userController,
                    itemSelectedString: (item) => item.fullName,
                  );
                },
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
                  onTap: _showDateTimePicker,
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              BlocBuilder<CreateOrderBloc, CreateOrderState>(
                buildWhen: (previous, current) {
                  return previous.orderProducts != current.orderProducts;
                },
                builder: (context, state) {
                  if (state.status == CreateOrderStatus.initalLoad) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Text(
                          'Added products',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ...state.orderProducts.map(OrderProductItem.new).toList(),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFrontLayer() {
    return BlocBuilder<CreateOrderBloc, CreateOrderState>(
      buildWhen: (previous, current) {
        return previous.products != current.products;
      },
      builder: (context, state) {
        return SingleChildScrollView(
          child: Column(
            children: state.products.map(ProductItem.new).toList(),
          ),
        );
      },
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
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            final validationResult = productFormKey.currentState?.validate();

            if (validationResult != null && !validationResult) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Error, check fields')),
              );
            }

            _bloc.add(
              CreateProductEvent(
                name: nameController.text,
                description: descriptionController.text,
              ),
            );
          },
          child: const Text('Accept'),
        ),
      ],
    );
  }
}
