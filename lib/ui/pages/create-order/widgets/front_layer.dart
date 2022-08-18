import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/blocs/create_order/create_order_bloc.dart';
import 'package:shopping/blocs/create_order/create_order_event.dart';
import 'package:shopping/blocs/create_order/create_order_state.dart';
import 'package:shopping/blocs/products_list/products_list_bloc.dart';
import 'package:shopping/blocs/products_list/products_list_event.dart';

class FrontLayer extends StatefulWidget {
  const FrontLayer({super.key});

  @override
  State<FrontLayer> createState() => _FrontLayerState();
}

class _FrontLayerState extends State<FrontLayer> {
  late final CreateOrderBloc _createOrderBloc;
  late final ProductsListBloc _productsListBloc;

  @override
  void initState() {
    super.initState();
    _createOrderBloc = context.read();
    _productsListBloc = context.read();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateOrderBloc, CreateOrderState>(
      builder: (context, state) {
        return ListView.separated(
          itemBuilder: (context, index) {
            final orderProduct = state.orderProducts[index];
            final product = orderProduct.product;

            return Dismissible(
              key: Key(product.id),
              onDismissed: (direction) {
                _createOrderBloc.add(
                  RemoveOrderProductEvent(orderProduct: orderProduct),
                );
                _productsListBloc.add(
                  AddProductEvent(product: product),
                );
              },
              confirmDismiss: (direction) async {
                return direction == DismissDirection.endToStart;
              },
              child: ListTile(
                title: Text(product.name),
                subtitle: product.description != null
                    ? Text(product.description!)
                    : null,
              ),
            );
          },
          separatorBuilder: (context, index) => const Divider(
            thickness: 2,
          ),
          itemCount: state.orderProducts.length,
        );
      },
    );
  }
}
