import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopping/blocs/create_order/create_order_bloc.dart';
import 'package:shopping/blocs/create_order/create_order_event.dart';
import 'package:shopping/blocs/products_list/products_list_bloc.dart';
import 'package:shopping/blocs/products_list/products_list_event.dart';
import 'package:shopping/domain/entities/product_entity.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({
    super.key,
    required this.product,
    required this.productsListBloc,
    required this.createOrderBloc,
  });

  final Product product;
  final ProductsListBloc productsListBloc;
  final CreateOrderBloc createOrderBloc;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(product.name),
      subtitle: product.description == null ? null : Text(product.description!),
      trailing: TextButton(
        onPressed: () {
          productsListBloc.add(RemoveProductEvent(product: product));
          createOrderBloc.add(AddOrderProductEvent(product: product));
        },
        child: const Text('Add'),
      ),
    );
  }
}
