import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/blocs/create_order/create_order_bloc.dart';
import 'package:shopping/blocs/create_order/create_order_event.dart';
import 'package:shopping/models/order_product_model.dart';

class OrderProductItem extends StatefulWidget {
  const OrderProductItem(
    this.orderProduct,
  );

  final OrderProduct orderProduct;

  @override
  State<StatefulWidget> createState() => _OrderProductItemState();
}

class _OrderProductItemState extends State<OrderProductItem> {
  late final CreateOrderBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = context.read();
  }

  void _increaseQuantity() => setState(() => widget.orderProduct.quantity++);
  void _decreaseQuantity() => setState(() => widget.orderProduct.quantity--);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(widget.orderProduct.product.id),
      onDismissed: (direction) {
        _bloc.add(
          RemoveOrderProductEvent(orderProduct: widget.orderProduct),
        );
      },
      confirmDismiss: (direction) async {
        return direction == DismissDirection.endToStart;
      },
      child: Card(
        elevation: 20,
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: ListTile(
          title: Text(widget.orderProduct.product.name),
          subtitle: Text(
            widget.orderProduct.product.description ?? 'No description',
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.remove),
                onPressed: _decreaseQuantity,
              ),
              Text('${widget.orderProduct.quantity}'),
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: _increaseQuantity,
              )
            ],
          ),
        ),
      ),
    );
  }
}
