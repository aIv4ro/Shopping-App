import 'package:backdrop/backdrop.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/blocs/create_order/create_order_bloc.dart';
import 'package:shopping/blocs/create_order/create_order_event.dart';
import 'package:shopping/blocs/create_order/create_order_state.dart';
import 'package:shopping/blocs/products_list/products_list_bloc.dart';
import 'package:shopping/blocs/products_list/products_list_event.dart';
import 'package:shopping/ui/pages/create-order/widgets/back_layer.dart';
import 'package:shopping/ui/pages/create-order/widgets/front_layer.dart';
import 'package:shopping/ui/paths.dart';
import 'package:shopping/ui/widgets/search_bar.dart';

class CreateOrderPage extends StatefulWidget {
  const CreateOrderPage({super.key});

  @override
  State<CreateOrderPage> createState() => _CreateOrderPageState();
}

class _CreateOrderPageState extends State<CreateOrderPage> {
  late final ProductsListBloc _productsListBloc;
  late final CreateOrderBloc _createOrderBloc;
  final _formKey = GlobalKey<FormState>();
  final _backLayerKey = GlobalKey<BackLayerState>();

  @override
  void initState() {
    super.initState();
    _productsListBloc = context.read();
    _createOrderBloc = context.read();
  }

  void _handleFilterChange(String value) {
    _productsListBloc.add(FilterChangeEvent(newFilterValue: value));
  }

  void _showSnackbarMessage({
    required String message,
    SnackBarAction? action,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        action: action,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CreateOrderBloc, CreateOrderState>(
      listener: (context, state) {
        if (state.status == CreateOrderStatus.orderCreated) {
          _showSnackbarMessage(
            message: 'Order created',
            action: SnackBarAction(
              label: 'Go',
              onPressed: () {
                Navigator.of(context).pushReplacementNamed(
                  order,
                  arguments: state.createdOrder!.id,
                );
              },
            ),
          );
          return;
        }

        if (state.status == CreateOrderStatus.orderCreationError) {
          _showSnackbarMessage(message: 'Could not create order');
          return;
        }
      },
      child: BackdropScaffold(
        frontLayerActiveFactor: .95,
        backLayerBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
        frontLayerBackgroundColor: Theme.of(context).backgroundColor,
        appBar: SearchBar(
          title: 'Create order',
          actions: const [
            BackdropToggleButton(
              icon: AnimatedIcons.menu_close,
            )
          ],
          onFilterChanged: _handleFilterChange,
        ),
        floatingActionButton: BlocBuilder<CreateOrderBloc, CreateOrderState>(
          builder: (context, state) {
            final isLoading = state.status == CreateOrderStatus.creatingOrder;
            return FloatingActionButton(
              onPressed: isLoading ? null : () => _handleSubmit(state: state),
              child: isLoading
                  ? const CircularProgressIndicator()
                  : const Icon(Icons.check),
            );
          },
        ),
        subHeader: const Padding(
          padding: EdgeInsets.only(left: 10, top: 20, bottom: 10),
          child: Text(
            'Products',
            style: TextStyle(fontSize: 20),
          ),
        ),
        backLayer: Form(
          key: _formKey,
          child: BackLayer(
            key: _backLayerKey,
          ),
        ),
        frontLayer: const FrontLayer(),
      ),
    );
  }

  void _handleSubmit({
    required CreateOrderState state,
  }) {
    final isFormValid = _formKey.currentState?.validate() ?? false;
    if (!isFormValid) {
      return;
    }

    final date = _backLayerKey.currentState?.selectedDate;
    final user = _backLayerKey.currentState?.selectedUser;

    _createOrderBloc.add(PostOrderEvent(toUser: user!, date: date!));
  }
}
