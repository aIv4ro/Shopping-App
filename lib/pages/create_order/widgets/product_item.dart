import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/bloc/create_order/create_order_bloc.dart';
import 'package:shopping/bloc/create_order/create_order_event.dart';
import 'package:shopping/models/product_model.dart';

class ProductItem extends StatefulWidget {
  const ProductItem(this.product);

  final Product product;

  @override
  State<StatefulWidget> createState() => ProductItemState();
}

class ProductItemState extends State<ProductItem> {
  late final CreateOrderBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = context.read();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 20,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: ListTile(
        title: Text(widget.product.name),
        subtitle: Text(widget.product.description ?? 'No description'),
        trailing: TextButton(
          onPressed: () => _bloc.add(
            AddOrderProductEvent(product: widget.product),
          ),
          child: const Text('Add'),
        ),
      ),
    );
  }
}
