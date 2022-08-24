import 'package:flutter/material.dart';
import 'package:shopping/domain/entities/order_product_entity.dart';
import 'package:shopping/domain/entities/product_entity.dart';

class OrderProductItem extends StatefulWidget {
  const OrderProductItem(this.orderProduct, {super.key});

  final OrderProduct orderProduct;

  @override
  State<OrderProductItem> createState() => _OrderProductItemState();
}

class _OrderProductItemState extends State<OrderProductItem> {
  late final OrderProduct orderProduct;
  late final Product product;

  @override
  void initState() {
    super.initState();
    orderProduct = widget.orderProduct;
    product = orderProduct.product;
  }

  void _increase() => setState(orderProduct.increaseQuantity);
  void _decrease() => setState(orderProduct.decreaseQuantity);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(product.name),
                if (product.description != null) ...[
                  const SizedBox(
                    height: 10,
                  ),
                  Text(product.description!),
                ],
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: _increase,
                  icon: const Icon(Icons.add),
                ),
                Text(orderProduct.quantityFormatted),
                IconButton(
                  onPressed: _decrease,
                  icon: const Icon(Icons.remove),
                ),
              ],
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.delete),
            ),
          ],
        ),
      ),
    );
  }
}
