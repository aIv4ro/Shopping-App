import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopping/blocs/order/order_bloc.dart';
import 'package:shopping/blocs/order/order_state.dart';
import 'package:shopping/ui/pages/order/widgets/order_product_item.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping Cart'),
      ),
      body: BlocBuilder<OrderBloc, OrderState>(
        builder: (context, state) {
          if (state.status == OrderStatus.loadingOrder) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final order = state.order;
          final orderProducts = order.orderProducts;

          return Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Products',
                  style: GoogleFonts.nunito(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Expanded(
                  child: ListView.separated(
                    itemBuilder: (context, index) {
                      return OrderProductItem(orderProducts[index]);
                    },
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 10,
                    ),
                    itemCount: orderProducts.length,
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
