import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/blocs/create_order/create_order_bloc.dart';
import 'package:shopping/blocs/create_order/create_order_event.dart';
import 'package:shopping/blocs/products_list/products_list_bloc.dart';
import 'package:shopping/blocs/products_list/products_list_event.dart';
import 'package:shopping/domain/entities/order_product_entity.dart';

class OrderProductItem extends StatefulWidget {
  const OrderProductItem({
    super.key,
    required this.orderProduct,
  });

  final OrderProduct orderProduct;

  @override
  State<OrderProductItem> createState() => _OrderProductItemState();
}

class _OrderProductItemState extends State<OrderProductItem> {
  late final ProductsListBloc productsListBloc;
  late final CreateOrderBloc createOrderBloc;

  @override
  void initState() {
    super.initState();
    productsListBloc = context.read();
    createOrderBloc = context.read();
  }

  void _increment() => setState(widget.orderProduct.increaseQuantity);
  void _decrease() => setState(widget.orderProduct.decreaseQuantity);

  @override
  Widget build(BuildContext context) {
    final product = widget.orderProduct.product;

    return Dismissible(
      key: Key(product.id),
      onDismissed: (direction) {
        createOrderBloc.add(
          RemoveOrderProductEvent(orderProduct: widget.orderProduct),
        );
        productsListBloc.add(
          AddProductEvent(product: product),
        );
      },
      confirmDismiss: (direction) async {
        return direction == DismissDirection.endToStart;
      },
      child: Material(
        elevation: 10,
        child: ListTile(
          title: Text(product.name),
          subtitle:
              product.description != null ? Text(product.description!) : null,
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: _increment,
                icon: const Icon(Icons.add),
              ),
              Text(widget.orderProduct.quantityFormatted),
              IconButton(
                onPressed: _decrease,
                icon: const Icon(Icons.remove),
              )
            ],
          ),
        ),
      ),
    );
  }
}
