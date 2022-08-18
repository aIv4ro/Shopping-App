import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/blocs/create_order/create_order_bloc.dart';
import 'package:shopping/blocs/create_order/create_order_event.dart';
import 'package:shopping/blocs/create_order/create_order_state.dart';
import 'package:shopping/blocs/products_list/products_list_bloc.dart';
import 'package:shopping/blocs/products_list/products_list_event.dart';
import 'package:shopping/ui/pages/create-order/widgets/order_product_item.dart';

class BackLayer extends StatefulWidget {
  const BackLayer({super.key});

  @override
  State<BackLayer> createState() => _BackLayerState();
}

class _BackLayerState extends State<BackLayer> {
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
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextFormField(),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextFormField(),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Added products',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 50),
                itemBuilder: (context, index) {
                  final orderProduct = state.orderProducts[index];

                  return OrderProductItem(
                    orderProduct: orderProduct,
                  );
                },
                separatorBuilder: (context, index) => const SizedBox(
                  height: 10,
                ),
                itemCount: state.orderProducts.length,
              ),
            ),
          ],
        );
      },
    );
  }
}
