import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/blocs/pending_orders/pending_orders_bloc.dart';
import 'package:shopping/blocs/pending_orders/pending_orders_state.dart';
import 'package:shopping/ui/pages/pending_orders/widgets/pending_orders_item.dart';

class PendingOrdersPage extends StatefulWidget {
  const PendingOrdersPage({super.key});

  @override
  State<PendingOrdersPage> createState() => _PendingOrdersPageState();
}

class _PendingOrdersPageState extends State<PendingOrdersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pending Orders'),
      ),
      body: BlocBuilder<PendingOrdersBloc, PendingOrdersState>(
        builder: (context, state) {
          if (state.status == PendingOrdersStatus.loadingOrders) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView.separated(
            itemCount: state.orders.length,
            itemBuilder: (context, index) {
              final order = state.orders[index];

              return PendingOrderItem(
                order: order,
              );
            },
            separatorBuilder: (context, index) {
              return const Divider(thickness: 2);
            },
          );
        },
      ),
    );
  }
}
